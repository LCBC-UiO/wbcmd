# Compute geodesic distance from a vertex

Wraps `wb_command -surface-geodesic-distance` to compute the geodesic
distance from a single vertex to all other vertices on a surface.

## Usage

``` r
surface_geodesic_distance(
  surface_in,
  vertex,
  metric_out,
  limit = NULL,
  corrected_areas = NULL,
  verbose = get_wb_verbosity()
)
```

## Arguments

- surface_in:

  Path to the input surface file.

- vertex:

  Index of the source vertex (0-indexed).

- metric_out:

  Path for the output metric file.

- limit:

  Maximum geodesic distance in mm. Vertices beyond this distance get
  value `-1`.

- corrected_areas:

  Path to a metric file of corrected vertex areas (for group-average
  surfaces).

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) call.

## Connectome Workbench Help

Connectome Workbench is not installed. Run
`wb_help("-surface-geodesic-distance")` in a session with wb_command
available.

## Examples

``` r
if (FALSE) { # \dontrun{
surface_geodesic_distance(
  "lh.midthickness.surf.gii",
  vertex = 0,
  metric_out = "geodesic.func.gii",
  limit = 100
)
} # }
```
