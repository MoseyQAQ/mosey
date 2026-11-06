# SAI Resource and QOS Queries

Use these read-only queries when selecting new resources, changing a working configuration, or diagnosing a submission failure. Run only the checks needed for the current question in a non-login shell; this is not a checklist to repeat for every job.

Current Slurm configuration and the user's account association take precedence over `/opt/sbatch_examples` and static manuals. Follow the execution and script conventions in the [HPC skill](../SKILL.md).

## Partition Selection

If the appropriate partition is not already known, inspect available partitions:

```bash
sinfo -h -o '%P|%a|%l|%G'
```

Inspect the selected partition's resource limits and allowed accounts/QOS. Replace `PARTITION` with its actual name:

```bash
scontrol show partition PARTITION -o
```

## QOS and Account Limits

Check the relevant QOS limits; replace `QOS_NAME` with the actual name:

```bash
sacctmgr -nP show qos where name=QOS_NAME format=Name,Priority,MaxWall,MaxJobsPU,MaxSubmitJobsPU,MaxTRESPU,MinTRES,MaxTRESPerJob,Flags
```

If the user's permitted accounts or QOS are not already verified, query the association:

```bash
sacctmgr -nP show assoc where user="$USER" format=Cluster,Account,User,Partition,QOS,DefaultQOS,GrpTRES,MaxTRES
```

A QOS object existing does not mean a partition or account can use it. Consider partition, QOS, and association limits together; do not infer compatibility or GPU-count requirements from names or old examples.

## Templates

When preparing a new configuration, inspect the closest applicable template under `/opt/sbatch_examples`. Adopt only task-relevant resource and runtime settings, consistent with the main skill's Slurm conventions. Do not add MPI rank mapping or CUDA-MPS to a non-MPI task unless the actual runtime requires it.
