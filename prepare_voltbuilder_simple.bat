@echo off
setlocal

echo Preparando arquivo ZIP para o VoltBuilder...

:: Nome do arquivo ZIP
set ZIP_FILE=playtv-voltbuilder.zip

:: Remover ZIP anterior se existir
if exist %ZIP_FILE% (
    echo Removendo arquivo ZIP anterior...
    del %ZIP_FILE%
)

:: Verificar se o 7-Zip está instalado
where 7z >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo 7-Zip nao encontrado. Este script requer 7-Zip para criar o arquivo ZIP.
    echo Voce pode baixar o 7-Zip em https://www.7-zip.org/
    exit /b 1
)

:: Criar o arquivo ZIP com os arquivos necessários
echo Criando arquivo ZIP com os arquivos necessarios...
7z a -tzip %ZIP_FILE% www config.xml voltbuilder.json

:: Adicionar plugins se existirem
if exist plugins (
    echo Adicionando plugins ao ZIP...
    7z a -tzip %ZIP_FILE% plugins
)

if %ERRORLEVEL% neq 0 (
    echo Erro ao criar o arquivo ZIP.
    exit /b 1
)

echo.
echo Arquivo ZIP criado com sucesso: %ZIP_FILE%
echo.
echo Agora voce pode fazer upload deste arquivo no VoltBuilder (https://volt.build/)
echo Siga as instrucoes em VOLTBUILDER_INSTRUCTIONS.md para mais detalhes.

endlocal
