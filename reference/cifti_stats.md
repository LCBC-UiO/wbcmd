# Compute statistics on a CIFTI file

Wraps `wb_command -cifti-stats` to compute statistics along CIFTI
columns.

## Usage

``` r
cifti_stats(
  cifti_in,
  operation = NULL,
  percentile = NULL,
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

  Reduction operation. One of `"MAX"`, `"MIN"`, `"INDEXMAX"`,
  `"INDEXMIN"`, `"SUM"`, `"PRODUCT"`, `"MEAN"`, `"STDEV"`,
  `"SAMPSTDEV"`, `"VARIANCE"`, `"TSNR"`, `"COV"`, `"L2NORM"`,
  `"MEDIAN"`, `"MODE"`, `"COUNT_NONZERO"`.

- percentile:

  Numeric percentile to compute (alternative to `operation`).

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

## Examples

``` r
if (FALSE) { # \dontrun{
cifti_stats("data.dscalar.nii", operation = "MEAN")
cifti_stats("data.dscalar.nii", percentile = 95)
} # }
```
