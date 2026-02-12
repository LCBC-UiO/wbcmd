# Execute a Connectome Workbench command

Central dispatcher for all `wb_command` operations. Command wrappers
call this function to construct, execute, and validate workbench
commands.

## Usage

``` r
wb_cmd(
  cmd,
  args = character(),
  ...,
  verbose = get_wb_verbosity(),
  intern = verbose
)
```

## Arguments

- cmd:

  The wb_command subcommand (e.g. `"-cifti-separate"`).

- args:

  Character vector of arguments to pass after `cmd`.

- ...:

  Additional arguments, currently unused.

- verbose:

  Logical; print command output? Defaults to
  [`get_wb_verbosity()`](https://lcbc-uio.github.io/wbcmd/reference/get_wb_verbosity.md).

- intern:

  Logical; capture output as character vector? Defaults to the value of
  `verbose`.

## Value

If `intern = TRUE`, a character vector of command output. Otherwise the
exit status (integer).

## Examples

``` r
if (FALSE) { # \dontrun{
wb_cmd("-version")
wb_cmd("-cifti-separate", c("input.dscalar.nii", "COLUMN"))
} # }
```
