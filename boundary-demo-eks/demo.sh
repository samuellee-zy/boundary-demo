#!/usr/bin/env zsh

case $1 in
    encrypt)
        echo "Encrypting the following text: $2"
        output=$(vault write transit/encrypt/demo_key plaintext=$(base64 <<< "$2"))
        echo $output
        encrypted_val=$(echo "$output" | awk '/ciphertext/ { print $2 }')
    ;;
    decrypt)
        echo "Decrypting the following value: $2"
        d_output=$(vault write transit/decrypt/demo_key ciphertext=$2)
        echo $d_output
    ;;
    decode)
        plaintext_val=$(base64 --decode <<< "$2")
        echo $plaintext_val
    ;;
    rotate)
        vault write -f transit/keys/demo_key/rotate
    ;;
    kvv2)
        filtered_args=()
        for arg in "$@"; do
            if [[ $arg == $1 || $arg == $2  ]]; then
                continue
            fi
        filtered_args+=("$arg")
        done

        while read key value; do
            vault kv put kvv2/$2 $key $value
        done <<< "${filtered_args[@]}"
    ;;
esac