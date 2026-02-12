# Look up a workbench setting

Resolves a setting by checking R options, then environment variables,
then a list of default paths.

## Usage

``` r
get_wb_setting(opt_var, env_var, defaults = NULL, is_path = TRUE)
```

## Arguments

- opt_var:

  Name of the R option (e.g. `"wbcmd.path"`).

- env_var:

  Name of the environment variable (e.g. `"WB_PATH"`).

- defaults:

  Character vector of fallback values to try.

- is_path:

  If `TRUE`, checks whether the resolved value exists on disk.

## Value

A list with elements `value`, `source`, and `exists`.

## Examples

``` r
get_wb_setting("wbcmd.path", "WB_PATH", defaults = "/usr/bin")
#> $value
#> [1] "/usr/bin"
#> 
#> $source
#> [1] "default"
#> 
#> $exists
#> [1] TRUE
#> 
```
