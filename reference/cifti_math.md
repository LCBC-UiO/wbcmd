# Evaluate expression on CIFTI files

Wraps `wb_command -cifti-math` to perform element-wise mathematical
operations on CIFTI files using an expression language.

## Usage

``` r
cifti_math(
  expression,
  cifti_out,
  var,
  fixnan = FALSE,
  override_mapping_check = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- expression:

  Math expression string (e.g. `"(x - mean) / stdev"`).

- cifti_out:

  Path for the output CIFTI file.

- var:

  Named list of input CIFTI file paths. Names correspond to variable
  names used in `expression`.

- fixnan:

  Logical; replace NaN results with 0?

- override_mapping_check:

  Logical; skip map count check?

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://drmowinckels.github.io/wbcmd/reference/wb_cmd.md)
call.

## Examples

``` r
if (FALSE) { # \dontrun{
cifti_math(
  "(x - y) / y",
  cifti_out = "pct_change.dscalar.nii",
  var = list(x = "post.dscalar.nii", y = "pre.dscalar.nii")
)
} # }
```
