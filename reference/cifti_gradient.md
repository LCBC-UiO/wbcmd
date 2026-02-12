# Compute gradient of a CIFTI file

Wraps `wb_command -cifti-gradient` to compute the spatial gradient of
each column in a CIFTI file.

## Usage

``` r
cifti_gradient(
  cifti_in,
  direction = c("COLUMN", "ROW"),
  cifti_out,
  left_surface = NULL,
  right_surface = NULL,
  surface_presmooth = NULL,
  volume_presmooth = NULL,
  average_output = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- cifti_in:

  Path to the input CIFTI file.

- direction:

  Direction to take gradient. One of `"COLUMN"` or `"ROW"`.

- cifti_out:

  Path for the output gradient CIFTI file.

- left_surface:

  Path to the left hemisphere surface.

- right_surface:

  Path to the right hemisphere surface.

- surface_presmooth:

  Surface pre-smoothing sigma in mm.

- volume_presmooth:

  Volume pre-smoothing sigma in mm.

- average_output:

  Logical; average the gradient across all maps?

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://drmowinckels.github.io/wbcmd/reference/wb_cmd.md)
call.

## Examples

``` r
if (FALSE) { # \dontrun{
cifti_gradient(
  "data.dscalar.nii",
  direction = "COLUMN",
  cifti_out = "gradient.dscalar.nii",
  left_surface = "left.midthickness.surf.gii",
  right_surface = "right.midthickness.surf.gii"
)
} # }
```
