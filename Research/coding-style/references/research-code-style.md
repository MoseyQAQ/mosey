# Research Code Style Reference

## Intent

This skill captures Mosey's preferred style for computational condensed-matter research code: direct scripts, explicit physical assumptions, and output formats that preserve data for later inspection.

## Style Priorities

1. Make the code easy to read and edit.
2. Keep scripts compact unless repetition demands a helper.
3. Avoid business-application style input validation for known local data.
4. Do not silently choose physically meaningful details.
5. Prefer clear data output over only printing results.

## Ask Before Guessing

Ask for clarification when a detail changes interpretation:

- Which trajectory frames to use.
- Which axis/component/site/layer/species to analyze.
- Whether to average over time, space, atoms, unit cells, or components.
- Whether to unwrap, wrap, or apply the minimum-image convention.
- Which units and conversion constants to use.
- Whether to subtract a reference, normalize, smooth, or fit.

## Output Policy

Use `.txt` for simple results:

- one or a few scalar values
- a short vector
- a compact table intended for human inspection

Use `.npz` for complex results:

- arrays with multiple dimensions
- multiple related arrays
- trajectory-derived data
- intermediate quantities that may be reused
- metadata such as selected frames, units, conversion factors, atom indices, or component labels

Do not output CSV by default. Use it only if the user explicitly asks or the downstream tool requires it.

## Useful Script Pattern

```python
import numpy as np


# Hard-coded variables
input_file = "input.npy"
output_file = "result.npz"
selected_component = 2  # z component


# Load data
data = np.load(input_file)


# Compute derived quantities
result = data[..., selected_component].mean(axis=0)


# Save output
np.savez(
    output_file,
    result=result,
    selected_component=selected_component,
)
```

For a simple result:

```python
np.savetxt(
    "summary.txt",
    np.array([[mean_value, std_value]]),
    header="mean_value std_value",
)
```

## Signals From Mosey's Existing Code

- Use compact helper functions such as frame selection when repeated.
- Print short progress or selection summaries, for example number of selected frames.
- Use `np.set_printoptions()` when inspecting arrays interactively.
- Keep shape comments for nontrivial arrays.
- Use `np.full(..., np.nan)` for result arrays when unfilled values would be meaningful.
- Collapse singleton frame dimensions only when that behavior is clear from the helper contract.
- Prefer concise physical comments such as `# convert to zero-based index` or `# update coordinates to account for MIC`.
