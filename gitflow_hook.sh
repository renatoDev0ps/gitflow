#!/bin/bash

# link para instalar gitflow no fedora
#https://copr.fedorainfracloud.org/coprs/elegos/gitflow/

# Verifica se o git-flow está instalado
command -v git-flow >/dev/null 2>&1 || { echo >&2 "O git-flow não está instalado. Por favor, instale-o e tente novamente."; exit 1; }

# Lista de comandos permitidos do Git Flow
ALLOWED_COMMANDS=(
  "init"
  "feature"
  "bugfix"
  "release"
  "hotfix"
  "support"
  "config"
  "version"
  "checkout"
)

# Função para verificar se o comando fornecido é permitido
is_allowed_command() {
  local cmd=$1
  for allowed in "${ALLOWED_COMMANDS[@]}"; do
    if [[ $cmd == $allowed ]]; then
      return 0
    fi
  done
  return 1
}

# Verifica se o comando foi fornecido
if [[ $# -eq 0 ]]; then
  echo "Por favor, forneça um comando do Git Flow."
  exit 1
fi

# Verifica se o comando fornecido é permitido
if is_allowed_command "$1"; then
  git flow "$@"
else
  echo "Comando não permitido. Por favor, use apenas comandos do Git Flow."
  exit 1
fi

