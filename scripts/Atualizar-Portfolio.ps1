param([switch]$Publicar)
$ErrorActionPreference = 'Stop'
$Raiz = Split-Path -Parent $PSScriptRoot
Set-Location $Raiz
Write-Host 'Atualizando catálogo público de projetos...' -ForegroundColor Magenta
if (Get-Command python -ErrorAction SilentlyContinue) { python scripts/atualizar-projetos.py }
elseif (Get-Command py -ErrorAction SilentlyContinue) { py -3 scripts/atualizar-projetos.py }
else { throw 'Python 3 não encontrado.' }
if ($LASTEXITCODE -ne 0) { throw 'A atualização falhou.' }
if ($Publicar) {
  git diff -- data/projects.json site/projects.json
  $resposta = Read-Host 'Deseja criar commit e enviar estas duas listas? Digite PUBLICAR'
  if ($resposta -ne 'PUBLICAR') { Write-Host 'Publicação cancelada'; exit 0 }
  git add -- data/projects.json site/projects.json
  git diff --cached --quiet
  if ($LASTEXITCODE -eq 0) { Write-Host 'Nenhuma mudança para publicar'; exit 0 }
  git commit -m 'chore: atualizar catálogo de projetos'
  if ($LASTEXITCODE -ne 0) { throw 'Falha no commit' }
  git push
  if ($LASTEXITCODE -ne 0) { throw 'Falha ao enviar ao remoto' }
}
