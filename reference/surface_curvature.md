# Compute surface curvature

Wraps `wb_command -surface-curvature` to compute mean and/or Gaussian
curvature of a surface.

## Usage

``` r
surface_curvature(
  surface_in,
  mean_out = NULL,
  gauss_out = NULL,
  verbose = get_wb_verbosity()
)
```

## Arguments

- surface_in:

  Path to the input surface file.

- mean_out:

  Path for the output mean curvature metric file.

- gauss_out:

  Path for the output Gaussian curvature metric file.

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://drmowinckels.github.io/wbcmd/reference/wb_cmd.md)
call.

## Examples

``` r
if (FALSE) { # \dontrun{
surface_curvature(
  "lh.midthickness.surf.gii",
  mean_out = "lh.mean_curv.func.gii"
)
} # }
```
