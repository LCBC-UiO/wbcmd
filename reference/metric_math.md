# Evaluate expression on metric files

Wraps `wb_command -metric-math` to perform element-wise mathematical
operations on metric files at each surface vertex.

## Usage

``` r
metric_math(
  expression,
  metric_out,
  var,
  fixnan = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- expression:

  Math expression string (e.g. `"(x - mean) / stdev"`).

- metric_out:

  Path for the output metric file.

- var:

  Named list of input metric file paths. Names correspond to variable
  names used in `expression`.

- fixnan:

  Logical; replace NaN results with 0?

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) call.

## Connectome Workbench Help

Connectome Workbench is not installed. Run `wb_help("-metric-math")` in
a session with wb_command available.

## Examples

``` r
if (FALSE) { # \dontrun{
metric_math(
  "abs(x - y)",
  metric_out = "diff.func.gii",
  var = list(x = "post.func.gii", y = "pre.func.gii")
)
} # }
```
