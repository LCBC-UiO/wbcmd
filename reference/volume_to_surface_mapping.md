# Map volume data to a surface

Wraps `wb_command -volume-to-surface-mapping` to project volume data
onto a surface mesh.

## Usage

``` r
volume_to_surface_mapping(
  volume_in,
  surface,
  metric_out,
  method = c("trilinear", "enclosing", "cubic", "ribbon-constrained", "myelin-style"),
  inner_surface = NULL,
  outer_surface = NULL,
  verbose = get_wb_verbosity()
)
```

## Arguments

- volume_in:

  Path to the input volume file.

- surface:

  Path to the surface to map onto.

- metric_out:

  Path for the output metric file.

- method:

  Mapping method. One of `"trilinear"`, `"enclosing"`, `"cubic"`,
  `"ribbon-constrained"`, `"myelin-style"`.

- inner_surface:

  Path to the inner surface (required for `"ribbon-constrained"` and
  `"myelin-style"`).

- outer_surface:

  Path to the outer surface (required for `"ribbon-constrained"` and
  `"myelin-style"`).

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) call.

## Examples

``` r
if (FALSE) { # \dontrun{
volume_to_surface_mapping(
  "bold.nii.gz",
  "lh.midthickness.surf.gii",
  "lh.bold.func.gii",
  method = "ribbon-constrained",
  inner_surface = "lh.white.surf.gii",
  outer_surface = "lh.pial.surf.gii"
)
} # }
```
