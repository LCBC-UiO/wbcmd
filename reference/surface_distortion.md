# Measure distortion between surfaces

Wraps `wb_command -surface-distortion` to compute distortion between two
surfaces on the same mesh.

## Usage

``` r
surface_distortion(
  surface_reference,
  surface_distorted,
  metric_out,
  smooth = NULL,
  caret5_method = FALSE,
  edge_method = FALSE,
  local_affine_method = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- surface_reference:

  Path to the reference surface.

- surface_distorted:

  Path to the distorted surface.

- metric_out:

  Path for the output distortion metric file.

- smooth:

  Smoothing sigma for area distortion (mm). Only used with the default
  area-based method.

- caret5_method:

  Logical; use the Caret5 method?

- edge_method:

  Logical; use edge-based distortion?

- local_affine_method:

  Logical; use local affine method?

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) call.

## Examples

``` r
if (FALSE) { # \dontrun{
surface_distortion(
  "lh.sphere.surf.gii",
  "lh.sphere.reg.surf.gii",
  "lh.distortion.func.gii"
)
} # }
```
