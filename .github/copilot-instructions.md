# wbcmd — LLM Development Context

## What this package does

R wrapper for Connectome Workbench `wb_command` CLI (~165 neuroimaging subcommands).
Architecture mirrors the `freesurfer2` package dispatcher pattern.

## Architecture

```
Command wrappers (cifti_*, surface_*, metric_*, volume_*, file_*)
        │
        ▼
    wb_cmd()  ← central dispatcher, all wrappers call this
        │
        ├── validate_wb_env() → have_wb() → get_wb_path() → get_wb_setting()
        ├── try_wb_cmd()      → system() call
        └── check_wb_result() → validates exit status + output files
```

### Settings hierarchy

Lookup order: R option → environment variable → platform defaults → PATH

| Setting | R option | Env var |
|---|---|---|
| Binary path | `wbcmd.path` | `WB_PATH` |
| Verbosity | `wbcmd.verbose` | `WB_VERBOSE` |

macOS default: `/Applications/wb_view.app/Contents/usr/bin/wb_command`

## Naming conventions

- **Core infra** keeps `wb_` prefix: `wb_cmd()`, `wb_sitrep()`, `wb_help()`, `wb_version()`, `have_wb()`, `get_wb_path()`, `set_wb_path()`
- **Command wrappers** use the wb_command domain as prefix, no `wb_`: `cifti_parcellate()`, `surface_vertex_areas()`, `metric_math()`, `volume_math()`, `file_information()`
- Function names map directly to wb_command subcommands: `cifti_reduce()` → `-cifti-reduce`

## Adding a new wrapper

1. Create `R/<domain>_<operation>.R` (e.g. `R/cifti_erode.R`)
2. Pattern:
   ```r
   #' [Title matching wb_command description]
   #'
   #' Wraps `wb_command -<subcommand>` ...
   #' @export
   my_wrapper <- function(required_input, ..., verbose = get_wb_verbosity()) {
     check_path(required_input, arg = "required_input")  # validate inputs
     outfile <- validate_outfile(outfile, ext = ".ext")   # prepare outputs
     args <- c(shQuote(required_input), ...)              # build args
     wb_cmd("-subcommand", args, verbose = verbose)       # dispatch
   }
   ```
3. Create `tests/testthat/test-<domain>_<operation>.R` with:
   - **Mock tests**: use `capture_wb_cmd()` to verify command construction
   - **Integration tests**: wrap in `skip_if_no_wb()`, use `create_test_sphere()` for fixtures
   - **Validation tests**: verify errors on missing files (class `"wbcmd_error"`)
4. Run `devtools::document()` then `devtools::check()`

## Testing patterns

```r
# Mock test — verifies command string without running wb_command
it("constructs correct command", {
  captured <- capture_wb_cmd()
  # ... call wrapper ...
  expect_match(captured$cmd, "-subcommand")
  expect_match(captured$cmd, "expected_arg")
})

# Integration test — actually runs wb_command
it("produces output", {
  skip_if_no_wb()
  sphere <- create_test_sphere()
  # ... call wrapper with real files ...
  expect_true(file.exists(output))
})
```

`capture_wb_cmd()` returns an environment (not list) so `$cmd` updates by reference.

## ciftiTools overlap — do NOT wrap these

ciftiTools already covers ~19 wb_command subcommands. Avoid wrapping:
`-cifti-separate`, `-cifti-merge`, `-cifti-smoothing`, `-cifti-convert`,
`-cifti-create-dense-timeseries`, `-cifti-create-dense-scalar`, `-cifti-create-label`,
`-cifti-change-mapping`, `-cifti-resample`, `-surface-resample`,
`-surface-create-sphere`, `-surface-flip-lr`, `-set-structure`,
`-metric-resample`, `-label-resample`, `-metric-smoothing`, `-metric-merge`,
`-nifti-information`, `-set-map-names`, `-volume-label-import`

## Code style

- No comments except workarounds for upstream bugs
- Self-explanatory naming
- tidyverse style, roxygen2 docs
- `describe()`/`it()` test structure
- Never use `package::` or `package:::` in tests
- Always test for expected messages/warnings/errors, never suppress them
- Use `cli` for user-facing messages via `wb_abort()`, `wb_warn()`, `wb_inform()`
- These helpers pass `.envir = rlang::caller_env()` to cli for correct glue scoping

## Key files

| File | Purpose |
|---|---|
| `R/wb_cmd.R` | Central dispatcher + `try_wb_cmd()` |
| `R/wb_setup.R` | Path detection, `have_wb()`, `wb_version()` |
| `R/get_wb_setting.R` | Hierarchical config lookup |
| `R/wb_sitrep.R` | Diagnostic situation report |
| `R/check_wb_result.R` | Exit status + output file validation |
| `R/utils.R` | `temp_file()`, `mkdir()`, `sys_info()`, `validate_wb_env()` |
| `R/utils-files.R` | `check_path()`, `batch_file_exists()`, `validate_outfile()` |
| `R/utils-outputs.R` | `wb_abort()`, `wb_warn()`, `wb_inform()` wrappers |
| `tests/testthat/helper-external.R` | `skip_if_no_wb()`, `capture_wb_cmd()`, `create_test_sphere()` |

## Dependencies

Runtime: `cli`, `lifecycle`, `rlang`, `tools`, `utils`
Test: `testthat` (>= 3.0.0), `withr`
System: Connectome Workbench (`wb_command`)
