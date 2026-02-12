# Compute spatial statistics on a metric file

Wraps `wb_command -metric-stats` to compute spatial statistics on a
metric file.

## Usage

``` r
metric_stats(
  metric_in,
  operation = NULL,
  percentile = NULL,
  column = NULL,
  roi = NULL,
  show_map_name = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- metric_in:

  Path to the input metric file.

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

  Path to a metric ROI file.

- show_map_name:

  Logical; print map name before each result?

- verbose:

  Logical; print command output?

## Value

Character vector of output lines (stats values).

## Examples

``` r
if (FALSE) { # \dontrun{
metric_stats("thickness.func.gii", operation = "MEAN")
} # }
```
