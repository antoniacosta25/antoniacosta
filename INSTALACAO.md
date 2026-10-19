# INSTALAÇÃO — ANTÔNIA COSTA (WINDOWS)

## Requisitos
- Windows 10/11, Git para Windows.
- **GitHub CLI (`gh`)** para criar o repositório e verificar a conta antes do envio; instalar pelo site oficial https://cli.github.com/.
- Python 3 é opcional para atualização manual da lista de projetos.
- Ter autorização e acesso autenticado à conta `antoniacosta25`.

## 1. Preparar e publicar
1. Extraia **todo** o ZIP em uma pasta nova (sem misturar com outros projetos).
2. Abra `INICIAR-ANTONIA-COSTA.bat`.
3. Opção 1: pré-visualizar. O carregamento local dos projetos pode depender de servidor HTTP; no Pages o catálogo carrega normalmente.
4. Opção 2: verifique as dependências.
5. Configure nome e e-mail para commits se solicitado: `git config --global user.name "Antônia Costa"` e `git config --global user.email "EMAIL_VERIFICADO"` (substitua com o endereço escolhido pela titular).
6. Na primeira utilização: `gh auth login` em um terminal e **autentique somente a conta autorizada**.
7. Opção 3: cria repositório Git local e commit, **não envia nada**.
8. Opção 4: cria `antoniacosta25/antoniacosta25` como repositório público somente com confirmação, se não existir. Se ele já existir, não recrie nem sobrescreva: faça um clone e integre o conteúdo sob revisão.
9. Opção 5: envia a branch `main` com confirmação, após confirmar a conta e o endereço remoto exato. Em caso de divergências remotas, o push é recusado; **não use `--force`**.
10. Abra opção 7 e escolha **Settings → Pages → Build and deployment → Source: GitHub Actions**. O workflow `pages.yml` publicará a pasta `site/`.
11. Após a ação terminar com sucesso, o endereço esperado é **https://antoniacosta25.github.io/**.

## 2. Atualizar projetos
Opção 6 consulta repositórios públicos no GitHub, atualiza `data/projects.json` e `site/projects.json`. Refaça o commit (opção 3) e o push (opção 5), se desejar publicar. O workflow semanal também pode atualizar o catálogo mediante permissões adequadas.

## 3. Campos de perfil no GitHub
- **Name:** `Antônia Costa` (ou manter `Antônia Grasiela`, se preferir seu nome completo).
- **Bio:** `🎓 ADS na UESB | 💻 HTML, CSS e JavaScript | ☕ Java e 🗄️ SQL em aprendizado | 🚀 Projetos acadêmicos e tecnologia.`
- **URL:** `https://antoniacosta25.github.io/` **após a publicação**.
- **Company:** deixar vazio, salvo vínculo profissional real.
- **Location, Public email e Social accounts:** opcionais e definidos pela titular.
- **Profile picture:** `site/assets/foto-github-800.jpg` (< 1 MB).

## 4. Segurança
Este pacote não configura acesso remoto, não armazena tokens, não apaga repositórios e não faz `git push --force`. O `.bat` requer confirmação explícita. GitHub Pages é público: revise textos, fotos e quaisquer dados antes de publicar.
