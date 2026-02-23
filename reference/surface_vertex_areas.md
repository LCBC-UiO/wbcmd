# Compute vertex areas of a surface

Wraps `wb_command -surface-vertex-areas` to measure the surface area (in
mm^2) that each vertex is responsible for.

## Usage

``` r
surface_vertex_areas(surface_in, metric_out, verbose = get_wb_verbosity())
```

## Arguments

- surface_in:

  Path to the input surface file.

- metric_out:

  Path for the output metric file.

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) call.

## Connectome Workbench Help

Connectome Workbench is not installed. Run
`wb_help("-surface-vertex-areas")` in a session with wb_command
available.

## Examples

``` r
if (FALSE) { # \dontrun{
surface_vertex_areas(
  "lh.midthickness.surf.gii",
  "lh.vertex_areas.func.gii"
)
} # }
```
