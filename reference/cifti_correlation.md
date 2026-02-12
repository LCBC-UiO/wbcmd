# Compute correlation of CIFTI rows

Wraps `wb_command -cifti-correlation` to generate a row-wise correlation
matrix from a CIFTI file.

## Usage

``` r
cifti_correlation(
  cifti_in,
  cifti_out,
  roi_override = NULL,
  weights = NULL,
  fisher_z = FALSE,
  no_demean = FALSE,
  covariance = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- cifti_in:

  Path to the input CIFTI file.

- cifti_out:

  Path for the output correlation CIFTI file.

- roi_override:

  Path to a CIFTI ROI file to restrict computation.

- weights:

  Path to a text file of column weights.

- fisher_z:

  Logical; apply Fisher z-transform to correlations?

- no_demean:

  Logical; skip demeaning before correlation?

- covariance:

  Logical; compute covariance instead of correlation?

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://drmowinckels.github.io/wbcmd/reference/wb_cmd.md)
call.

## Examples

``` r
if (FALSE) { # \dontrun{
cifti_correlation(
  "data.dtseries.nii",
  "corr.dconn.nii",
  fisher_z = TRUE
)
} # }
```
