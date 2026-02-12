# Generate inflated surface

Wraps `wb_command -surface-generate-inflated` to create inflated and
very-inflated surfaces from an anatomical surface.

## Usage

``` r
surface_generate_inflated(
  anatomical_surface,
  inflated_out,
  very_inflated_out,
  iterations_scale = NULL,
  verbose = get_wb_verbosity()
)
```

## Arguments

- anatomical_surface:

  Path to the input anatomical surface file.

- inflated_out:

  Path for the output inflated surface.

- very_inflated_out:

  Path for the output very-inflated surface.

- iterations_scale:

  Scale factor for inflation iterations. Default is `1.0`; use `2.5` for
  164k meshes.

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) call.

## Examples

``` r
if (FALSE) { # \dontrun{
surface_generate_inflated(
  "lh.midthickness.surf.gii",
  "lh.inflated.surf.gii",
  "lh.very_inflated.surf.gii"
)
} # }
```
