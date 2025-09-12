#!/bin/bash

# Script para instalar o APK no dispositivo Android

echo "Compilando o aplicativo PlayTV..."
cordova build android

APK_PATH="platforms/android/app/build/outputs/apk/debug/app-debug.apk"

if [ -f "$APK_PATH" ]; then
    echo "APK gerado com sucesso em: $APK_PATH"
    echo "Instalando no dispositivo conectado..."
    adb install -r "$APK_PATH"
    echo "Instalação concluída!"
else
    echo "Erro: APK não foi gerado. Verifique os requisitos de compilação no README.md"
fi
