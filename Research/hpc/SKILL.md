---
name: hpc
description: Use as background context for Mosey's HPC work, especially before running shell commands, Python scripts, tests, Slurm commands, or environment setup on known SAI, cluster.com, or liutheory HPC login hosts. Helps Codex identify the host with hostname, choose the preferred Python executable, find Slurm template directories, and avoid unsafe package installs or unsolicited job submission.
---

# HPC

Use this skill to keep HPC command execution boring and predictable.

## First Step

Before running Python, tests, or Slurm-related commands in an HPC shell, identify the host:

```bash
hostname
```

Prefer running the bundled detector when available:

```bash
Research/hpc/scripts/detect-hpc-env.sh
```

Use the detector output as the default environment choice. If the current repo, user command, or active environment clearly requires a different Python, follow that local requirement and briefly state the reason.

## Python Defaults

Host-specific Python paths are preferred, not mandatory:

- `login-01.mr-sai.ai` or `SAI`: `/home/wlu-liushi/lidenan/soft/conda/bin/python3`
- `login0*.cluster.com`: `~/software/miniconda3/bin/python3`
- `mgmt-01.hpc.liutheory.westlake.edu.cn`: `/home/liushiLab/lidenan/soft/conda/envs/fdc/bin/python3`

Use explicit Python invocations when possible:

```bash
<preferred-python> -m pytest
<preferred-python> script.py
<preferred-python> -c "import sys; print(sys.executable)"
```

If the preferred Python path is missing or fails, diagnose with `hostname`, `ls -l <path>`, and a minimal version check before falling back to another Python.

Ask before installing any new package with `pip`, `conda`, `mamba`, or similar tools. Do not silently modify base environments or shell startup files such as `~/.bashrc`.

## Slurm

These HPC environments use Slurm, but do not submit jobs proactively. Use `sbatch` or `srun` only when the user explicitly asks for Slurm submission or interactive allocation.

When Slurm work is requested, inspect the host-specific template directory first and adapt the closest template:

- `login-01.mr-sai.ai` or `SAI`: `/opt/sbatch_examples`
- `login0*.cluster.com`: `/home/liushiLab/share/sbatch_examples`
- `mgmt-01.hpc.liutheory.westlake.edu.cn`: `/opt/sbatch_examples`

Do not invent partition, QoS, CPU, memory, GPU, or module defaults when templates are available. Let the templates carry site-specific Slurm policy.

## References

Read `references/hpc-environments.md` when you need the full host table, policy notes, or local reference-document paths.

For SAI and Slurm details, consult the local generated reference skills only as needed:

- `references/sai-user-guide/SKILL.md`
- `references/sai-user-guide/references/任务提交和管理.md`
- `references/sai-user-guide/references/软件环境.md`
- `references/sai-user-guide/references/快速开始.md`
- `references/sai-user-guide/references/SAI用户特殊注意事项汇总.md`
