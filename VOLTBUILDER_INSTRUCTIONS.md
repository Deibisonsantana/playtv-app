# Instruções para Gerar o APK usando VoltBuilder

## O que é o VoltBuilder?

VoltBuilder é um serviço online que permite gerar APKs para Android e IPAs para iOS sem precisar do JDK ou Android SDK instalados localmente. É uma alternativa ao PhoneGap Build (que foi descontinuado).

## Como gerar o APK

1. Acesse o site do VoltBuilder: https://volt.build/
2. Crie uma conta gratuita (oferece 15 dias de teste)
3. Compacte (ZIP) os seguintes arquivos e pastas do seu projeto:
   - A pasta `www`
   - O arquivo `config.xml`
   - O arquivo `voltbuilder.json` (já criado)
   - A pasta `plugins` (se existir)

4. Faça upload do arquivo ZIP no VoltBuilder
5. Selecione a plataforma Android
6. Clique em "Build" para iniciar o processo
7. Após a conclusão, você poderá baixar o APK gerado

## Estrutura do arquivo ZIP

O arquivo ZIP deve ter a seguinte estrutura:

```
/www/           (pasta com todos os arquivos web)
/plugins/        (pasta com plugins, se existir)
config.xml       (arquivo de configuração do Cordova)
voltbuilder.json (configuração do VoltBuilder)
```

## Observações

- O VoltBuilder usa a versão mais recente do Android SDK
- Não é necessário ter o JDK ou Android SDK instalados localmente
- O serviço oferece 15 dias gratuitos, depois é necessário assinar um plano
- Para builds de produção, você precisará de um certificado de assinatura

## Alternativas ao VoltBuilder

Se o VoltBuilder não atender às suas necessidades, outras alternativas incluem:

1. **Ionic Appflow** - https://ionic.io/appflow
2. **Bitrise** - https://www.bitrise.io/
3. **PWABuilder** - https://www.pwabuilder.com/ (para Progressive Web Apps)

## Requisitos para build local

Se preferir fazer o build localmente, você precisará:

1. JDK 8 ou superior
2. Android SDK
3. Variáveis de ambiente ANDROID_HOME e ANDROID_SDK_ROOT configuradas
4. Executar `cordova build android` no terminal
