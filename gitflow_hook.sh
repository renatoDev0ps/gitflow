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

# Comandos e subcomandos permitidos do Git Flow
declare -A ALLOWED_COMMANDS
ALLOWED_COMMANDS=(
  ["init"]="init"
  ["feature"]="start|finish"
  ["bugfix"]="start|finish"
  ["release"]="start|finish"
  ["hotfix"]="start|finish"
  ["support"]="start"
)

# Função para verificar se o comando e subcomando fornecidos são permitidos
is_allowed_command() {
  local cmd=$1
  local subcmd=$2
  for allowed_cmd in "${!ALLOWED_COMMANDS[@]}"; do
    if [[ $cmd == $allowed_cmd && $subcmd =~ ${ALLOWED_COMMANDS[$cmd]} ]]; then
      return 0
    fi
  done
  return 1
}

# Captura o comando e subcomando digitados no terminal
echo "Por favor, digite seu comando do Git Flow:"
read -e GIT_FLOW_COMMAND

# Extrai o comando e subcomando
IFS=' ' read -ra CMD_PARTS <<< "$GIT_FLOW_COMMAND"
COMMAND="${CMD_PARTS[0]}"
SUBCOMMAND="${CMD_PARTS[1]}"

# Verifica se o comando e subcomando fornecidos são permitidos
if is_allowed_command "$COMMAND" "$SUBCOMMAND"; then
  echo "Comando permitido."
else
  echo "Comando não permitido. Por favor, use apenas comandos e subcomandos do Git Flow."
  exit 1
fi
