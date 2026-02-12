# Average multiple CIFTI files

Wraps `wb_command -cifti-average` to compute the element-wise average
across multiple CIFTI files.

## Usage

``` r
cifti_average(
  cifti_out,
  cifti_in,
  weights = NULL,
  verbose = get_wb_verbosity()
)
```

## Arguments

- cifti_out:

  Path for the output averaged CIFTI file.

- cifti_in:

  Character vector of input CIFTI file paths.

- weights:

  Optional numeric vector of weights (same length as `cifti_in`).

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) call.

## Examples

``` r
if (FALSE) { # \dontrun{
cifti_average(
  "group_mean.dscalar.nii",
  c("subj01.dscalar.nii", "subj02.dscalar.nii", "subj03.dscalar.nii")
)
} # }
```
