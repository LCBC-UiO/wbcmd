# Getting started with wbcmd

If you work with neuroimaging data in R, you’ve probably typed out a
[`system()`](https://rdrr.io/r/base/system.html) call to `wb_command` at
some point. Maybe you wrapped it in a helper function. Maybe that helper
grew. wbcmd is the version of that helper that validates your inputs,
finds your binary, and gets out of the way.

## Finding the binary

Install [Connectome
Workbench](https://www.humanconnectome.org/software/connectome-workbench),
then load the package:

``` r
library(wbcmd)
wb_sitrep()
```

[`wb_sitrep()`](https://lcbc-uio.github.io/wbcmd/reference/wb_sitrep.md)
checks whether the binary is reachable and prints what it finds. On
macOS and Linux, wbcmd searches common installation paths and the system
`PATH` automatically.

If the binary lives somewhere unusual, tell wbcmd where:

``` r
set_wb_path("/opt/workbench/bin_linux64/wb_command")
```

The full lookup order is:

1.  R option `wbcmd.path`
2.  Environment variable `WB_PATH`
3.  Platform-specific defaults (e.g. `/Applications/wb_view.app/...` on
    macOS)
4.  System `PATH`

Set `WB_PATH` in your `.Renviron` and you never think about it again.

## The direct route

[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) is
the universal entry point. It takes the subcommand name and arguments
exactly as you would type them on the command line:

``` r
wb_cmd("-version")
wb_cmd("-file-information", "data.dscalar.nii")
```

Every wrapper function in wbcmd calls
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md)
internally. If a wrapper doesn’t exist for the command you need,
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md)
always works.

## Wrappers

The wrappers handle argument construction, file validation, and output
path management. They error before the command runs if an input file is
missing, and they create output directories on the fly.

### Parcellate CIFTI data

``` r
cifti_parcellate(
  "data.dtseries.nii",
  "atlas.dlabel.nii",
  direction = "COLUMN",
  cifti_out = "parcellated.ptseries.nii"
)
```

### Compute a correlation matrix

``` r
cifti_correlation(
  "data.dtseries.nii",
  "corr.dconn.nii",
  fisher_z = TRUE
)
```

### Reduce across maps

``` r
cifti_reduce(
  "data.dtseries.nii",
  direction = "ROW",
  operation = "MEAN",
  cifti_out = "mean.dscalar.nii"
)
```

### Surface curvature

``` r
surface_curvature(
  "lh.midthickness.surf.gii",
  mean_out = "lh.curvature.func.gii"
)
```

### Map a volume to a surface

``` r
volume_to_surface_mapping(
  "bold.nii.gz",
  "lh.midthickness.surf.gii",
  metric_out = "lh.bold.func.gii",
  method = "ribbon-constrained",
  inner_surface = "lh.white.surf.gii",
  outer_surface = "lh.pial.surf.gii"
)
```

### Math expressions

[`cifti_math()`](https://lcbc-uio.github.io/wbcmd/reference/cifti_math.md),
[`metric_math()`](https://lcbc-uio.github.io/wbcmd/reference/metric_math.md),
and
[`volume_math()`](https://lcbc-uio.github.io/wbcmd/reference/volume_math.md)
all take a symbolic expression and a named list of file paths:

``` r
cifti_math(
  "(x + y) / 2",
  cifti_out = "average.dscalar.nii",
  var = list(
    x = "subj01.dscalar.nii",
    y = "subj02.dscalar.nii"
  )
)
```

### Getting help

Every wrapper function includes a “Connectome Workbench Help” section in
its documentation, pulled directly from `wb_command` at build time. You
can also call
[`wb_help()`](https://lcbc-uio.github.io/wbcmd/reference/wb_help.md)
interactively:

``` r
wb_help("-cifti-parcellate")
```

## Using wbcmd with ciftiTools

[ciftiTools](https://github.com/mandymejia/ciftiTools) reads and writes
CIFTI files as R objects. wbcmd runs Workbench operations on those
files. They complement each other — ciftiTools gives you the data in R,
wbcmd gives you the processing pipeline.

Both packages need the same binary. Point them to the same path and they
share the setup:

``` r
wb_path <- "/opt/workbench/bin_linux64/wb_command"

wbcmd::set_wb_path(wb_path)
ciftiTools::ciftiTools.setOption("wb_path", wb_path)
```

A typical workflow reads data with ciftiTools, processes files with
wbcmd, then reads the results back:

``` r
library(ciftiTools)
library(wbcmd)

xii <- read_cifti("data.dtseries.nii", brainstructures = "all")

cifti_parcellate(
  "data.dtseries.nii",
  "atlas.dlabel.nii",
  direction = "COLUMN",
  cifti_out = "parcellated.ptseries.nii"
)

parcellated <- read_cifti("parcellated.ptseries.nii")
```

ciftiTools also has its own `run_wb_cmd()` function that takes a
pre-formatted command string. If you already use that, wbcmd’s
[`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) does
the same job with the addition of path detection, argument quoting, and
verbose logging.

## Controlling verbosity

By default, wbcmd prints the full command before running it. Turn that
off for cleaner output:

``` r
options(wbcmd.verbose = FALSE)
```

Or set `WB_VERBOSE=FALSE` in your `.Renviron`.
