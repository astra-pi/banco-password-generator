#!/bin/bash
while true; do
    echo "=== Generador de Contraseñas ==="
    echo "1. Generar una contraseña"
    echo "2. Salir"
    read -p "Elige una opción: " opcion

    case $opcion in
        1)
            # Pedir longitud
            read -p "Introduce la longitud de la contraseña (8-32): " longitud
            if [[ ! $longitud =~ ^[0-9]+$ ]] || [[ $longitud -lt 8 ]] || [[ $longitud -gt 32 ]]; then
                echo "Error: La longitud debe estar entre 8 y 32."
                continue
            fi

            # Preguntar sobre caracteres
            read -p "¿Incluir mayúsculas? (s/n): " mayusculas
            read -p "¿Incluir números? (s/n): " numeros
            read -p "¿Incluir caracteres especiales? (s/n): " especiales

            # Validar selección
            if [[ $mayusculas != "s" && $numeros != "s" && $especiales != "s" ]]; then
                echo "Error: Debes incluir al menos un tipo de carácter."
                continue
            fi

            # Generar conjuntos de caracteres
            minusculas="abcdefghijklmnopqrstuvwxyz"
            caracteres="$minusculas"

            if [[ $mayusculas == "s" ]]; then caracteres+="ABCDEFGHIJKLMNOPQRSTUVWXYZ"; fi
            if [[ $numeros == "s" ]]; then caracteres+="0123456789"; fi
            if [[ $especiales == "s" ]]; then caracteres+="!@#$%^&*()-_=+[]{}|;:,.<>?/\\"; fi

            # Generar contraseña
            password=""
            for ((i = 0; i < longitud; i++)); do
                rand=$((RANDOM % ${#caracteres}))
                password+="${caracteres:$rand:1}"
            done

            echo "Tu contraseña generada es: $password"
            sleep 5
            ;;
        2)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida. Inténtalo de nuevo."
            ;;
    esac
done
