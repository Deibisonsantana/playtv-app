#!/bin/bash

# Script para preparar o arquivo ZIP para o VoltBuilder usando Git Bash no Windows

echo "Preparando arquivo ZIP para o VoltBuilder..."

# Nome do arquivo ZIP
ZIP_FILE="playtv-voltbuilder.zip"

# Remover ZIP anterior se existir
if [ -f "$ZIP_FILE" ]; then
    echo "Removendo arquivo ZIP anterior..."
    rm "$ZIP_FILE"
fi

# Criar um arquivo ZIP temporário
echo "Criando arquivo ZIP com os arquivos necessários..."

# Verificar se o comando zip está disponível
if command -v zip &> /dev/null; then
    # Usar o comando zip nativo
    zip -r "$ZIP_FILE" www config.xml voltbuilder.json
    
    # Adicionar plugins se existirem
    if [ -d "plugins" ]; then
        echo "Adicionando plugins ao ZIP..."
        zip -r "$ZIP_FILE" plugins
    fi
else
    # Alternativa usando PowerShell
    echo "Comando zip não encontrado, tentando usar PowerShell..."
    powershell -Command "Add-Type -Assembly System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::CreateFromDirectory('www', '$ZIP_FILE')"
    
    # Adicionar config.xml ao ZIP
    powershell -Command "Add-Type -Assembly System.IO.Compression.FileSystem; \$zip = [System.IO.Compression.ZipFile]::Open('$ZIP_FILE', 'Update'); [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(\$zip, 'config.xml', 'config.xml'); \$zip.Dispose()"
    
    # Adicionar voltbuilder.json ao ZIP
    powershell -Command "Add-Type -Assembly System.IO.Compression.FileSystem; \$zip = [System.IO.Compression.ZipFile]::Open('$ZIP_FILE', 'Update'); [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(\$zip, 'voltbuilder.json', 'voltbuilder.json'); \$zip.Dispose()"
    
    # Adicionar plugins se existirem
    if [ -d "plugins" ]; then
        echo "Adicionando plugins ao ZIP..."
        powershell -Command "Add-Type -Assembly System.IO.Compression.FileSystem; \$zip = [System.IO.Compression.ZipFile]::Open('$ZIP_FILE', 'Update'); foreach (\$file in (Get-ChildItem -Path 'plugins' -Recurse -File)) { \$relativePath = 'plugins/' + \$file.FullName.Substring((Get-Item 'plugins').FullName.Length + 1).Replace('\\', '/'); [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(\$zip, \$file.FullName, \$relativePath) }; \$zip.Dispose()"
    fi
fi

if [ $? -ne 0 ]; then
    echo "Erro ao criar o arquivo ZIP."
    exit 1
fi

echo ""
echo "Arquivo ZIP criado com sucesso: $ZIP_FILE"
echo ""
echo "Agora você pode fazer upload deste arquivo no VoltBuilder (https://volt.build/)"
echo "Siga as instruções em VOLTBUILDER_INSTRUCTIONS.md para mais detalhes."
