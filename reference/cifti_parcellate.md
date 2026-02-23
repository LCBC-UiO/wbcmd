# Parcellate a CIFTI file

Wraps `wb_command -cifti-parcellate` to create parcellated data from a
dense CIFTI file using a label parcellation.

## Usage

``` r
cifti_parcellate(
  cifti_in,
  cifti_label,
  direction = c("COLUMN", "ROW"),
  cifti_out,
  spatial_weights = NULL,
  method = NULL,
  only_numeric = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- cifti_in:

  Path to the input CIFTI file.

- cifti_label:

  Path to the parcellation label file (`.dlabel.nii`).

- direction:

  Direction to parcellate along. One of `"COLUMN"` or `"ROW"`.

- cifti_out:

  Path for the output parcellated CIFTI file.

- spatial_weights:

  Optional spatial weights specification. A list with one element:
  either `left_area_surf` and `right_area_surf` paths, or
  `cifti_weights` path.

- method:

  Parcellation method. One of `"MEAN"` (default), `"MAX"`, `"MIN"`,
  `"INDEXMAX"`, `"INDEXMIN"`, `"MEDIAN"`, `"MODE"`, `"COUNT_NONZERO"`,
  `"SUM"`, `"STDEV"`, `"SAMPSTDEV"`, `"PERCENTILE"`.

- only_numeric:

  Logical; exclude non-numeric values?

- verbose:

  Logical; print command output?

## Value

The result of the underlying
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) call.

## Connectome Workbench Help

Connectome Workbench is not installed. Run
`wb_help("-cifti-parcellate")` in a session with wb_command available.

## Examples

``` r
if (FALSE) { # \dontrun{
cifti_parcellate(
  "data.dtseries.nii",
  "atlas.dlabel.nii",
  direction = "COLUMN",
  cifti_out = "parcellated.ptseries.nii"
)
} # }
```
