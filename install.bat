@echo off
echo Compilando o aplicativo PlayTV...
cordova build android

set APK_PATH=platforms\android\app\build\outputs\apk\debug\app-debug.apk

if exist %APK_PATH% (
    echo APK gerado com sucesso em: %APK_PATH%
    echo Instalando no dispositivo conectado...
    adb install -r %APK_PATH%
    echo Instalacao concluida!
) else (
    echo Erro: APK nao foi gerado. Verifique os requisitos de compilacao no README.md
)
