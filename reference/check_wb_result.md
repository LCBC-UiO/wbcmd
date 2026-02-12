# Check the result of a workbench command

Validates the outcome of a `wb_command` execution by inspecting the exit
status and whether the expected output file was produced.

## Usage

``` r
check_wb_result(
  res,
  fe_before = NA,
  fe_after = NA,
  outfile = NULL,
  cmd_name = NULL
)
```

## Arguments

- res:

  The return value from
  [`system()`](https://rdrr.io/r/base/system.html).

- fe_before:

  Logical; did the output file exist before execution?

- fe_after:

  Logical; does the output file exist after execution?

- outfile:

  Path to the expected output file.

- cmd_name:

  The command name, for diagnostic messages.

## Value

`res`, invisibly.
