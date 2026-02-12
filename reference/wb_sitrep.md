# Situation report for Connectome Workbench

Prints a diagnostic summary of the workbench environment, including path
detection, version, and system information.

## Usage

``` r
wb_sitrep()
```

## Value

A list of diagnostic information, invisibly.

## Examples

``` r
wb_sitrep()
#> 
#> ── Connectome Workbench situation report ───────────────────────────────────────
#> 
#> ── Settings ──
#> 
#> ! wb_command path: /usr/bin/wb_command
#> ℹ Source: "default (not found)"
#> ℹ Verbose: TRUE
#> 
#> ── System ──
#> 
#> ℹ Platform: "x86_64-pc-linux-gnu"
#> ℹ OS: "Ubuntu 24.04.3 LTS"
#> ℹ R: "4.5.2"
#> 
#> ── Diagnostics ──
#> 
#> ✖ wb_command not found
#> 
#> ── Recommendations ──
#> 
#> ! Install Connectome Workbench from <https://www.humanconnectome.org/software/connectome-workbench>
#> ℹ Set the path with `set_wb_path()` or the `WB_PATH` environment variable.
```
