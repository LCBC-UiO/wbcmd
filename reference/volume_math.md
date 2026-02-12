# Evaluate expression on volume files

Wraps `wb_command -volume-math` to perform element-wise mathematical
operations on volume files at each voxel.

## Usage

``` r
volume_math(
  expression,
  volume_out,
  var,
  fixnan = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- expression:

  Math expression string (e.g. `"(x - y) / y * 100"`).

- volume_out:

  Path for the output volume file.

- var:

  Named list of input volume file paths. Names correspond to variable
  names used in `expression`.

- fixnan:

  Logical; replace NaN results with 0?

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) call.

## Examples

``` r
if (FALSE) { # \dontrun{
volume_math(
  "clamp(x, 0, 100)",
  volume_out = "clamped.nii.gz",
  var = list(x = "input.nii.gz")
)
} # }
```
