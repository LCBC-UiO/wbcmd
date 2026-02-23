# Render wb_command CLI help as Rd markup

Called at render time by `\Sexpr` in generated .Rd files. Returns valid
Rd markup showing CLI help or a fallback message.

## Usage

``` r
wb_help_rd(cmd)
```

## Arguments

- cmd:

  The wb_command subcommand (e.g. `"-cifti-average"`).

## Value

Character string of Rd markup.

## Examples

``` r
if (FALSE) { # \dontrun{
wb_help_rd("-cifti-average")
} # }
```
