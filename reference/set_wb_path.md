# Set the path to wb_command

Set the path to wb_command

## Usage

``` r
set_wb_path(path, check = TRUE)
```

## Arguments

- path:

  Path to the `wb_command` executable.

- check:

  If `TRUE`, verify the path exists before setting.

## Value

The previous value of the option, invisibly.

## Examples

``` r
if (FALSE) { # \dontrun{
set_wb_path("/opt/workbench/bin/wb_command")
} # }
```
