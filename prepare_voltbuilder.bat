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

:: Verificar se o PowerShell está disponível
where powershell >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo PowerShell nao encontrado. Este script requer PowerShell para criar o arquivo ZIP.
    exit /b 1
)

:: Criar o arquivo ZIP com os arquivos necessários usando PowerShell
echo Criando arquivo ZIP com os arquivos necessarios...

powershell -Command "Add-Type -Assembly System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::CreateFromDirectory('www', '%ZIP_FILE%')"

:: Adicionar config.xml ao ZIP
powershell -Command "Add-Type -Assembly System.IO.Compression.FileSystem; $zip = [System.IO.Compression.ZipFile]::Open('%ZIP_FILE%', 'Update'); [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, 'config.xml', 'config.xml'); $zip.Dispose()"

:: Adicionar voltbuilder.json ao ZIP
powershell -Command "Add-Type -Assembly System.IO.Compression.FileSystem; $zip = [System.IO.Compression.ZipFile]::Open('%ZIP_FILE%', 'Update'); [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, 'voltbuilder.json', 'voltbuilder.json'); $zip.Dispose()"

:: Adicionar plugins se existirem
if exist plugins (
    echo Adicionando plugins ao ZIP...
    powershell -Command "Add-Type -Assembly System.IO.Compression.FileSystem; $zip = [System.IO.Compression.ZipFile]::Open('%ZIP_FILE%', 'Update'); foreach ($file in (Get-ChildItem -Path 'plugins' -Recurse -File)) { $relativePath = 'plugins/' + $file.FullName.Substring((Get-Item 'plugins').FullName.Length + 1).Replace('\', '/'); [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $file.FullName, $relativePath) }; $zip.Dispose()"
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
