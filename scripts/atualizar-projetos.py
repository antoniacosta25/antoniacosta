#!/usr/bin/env python3
"""Atualiza catálogo de repositórios públicos sem alterar projetos de origem."""
import json, pathlib, urllib.request
ROOT=pathlib.Path(__file__).resolve().parents[1]
URL='https://api.github.com/users/antoniacosta25/repos?per_page=100&type=owner&sort=updated'
req=urllib.request.Request(URL,headers={'Accept':'application/vnd.github+json','User-Agent':'antonia-academic-portfolio'})
with urllib.request.urlopen(req,timeout=25) as response:
    data=json.load(response)
if not isinstance(data,list):
    raise RuntimeError('Resposta da API inválida: sem alterações')
items=[]
for r in data:
    if r.get('private') or r.get('fork') or r.get('name')=='antoniacosta25':continue
    items.append({'name':r['name'],'description':r.get('description') or 'Projeto ou exercício disponível no GitHub.','url':r['html_url']})
if not items:raise RuntimeError('Nenhum repositório encontrado: sem alterações')
items=sorted(items,key=lambda x:x['name'].casefold())
text=json.dumps(items,ensure_ascii=False,indent=2)+'\n'
for path in (ROOT/'data/projects.json',ROOT/'site/projects.json'):
    path.write_text(text,encoding='utf-8')
print(f'Atualizados {len(items)} projetos públicos. Nenhum arquivo de projeto foi modificado.')
