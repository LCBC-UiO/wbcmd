# wbcmd

wbcmd provides R wrapper functions for the [Connectome
Workbench](https://www.humanconnectome.org/software/connectome-workbench)
command-line tool (`wb_command`).

## Installation

You can install the development version of wbcmd from
[GitHub](https://github.com/lcbc-uio/wbcmd) with:

``` r
# install.packages("pak")
pak::pak("lcbc-uio/wbcmd")
```

You also need [Connectome
Workbench](https://www.humanconnectome.org/software/connectome-workbench)
installed on your system.

## Setup

wbcmd looks for `wb_command` in the following order:

1.  The R option `wbcmd.path`
2.  The environment variable `WB_PATH`
3.  Platform-specific default installation paths
4.  The system `PATH`

Check your setup with:

``` r
library(wbcmd)
wb_sitrep()
```

If `wb_command` is not found automatically, set the path explicitly:

``` r
set_wb_path("/path/to/wb_command")
```

## Usage

All commands flow through the central
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md)
dispatcher:

``` r
wb_cmd("-version")
wb_cmd("-cifti-info", c("data.dscalar.nii"))
```

Convenience wrappers provide a more ergonomic interface:

``` r
wb_cifti_separate(
  "data.dscalar.nii",
  direction = "COLUMN",
  metric = list(
    CORTEX_LEFT = "left.func.gii",
    CORTEX_RIGHT = "right.func.gii"
  )
)

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

Get help for any subcommand:

``` r
wb_help("-cifti-separate")
```
