# Research Code Style Examples

Use the [main skill](../SKILL.md) for code organization, physical correctness, and output policy. The examples below illustrate those rules.

## Ask Before Guessing

Ask for clarification when a detail changes interpretation:

- Which trajectory frames to use.
- Which axis/component/site/layer/species to analyze.
- Whether to average over time, space, atoms, unit cells, or components.
- Whether to unwrap, wrap, or apply the minimum-image convention.
- Which units and conversion constants to use.
- Whether to subtract a reference, normalize, smooth, or fit.

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

- Print short progress or selection summaries, for example number of selected frames.
- Use `np.set_printoptions()` when inspecting arrays interactively.
- Use `np.full(..., np.nan)` for result arrays when unfilled values would be meaningful.
- Collapse singleton frame dimensions only when that behavior is clear from the helper contract.
- Prefer concise physical comments such as `# convert to zero-based index` or `# update coordinates to account for MIC`.
