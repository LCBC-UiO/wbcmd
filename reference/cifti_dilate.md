# Dilate a CIFTI file

Wraps `wb_command -cifti-dilate` to fill in zeros or missing data with
values from nearby brainordinates.

## Usage

``` r
cifti_dilate(
  cifti_in,
  direction = c("COLUMN", "ROW"),
  surface_distance,
  volume_distance,
  cifti_out,
  left_surface = NULL,
  right_surface = NULL,
  nearest = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- cifti_in:

  Path to the input CIFTI file.

- direction:

  Direction to dilate. One of `"COLUMN"` or `"ROW"`.

- surface_distance:

  Surface dilation distance in mm.

- volume_distance:

  Volume dilation distance in mm.

- cifti_out:

  Path for the output CIFTI file.

- left_surface:

  Path to the left hemisphere surface.

- right_surface:

  Path to the right hemisphere surface.

- nearest:

  Logical; use nearest good value instead of weighted average?

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://drmowinckels.github.io/wbcmd/reference/wb_cmd.md)
call.

## Examples

``` r
if (FALSE) { # \dontrun{
cifti_dilate(
  "data.dscalar.nii",
  direction = "COLUMN",
  surface_distance = 10,
  volume_distance = 10,
  cifti_out = "dilated.dscalar.nii",
  left_surface = "left.midthickness.surf.gii",
  right_surface = "right.midthickness.surf.gii"
)
} # }
```
