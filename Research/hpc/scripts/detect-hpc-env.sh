#!/usr/bin/env bash
set -euo pipefail

host=$(hostname)
profile="unknown"
python_path=""
sbatch_templates=""

case "$host" in
  login-01.mr-sai.ai|SAI)
    profile="sai"
    python_path="/home/wlu-liushi/lidenan/soft/conda/bin/python3"
    sbatch_templates="/opt/sbatch_examples"
    ;;
  login0*.cluster.com)
    profile="cluster-com"
    python_path="$HOME/software/miniconda3/bin/python3"
    sbatch_templates="/home/liushiLab/share/sbatch_examples"
    ;;
  mgmt-01.hpc.liutheory.westlake.edu.cn)
    profile="liutheory"
    python_path="/home/liushiLab/lidenan/soft/conda/envs/fdc/bin/python3"
    sbatch_templates="/opt/sbatch_examples"
    ;;
esac

printf 'hostname=%s\n' "$host"
printf 'profile=%s\n' "$profile"

if [[ -n "$python_path" ]]; then
  printf 'preferred_python=%s\n' "$python_path"
  if [[ -x "$python_path" ]]; then
    printf 'preferred_python_status=executable\n'
  elif [[ -e "$python_path" ]]; then
    printf 'preferred_python_status=exists_not_executable\n'
  else
    printf 'preferred_python_status=missing\n'
  fi
else
  printf 'preferred_python=\n'
  printf 'preferred_python_status=unmatched_host\n'
fi

if [[ -n "$sbatch_templates" ]]; then
  printf 'sbatch_templates=%s\n' "$sbatch_templates"
  if [[ -d "$sbatch_templates" ]]; then
    printf 'sbatch_templates_status=directory\n'
  else
    printf 'sbatch_templates_status=missing\n'
  fi
else
  printf 'sbatch_templates=\n'
  printf 'sbatch_templates_status=unmatched_host\n'
fi
