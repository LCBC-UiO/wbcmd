# Find clusters in a CIFTI file

Wraps `wb_command -cifti-find-clusters` to threshold a CIFTI file and
filter clusters by surface area and volume size.

## Usage

``` r
cifti_find_clusters(
  cifti_in,
  surface_value_threshold,
  surface_minimum_area,
  volume_value_threshold,
  volume_minimum_size,
  direction = c("COLUMN", "ROW"),
  cifti_out,
  left_surface = NULL,
  right_surface = NULL,
  less_than = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- cifti_in:

  Path to the input CIFTI file.

- surface_value_threshold:

  Minimum value for surface vertices.

- surface_minimum_area:

  Minimum cluster surface area (mm^2).

- volume_value_threshold:

  Minimum value for volume voxels.

- volume_minimum_size:

  Minimum cluster volume size (mm^3).

- direction:

  Direction to use. One of `"ROW"` or `"COLUMN"`.

- cifti_out:

  Path for the output CIFTI file.

- left_surface:

  Path to the left hemisphere surface.

- right_surface:

  Path to the right hemisphere surface.

- less_than:

  Logical; find clusters below threshold instead of above?

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://drmowinckels.github.io/wbcmd/reference/wb_cmd.md)
call.

## Examples

``` r
if (FALSE) { # \dontrun{
cifti_find_clusters(
  "zstats.dscalar.nii",
  surface_value_threshold = 2.3,
  surface_minimum_area = 100,
  volume_value_threshold = 2.3,
  volume_minimum_size = 200,
  direction = "COLUMN",
  cifti_out = "clusters.dscalar.nii",
  left_surface = "left.midthickness.surf.gii",
  right_surface = "right.midthickness.surf.gii"
)
} # }
```
