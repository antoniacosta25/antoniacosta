@echo off
setlocal EnableExtensions DisableDelayedExpansion
cd /d "%~dp0"
title ANTONIA COSTA - PUBLICADOR GITHUB
:MENU
cls
echo =====================================================
echo       ANTONIA COSTA - INSTALADOR DO PORTFOLIO
 echo           GitHub Pages - ADS / UESB
 echo =====================================================
echo.
echo  [1] Visualizar site no navegador
 echo  [2] Verificar Git, arquivos e conta GitHub
 echo  [3] Preparar repositorio local e criar COMMIT
 echo  [4] Criar repositorio PUBLICO no GitHub com gh
 echo  [5] Enviar commits para GitHub (PUSH)
 echo  [6] Atualizar catalogo de repositorios (Python)
 echo  [7] Abrir configuracoes GitHub Pages
 echo  [8] Abrir perfil GitHub
 echo  [0] Sair
 echo.
set /p "OPT=Selecione uma opcao: "
if "%OPT%"=="1" goto PREVIEW
if "%OPT%"=="2" goto CHECK
if "%OPT%"=="3" goto COMMIT
if "%OPT%"=="4" goto CREATE
if "%OPT%"=="5" goto PUSH
if "%OPT%"=="6" goto UPDATE
if "%OPT%"=="7" goto PAGES
if "%OPT%"=="8" goto PROFILE
if "%OPT%"=="0" exit /b 0
goto MENU
:PREVIEW
start "" "%CD%\site\index.html"
goto WAIT
:CHECK
where git >nul 2>nul && (git --version) || echo ERRO: Git nao instalado.
where gh >nul 2>nul && (gh --version) || echo DICA: instale GitHub CLI para criar o repositorio.
if exist "site\index.html" (echo OK: site encontrado) else (echo ERRO: site ausente)
if exist "site\assets\antonia-costa-perfil.jpg" (echo OK: foto encontrada) else (echo ERRO: foto ausente)
where gh >nul 2>nul && gh auth status
goto WAIT
:COMMIT
where git >nul 2>nul || (echo Instale Git para Windows antes de continuar.&goto WAIT)
if not exist "site\index.html" (echo Site ausente.&goto WAIT)
if not exist ".git" git init -b main
if errorlevel 1 goto ERROR
for /f "delims=" %%i in ('git branch --show-current 2^>nul') do set "CURRENT_BRANCH=%%i"
if defined CURRENT_BRANCH if /i not "%CURRENT_BRANCH%"=="main" (echo ATENCAO: branch atual e %CURRENT_BRANCH% .&goto WAIT)
echo.
git status --short
 echo.
echo ATENCAO: voce vai preparar TODOS os arquivos desta pasta para um commit local.
choice /c SN /m "Confirma criar commit local"
if errorlevel 2 goto WAIT
git add -A
if errorlevel 1 goto ERROR
git diff --cached --quiet
if not errorlevel 1 (echo Nenhuma alteracao a registrar.&goto WAIT)
set /p "MSG=Mensagem do commit [site: portfolio profissional Antonia Costa]: "
if not defined MSG set "MSG=site: portfolio profissional Antonia Costa"
git commit -m "%MSG%"
if errorlevel 1 (echo ERRO: configure nome e email em git config --global user.name / user.email.&goto WAIT)
echo Commit criado apenas no computador. Nenhum envio foi realizado.
goto WAIT
:CREATE
where gh >nul 2>nul || (echo GitHub CLI (gh) nao instalado. Veja INSTALACAO.md.&goto WAIT)
if not exist ".git" (echo Primeiro execute a opcao 3.&goto WAIT)
gh auth status
if errorlevel 1 (echo Entre com: gh auth login&goto WAIT)
for /f "delims=" %%u in ('gh api user --jq .login 2^>nul') do set "ACCOUNT=%%u"
if /i not "%ACCOUNT%"=="antoniacosta25" (echo Conta conectada: %ACCOUNT%. Exigida: antoniacosta25.&goto WAIT)
git remote get-url origin >nul 2>nul && (echo Ja existe um remoto origin. Revise manualmente.&goto WAIT)
echo Criara github.com/antoniacosta25/antoniacosta25 como PUBLICO.
choice /c SN /m "Autoriza criar esse repositorio na conta autenticada"
if errorlevel 2 goto WAIT
gh repo create antoniacosta25 --public --source . --remote origin
if errorlevel 1 goto ERROR
echo Repositorio criado. Use opcao 5 para enviar os arquivos.
goto WAIT
:PUSH
where git >nul 2>nul || (echo Git nao encontrado.&goto WAIT)
where gh >nul 2>nul || (echo gh necessario para checar a conta autenticada.&goto WAIT)
gh auth status >nul 2>nul || (echo Faca login: gh auth login&goto WAIT)
for /f "delims=" %%u in ('gh api user --jq .login 2^>nul') do set "ACCOUNT=%%u"
if /i not "%ACCOUNT%"=="antoniacosta25" (echo Conta incorreta: %ACCOUNT%&goto WAIT)
for /f "delims=" %%r in ('git remote get-url origin 2^>nul') do set "REMOTE=%%r"
if not defined REMOTE (echo Remoto origin nao configurado. Use opcao 4.&goto WAIT)
echo %REMOTE% | findstr /i /c:"github.com/antoniacosta25/antoniacosta25" >nul
if errorlevel 1 (echo Remoto diferente do esperado: %REMOTE%&goto WAIT)
git status --short
git log -1 --oneline
echo.
echo Enviara a branch main ao remoto exibido. Confirme que o conteudo pode ser PUBLICO.
choice /c SN /m "Autoriza git push origin main"
if errorlevel 2 goto WAIT
git push -u origin main
if errorlevel 1 goto ERROR
echo Envio concluido. Para ativar Pages, use opcao 7.
goto WAIT
:UPDATE
where python >nul 2>nul && (python "scripts\atualizar-projetos.py"&goto WAIT)
where py >nul 2>nul && (py -3 "scripts\atualizar-projetos.py"&goto WAIT)
echo Instale Python 3 ou use o GitHub Actions semanal.
goto WAIT
:PAGES
start "" "https://github.com/antoniacosta25/antoniacosta25/settings/pages"
goto WAIT
:PROFILE
start "" "https://github.com/settings/profile"
goto WAIT
:ERROR
echo Ocorreu um erro. Confira o texto acima e consulte INSTALACAO.md.
:WAIT
echo.
pause
goto MENU
