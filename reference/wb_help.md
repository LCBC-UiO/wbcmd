# Access wb_command help text

Retrieves the help text for a given `wb_command` subcommand.

## Usage

``` r
wb_help(cmd = NULL)
```

## Arguments

- cmd:

  The subcommand to get help for (e.g. `"-cifti-separate"`). If `NULL`,
  shows the top-level help listing all subcommands.

## Value

Character vector of help text lines, invisibly.

## Examples

``` r
if (FALSE) { # \dontrun{
wb_help()
wb_help("-cifti-separate")
} # }
```
