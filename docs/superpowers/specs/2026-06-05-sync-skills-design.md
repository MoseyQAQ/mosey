# Sync Skills Script Design

## Goal

Create one shell script at the repository root to keep this skill suite current and install selected skill groups by symbolic link.

The repository has two skill groups:

- `Daily/`: daily-use skills
- `Research/`: research skills

Both groups can be linked to either the global Codex skill directory or a project-level Codex skill directory. The default target is global for both groups.

## CLI

Default:

```bash
./sync-skills.sh
```

Equivalent to:

```bash
./sync-skills.sh --daily global --research global
```

Supported options:

```bash
./sync-skills.sh --daily global --research project
./sync-skills.sh --daily project --research global
./sync-skills.sh --daily none --research project
./sync-skills.sh --target project
./sync-skills.sh --project-dir /path/to/project
./sync-skills.sh --no-pull
./sync-skills.sh --dry-run
./sync-skills.sh --force
./sync-skills.sh --help
```

Option meanings:

- `--daily <global|project|none>` chooses where to link `Daily/*`.
- `--research <global|project|none>` chooses where to link `Research/*`.
- `--target <global|project|none>` is a shortcut that sets both `--daily` and `--research`.
- `--project-dir <path>` sets the project root used for project-level links. Default: current working directory.
- `--no-pull` skips the git update step.
- `--dry-run` prints planned actions without modifying files.
- `--force` replaces conflicting targets.
- `--help` prints usage.

## Directories

Source skill directories:

```text
Daily/<skill-name>
Research/<skill-name>
```

Only directories containing `SKILL.md` count as skills.

Global target:

```text
~/.codex/skills/<skill-name>
```

Project target:

```text
<project-dir>/.codex/skills/<skill-name>
```

The script should resolve its own repository root from the script path, so it can be called from another working directory.

## Flow

1. Parse CLI options.
2. Resolve repository root from `sync-skills.sh` location.
3. Unless `--no-pull` is set, run:

```bash
git -C <repo-root> pull --ff-only
```

4. Scan `Daily/*` and `Research/*`.
5. For each valid skill directory, decide the target from the group setting.
6. Create the target parent directory when needed.
7. Create or refresh a symbolic link from the selected target to the source skill directory.
8. Print a concise action log for each skill.

## Conflict Handling

If the target path does not exist, create the symlink.

If the target path is a symlink pointing to the same source skill, leave it unchanged or refresh it.

If the target path is a symlink pointing elsewhere, report a conflict. Replace it only with `--force`.

If the target path is a regular file or directory, report a conflict. Replace it only with `--force`.

With `--dry-run`, report what would happen without creating directories, deleting conflicts, running `git pull`, or changing symlinks.

## Output

The script should make its behavior easy to audit. Each run should show:

- whether `git pull --ff-only` ran or was skipped;
- each discovered skill;
- source path;
- target path;
- action: linked, unchanged, refreshed, skipped, conflict, or would-do in dry-run mode.

## Testing

Use focused shell checks:

- `bash -n sync-skills.sh`
- dry-run default mode;
- dry-run mixed target mode, such as `--daily global --research project`;
- `--no-pull --dry-run`;
- a local temporary project directory for project-level link behavior.

Do not require network access during tests; use `--no-pull` for link tests.
