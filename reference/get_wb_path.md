# Find the wb_command executable

Searches for the `wb_command` binary using R options, environment
variables, default installation paths, and `PATH`.

## Usage

``` r
get_wb_path(simplify = TRUE)
```

## Arguments

- simplify:

  If `TRUE`, return just the path string. If `FALSE`, return the full
  settings list.

## Value

Character path to `wb_command`, or a settings list when
`simplify = FALSE`.

## Examples

``` r
if (FALSE) { # \dontrun{
get_wb_path()
} # }
```
