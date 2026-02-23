# Compute weighted statistics on a CIFTI file

Wraps `wb_command -cifti-weighted-stats` to compute spatially-weighted
statistics along CIFTI columns.

## Usage

``` r
cifti_weighted_stats(
  cifti_in,
  operation = NULL,
  percentile = NULL,
  spatial_weights = FALSE,
  cifti_weights = NULL,
  column = NULL,
  roi = NULL,
  show_map_name = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- cifti_in:

  Path to the input CIFTI file.

- operation:

  One of `"MEAN"`, `"STDEV"`, `"SAMPSTDEV"`, `"SUM"`.

- percentile:

  Numeric percentile (alternative to `operation`).

- spatial_weights:

  Logical; use vertex areas and voxel volumes as weights?

- cifti_weights:

  Path to a CIFTI file to use as weights.

- column:

  Integer; compute for a single column only (1-indexed).

- roi:

  Path to a CIFTI ROI file.

- show_map_name:

  Logical; print map name before each result?

- verbose:

  Logical; print command output?

## Value

Character vector of output lines (stats values).

## Connectome Workbench Help

Connectome Workbench is not installed. Run
`wb_help("-cifti-weighted-stats")` in a session with wb_command
available.

## Examples

``` r
if (FALSE) { # \dontrun{
cifti_weighted_stats("data.dscalar.nii", operation = "MEAN",
                     spatial_weights = TRUE)
} # }
```
