---
name: hpc
description: Use when preparing, running, or checking Mosey's research computations on SAI, cluster.com, or liutheory HPC systems. Covers minimal research artifacts, Python environments, Slurm resource selection, and execution within the user's authorized scope.
---

# HPC

Respect the user's organization of their research directories. Complete the task with only the files and operations it needs.

## Directories and Artifacts

- Do not create artifacts without a concrete need. Reuse existing directories, files, and naming conventions instead of adding a separate structure for managing the assistant's work.
- Keep only requested deliverables and the inputs, scripts, data, and logs needed to run, analyze, reproduce, or resume the work. Unless requested, do not add task ledgers, status inventories, mapping tables, comparison reports, or explanatory files solely to document the assistant's process, such as `jobs.json`, `mapping.txt`, `compare.json`, or `completed.json`.
- Judge necessity by purpose, not by filename or extension. Keep mappings required by the computation, necessary logs, and checkpoints. Do not duplicate information already available directly from existing results.
- Remove temporary helper files when finished with them. Only remove files created during this task that are no longer useful; do not reorganize, move, or delete the user's existing files or files still needed by running jobs.
- Put units, column definitions, key parameters, and other scientific context in existing inputs, scripts, or data headers where practical, rather than creating separate documentation.
- Report results, their locations, and material limitations briefly in the conversation. Do not also save a report unless requested or needed as a task deliverable. Do not ask for approval for each necessary file.
- If the user explicitly designates a directory as a playground or authorizes open exploration there, organize scripts, intermediate results, and records as the exploration requires. This freedom applies only to that directory and task. Identify the main results at handoff and remove temporary artifacts that no longer serve a purpose. Broad autonomy does not require more files.

## Language

- Use Chinese by default for reports, explanations, text-data headers, and explanatory comments that the task actually requires.
- Preserve physical symbols, units, program keywords, fields required by existing parsers, and native software logs. Do not break compatibility to translate them.
- This language preference does not justify adding reports, explanations, or headers. Preserve the user's requested data format.

## Environment

- Use `hostname` when the host is unclear. Reuse confirmed information in the same environment; recheck relevant details after changing hosts or environments.
- Follow the user's or project's Python requirement first; otherwise use the defaults below. Invoke the interpreter explicitly. Diagnose an unavailable interpreter before choosing another; do not switch silently.
- On SAI, use a non-login shell for routine commands (`login=false` when supported) to avoid repeated login initialization.
- Obtain authorization before installing packages or modifying shared environments or shell startup files. Do not ask again when the existing authorization already covers the action.

| Host | Default Python | Slurm templates |
| --- | --- | --- |
| `login-01.mr-sai.ai` / `SAI` | `/home/lidenan/workdir_wlu-liushi/lidenan/soft/conda/bin/python3` | `/opt/sbatch_examples` |
| `login0*.cluster.com` | `~/software/miniconda3/bin/python3` | `/home/liushiLab/share/sbatch_examples` |
| `mgmt-01.hpc.liutheory.westlake.edu.cn` | `/home/liushiLab/lidenan/soft/conda/envs/fdc/bin/python3` | `/opt/sbatch_examples` |
| `moseydeMacBook-Air.local` | `/Users/mosey/miniconda3/bin/python3` | Not applicable locally |

## Slurm

- Interpret authorization from the task. Discussing a plan or preparing files does not authorize submission. An explicit request to run computations or tests includes the necessary `sbatch` submissions or `srun` allocations; the user need not name those commands. Do not expand the calculation or add unrelated jobs.
- Reuse an existing project submission script that is known to fit the task. When creating or changing resource settings, consult the host's templates and adopt only the settings the task needs.
- Do not guess partitions, QOS, or account permissions. When first selecting resources, changing configurations, or diagnosing submission failures, check the relevant partition, QOS, account, and resource limits. Reuse verified information within the task rather than repeating a full inventory for every job.
- Current Slurm configuration and account permissions take precedence, followed by cluster templates. Static documentation is background only. Optional template settings need not be copied.
- When creating or editing submission scripts, omit `--time` and `--chdir`; submit from the correct working directory. Omit `--output` and `--error` by default unless they provide a concrete benefit, such as compatibility with an existing log-reading workflow. Do not circumvent these conventions with short options, command-line overrides, or shell redirection.
- Run computations and tests that require GPUs on allocated GPU nodes. Lack of CUDA on a login node is not a reason to skip required GPU validation.
- Check job health and results as needed for the task. Successful submission, a running job, normal program termination, and scientific convergence are different conclusions; report only what the evidence supports.

## References on Demand

- Use [SAI resource and QOS queries](references/sai-current-resources-qos.md) for the checks relevant to the current question.
- Consult `references/sai-user-guide/` for specific platform problems, `references/sai-account/` for account and billing questions, and `references/sai-overview/` for platform background. Do not load all manuals for routine computation. Their generated examples and old snapshots do not override this skill or current cluster configuration.
