# Geração de APK com VoltBuilder

## Visão Geral

Devido à falta do JDK 8 e do Android SDK no ambiente local, estamos utilizando o VoltBuilder como alternativa para gerar o APK do aplicativo PlayTV. O VoltBuilder é um serviço online que permite gerar APKs para Android sem a necessidade de configurar o ambiente de desenvolvimento completo.

## Arquivos Preparados

1. **voltbuilder.json** - Configuração básica para o VoltBuilder (modo debug)
2. **prepare_voltbuilder.sh** - Script para Linux/Mac que prepara o arquivo ZIP para upload
3. **prepare_voltbuilder.bat** - Script para Windows que prepara o arquivo ZIP para upload
4. **VOLTBUILDER_INSTRUCTIONS.md** - Instruções detalhadas sobre como usar o VoltBuilder

## Passos Rápidos

1. Execute o script de preparação para seu sistema operacional:
   - Windows: `prepare_voltbuilder.bat`
   - Linux/Mac: `./prepare_voltbuilder.sh`

2. Faça upload do arquivo ZIP gerado (`playtv-voltbuilder.zip`) no site do VoltBuilder: https://volt.build/

3. Siga as instruções na interface do VoltBuilder para gerar o APK

4. Baixe o APK gerado

## Observações

- O VoltBuilder oferece 15 dias de teste gratuito
- A configuração atual está para build de debug (não assinado)
- Para builds de produção, você precisará configurar um certificado de assinatura

## Suporte

Para mais informações sobre o VoltBuilder, consulte a documentação oficial em https://volt.build/docs/
