#!/bin/bash

# Script para preparar o arquivo ZIP para o VoltBuilder

echo "Preparando arquivo ZIP para o VoltBuilder..."

# Verificar se o zip está instalado
if ! command -v zip &> /dev/null; then
    echo "O comando 'zip' não está instalado. Por favor, instale-o primeiro."
    exit 1
fi

# Nome do arquivo ZIP
ZIP_FILE="playtv-voltbuilder.zip"

# Remover ZIP anterior se existir
if [ -f "$ZIP_FILE" ]; then
    echo "Removendo arquivo ZIP anterior..."
    rm "$ZIP_FILE"
fi

# Criar o arquivo ZIP com os arquivos necessários
echo "Criando arquivo ZIP com os arquivos necessários..."
zip -r "$ZIP_FILE" www config.xml voltbuilder.json

# Adicionar plugins se existirem
if [ -d "plugins" ]; then
    echo "Adicionando plugins ao ZIP..."
    zip -r "$ZIP_FILE" plugins
fi

echo "\nArquivo ZIP criado com sucesso: $ZIP_FILE"
echo "\nAgora você pode fazer upload deste arquivo no VoltBuilder (https://volt.build/)"
echo "Siga as instruções em VOLTBUILDER_INSTRUCTIONS.md para mais detalhes."
