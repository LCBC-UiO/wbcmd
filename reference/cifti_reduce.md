# Reduce a CIFTI file along a dimension

Wraps `wb_command -cifti-reduce` to perform a reduction operation (e.g.
mean, stdev) along a specified direction.

## Usage

``` r
cifti_reduce(
  cifti_in,
  direction = c("ROW", "COLUMN"),
  operation = "MEAN",
  cifti_out,
  only_numeric = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- cifti_in:

  Path to the input CIFTI file.

- direction:

  Direction to reduce. One of `"ROW"` or `"COLUMN"`.

- operation:

  Reduction operation. One of `"MAX"`, `"MIN"`, `"INDEXMAX"`,
  `"INDEXMIN"`, `"SUM"`, `"PRODUCT"`, `"MEAN"`, `"STDEV"`,
  `"SAMPSTDEV"`, `"VARIANCE"`, `"TSNR"`, `"COV"`, `"L2NORM"`,
  `"MEDIAN"`, `"MODE"`, `"COUNT_NONZERO"`.

- cifti_out:

  Path for the output CIFTI file.

- only_numeric:

  Logical; exclude non-numeric values?

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) call.

## Examples

``` r
if (FALSE) { # \dontrun{
cifti_reduce(
  "data.dtseries.nii",
  direction = "ROW",
  operation = "MEAN",
  cifti_out = "mean.dscalar.nii"
)
} # }
```
