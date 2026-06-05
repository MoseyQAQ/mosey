# HPC Environment Reference

Use `hostname` directly for host detection. Do not assume `hostname -f`.

## Host Profiles

| Host pattern | Preferred Python | Slurm template path |
| --- | --- | --- |
| `login-01.mr-sai.ai` | `/home/wlu-liushi/lidenan/soft/conda/bin/python3` | `/opt/sbatch_examples` |
| `SAI` | `/home/wlu-liushi/lidenan/soft/conda/bin/python3` | `/opt/sbatch_examples` |
| `login0*.cluster.com` | `~/software/miniconda3/bin/python3` | `/home/liushiLab/share/sbatch_examples` |
| `mgmt-01.hpc.liutheory.westlake.edu.cn` | `/home/liushiLab/lidenan/soft/conda/envs/fdc/bin/python3` | `/opt/sbatch_examples` |

## Operating Policy

- Prefer the host-specific Python path before searching for `python3`.
- Treat those Python paths as defaults, not absolute requirements.
- Ask before installing new packages.
- Do not change `~/.bashrc`, Conda base environments, or module initialization unless the user explicitly asks.
- Do not submit Slurm jobs unless the user explicitly asks for `sbatch`, `srun`, or an interactive allocation.
- When Slurm work is requested, inspect the template directory first and adapt the closest template.
- Do not invent Slurm parameters when templates contain site-specific defaults.

## Local Reference Skills

The SAI reference materials are kept as generated reference-skill folders:

```text
references/sai-user-guide/
references/sai-account/
references/sai-overview/
```

Useful entry points:

- `sai-user-guide/SKILL.md`
- `sai-user-guide/references/任务提交和管理.md`
- `sai-user-guide/references/软件环境.md`
- `sai-user-guide/references/快速开始.md`
- `sai-user-guide/references/SAI用户特殊注意事项汇总.md`
