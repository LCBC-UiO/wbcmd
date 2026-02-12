# Getting started with wbcmd

wbcmd wraps the [Connectome
Workbench](https://www.humanconnectome.org/software/connectome-workbench)
`wb_command` CLI for use in R. Every function calls the same central
dispatcher, so your environment only needs to be configured once.

## Prerequisites

Install Connectome Workbench from the [HCP
website](https://www.humanconnectome.org/software/connectome-workbench).
Then load the package and verify your setup:

``` r
library(wbcmd)
wb_sitrep()
```

If the binary is not detected automatically, point wbcmd to it:

``` r
set_wb_path("/opt/workbench/bin_linux64/wb_command")
```

You can also set the path via environment variable or R option. The
lookup order is:

1.  R option `wbcmd.path`
2.  Environment variable `WB_PATH`
3.  Platform-specific defaults
4.  System `PATH`

## Running commands

The
[`wb_cmd()`](https://drmowinckels.github.io/wbcmd/reference/wb_cmd.md)
function is the universal entry point. Pass the subcommand name and
arguments exactly as you would on the command line:

``` r
wb_cmd("-version")
wb_cmd("-file-information", c("data.dscalar.nii"))
```

## Convenience wrappers

Typed wrappers handle argument construction and file validation for you.

### Separate a CIFTI file

``` r
wb_cifti_separate(
  "data.dscalar.nii",
  direction = "COLUMN",
  metric = list(
    CORTEX_LEFT = "left.func.gii",
    CORTEX_RIGHT = "right.func.gii"
  )
)
```

### Smooth CIFTI data

``` r
wb_cifti_smoothing(
  "data.dtseries.nii",
  surface_sigma = 4,
  volume_sigma = 4,
  direction = "COLUMN",
  cifti_out = "smoothed.dtseries.nii",
  left_surface = "left.midthickness.surf.gii",
  right_surface = "right.midthickness.surf.gii"
)
```

### Parcellate

``` r
wb_cifti_parcellate(
  "data.dtseries.nii",
  "atlas.dlabel.nii",
  direction = "COLUMN",
  cifti_out = "parcellated.ptseries.nii"
)
```

### Resample a surface

``` r
wb_surface_resample(
  "lh.pial.surf.gii",
  "lh.sphere.32k.surf.gii",
  "lh.sphere.164k.surf.gii",
  method = "BARYCENTRIC",
  surface_out = "lh.pial.164k.surf.gii"
)
```

## Controlling verbosity

By default wbcmd prints each command before running it. Silence this
with:

``` r
options(wbcmd.verbose = FALSE)
```

Or set the `WB_VERBOSE` environment variable to `FALSE`.
