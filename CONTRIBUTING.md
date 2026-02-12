# Contributing to wbcmd

Thank you for considering contributing to wbcmd!

## Adding new command wrappers

wbcmd aims to wrap all ~165 `wb_command` subcommands. Adding a new
wrapper follows a consistent pattern:

1.  Create `R/wb_<domain>_<operation>.R` (e.g., `R/wb_cifti_info.R`)
2.  Use `check_path()` to validate input files
3.  Use `validate_outfile()` to prepare output paths
4.  Call
    [`wb_cmd()`](https://drmowinckels.github.io/wbcmd/reference/wb_cmd.md)
    with the subcommand and arguments
5.  Add tests in `tests/testthat/test-wb_<domain>_<operation>.R`
6.  Run `devtools::document()` and `devtools::check()`

## Development workflow

``` r
devtools::load_all()
devtools::document()
devtools::test()
devtools::check()
```

## Code style

- Self-explanatory naming, no comments (except workarounds)
- tidyverse style
- roxygen2 documentation

## Pull requests

- One wrapper per PR is fine
- Include tests (with mocking for CI where `wb_command` is not
  available)
- Run `devtools::check()` with no errors or warnings
