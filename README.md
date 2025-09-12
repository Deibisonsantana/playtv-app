# PlayTV App

Este é um aplicativo Android para o site PlayTV, criado usando Apache Cordova.

## Requisitos para compilação

- Node.js e npm (já instalados)
- JDK 8 (Java Development Kit)
- Android SDK
- Cordova CLI (já instalado)

## Como compilar o APK

1. Instale o JDK 8 a partir de: https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

2. Configure as variáveis de ambiente:
   - JAVA_HOME: apontando para o diretório de instalação do JDK
   - ANDROID_HOME ou ANDROID_SDK_ROOT: apontando para o diretório de instalação do Android SDK
   - Adicione os diretórios de ferramentas do Android SDK ao PATH

3. Execute o comando para compilar o APK:
   ```
   cordova build android
   ```

4. O arquivo APK será gerado em:
   ```
   platforms/android/app/build/outputs/apk/debug/app-debug.apk
   ```

## Estrutura do projeto

- `www/`: Contém os arquivos do site convertido para aplicativo
- `platforms/`: Contém os arquivos específicos da plataforma Android
- `plugins/`: Contém os plugins Cordova utilizados no projeto
- `config.xml`: Arquivo de configuração do Cordova

## Plugins utilizados

- cordova-plugin-whitelist: Para permitir acesso a recursos externos
- cordova-plugin-splashscreen: Para exibir uma tela de splash ao iniciar o aplicativo
- cordova-plugin-statusbar: Para controlar a barra de status do Android

## Observações

Este aplicativo é uma versão móvel do site PlayTV, adaptado para funcionar como um aplicativo Android nativo.
