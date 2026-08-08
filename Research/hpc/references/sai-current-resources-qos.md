# Current SAI Resources and QOS

This is the authoritative static overlay for SAI resource selection when the generated SAI reference skills disagree with the cluster. The snapshot was verified on `login-01.mr-sai.ai` on 2026-08-02. Capacity and policy can change, so refresh them before submission.

## Source Priority

Use sources in this order:

1. Live Slurm configuration and the user's account association.
2. Current templates under `/opt/sbatch_examples`.
3. This dated snapshot.
4. Generated SAI reference skills for background only.

Run these read-only checks from a clean, non-login shell:

```bash
hostname
sinfo -h -o '%P|%a|%l|%D|%G|%C|%m'
scontrol show partition -o
sacctmgr -nP show qos format=Name,Priority,MaxWall,MaxJobsPU,MaxSubmitJobsPU,MaxTRESPU,MinTRES,MaxTRESPerJob,Flags
sacctmgr -nP show assoc where user="$USER" format=Cluster,Account,User,Partition,QOS,DefaultQOS,GrpTRES,MaxTRES
sed -n '1,120p' /opt/sbatch_examples/gpu_abacus.sbatch
```

## Capacity Snapshot

All listed partitions were `UP`. GPU capacity totaled 1588 devices.

| Partition | Nodes | Scheduled capacity | Default |
| --- | ---: | --- | --- |
| `4V100` | 35 | 140 V100-SXM2 GPUs | yes |
| `8V100V0` | 13 | 104 V100-SXM2 GPUs | no |
| `16V100` | 83 | 1328 V100-SXM2 GPUs | no |
| `8A100M40` | 1 | 8 A100-SXM4 GPUs | no |
| `8A100M80` | 1 | 8 A100-SXM4 GPUs | no |
| `DSPRHBM` | 18 | 1872 CPU TRES, 2160 GiB RAM | no |
| `CPU-MISC` | 1 | 64 CPU TRES, 704 GiB RAM | no |

Do not request the obsolete planned partition names `4V100PX`, `8A100R40`, or `8A100R80` unless they reappear in live Slurm output.

## GPU QOS Snapshot

Limits below are QOS-level per-user limits. Account and association limits can further restrict a job.

| QOS | Priority | GPU per job | Max wall | Max submitted jobs/user | Max concurrent GPU/user |
| --- | ---: | --- | --- | ---: | ---: |
| `rush-1o2gpu` | 150 | 1-2 | 24 hours | 10 | 16 |
| `rush-gpu` | 150 | 4-16 | 24 hours | 10 | 16 |
| `improper-gpu` | 100 | 1 or more | 30 days | 500 | 128 |
| `huge-gpu` | 100 | 4 or more | 30 days | 100 | 256 |
| `ultimate-gpu` | 90 | 4 or more | unlimited | 1 | association limit |
| `flood-1o2gpu` | 90 | 1-2 | 4 hours | 10000 | association limit |
| `flood-gpu` | 90 | 4 or more | 4 hours | 10000 | association limit |

`rush-4gpu` remains as a legacy QOS object but no active partition allowed it in this snapshot. `rush-8gpu` was absent. Use `rush-gpu` for urgent 4-16 GPU jobs.

CPU QOS limits were:

- `rush-cpu`: priority 150, 48 hours, 10 submitted jobs/user, `cpu=32,mem=750G` per user.
- `huge-cpu`: priority 100, 48 hours, 100 submitted jobs/user, `cpu=1024,mem=2T` per user.

## Partition And QOS Compatibility

| Partition | Allowed QOS |
| --- | --- |
| `4V100` | `improper-gpu`, `rush-1o2gpu`, `rush-gpu`, `huge-gpu`, `flood-1o2gpu`, `flood-gpu` |
| `8V100V0` | `improper-gpu`, `rush-1o2gpu`, `rush-gpu`, `huge-gpu`, `ultimate-gpu`, `flood-1o2gpu`, `flood-gpu` |
| `16V100` | `rush-gpu`, `huge-gpu`, `ultimate-gpu`, `flood-1o2gpu`, `flood-gpu` |
| `8A100M40`, `8A100M80` | `improper-gpu`, `rush-1o2gpu`, `rush-gpu`, `huge-gpu`, `flood-1o2gpu`, `flood-gpu` |
| `DSPRHBM` | `rush-cpu`, `huge-cpu` |
| `CPU-MISC` | `rush-cpu` |

## Submission Rules

- Start from the closest current `/opt/sbatch_examples` template.
- Keep the submission shell clean; load modules or runtime environments inside the job script.
- For GPU partitions, specify `--nodes`, `--ntasks`, and `--gpus-per-node`; do not request CPU or memory explicitly unless current site policy or a current template says otherwise.
- Except for `improper-gpu`, `rush-1o2gpu`, and `flood-1o2gpu`, request a per-node GPU count divisible by four.
- For non-MPI programs, use `--ntasks=1` and omit MPI rank mapping and CUDA-MPS setup unless the current template explicitly requires them.
- Never infer QOS compatibility from a QOS name alone; verify both the partition and the user's account association.
