# Display surface information

Wraps `wb_command -surface-information` to print summary information
about a surface file (vertices, triangles, bounding box, spacing).

## Usage

``` r
surface_information(surface_in, verbose = get_wb_verbosity())
```

## Arguments

- surface_in:

  Path to the input surface file.

- verbose:

  Logical; print command output?

## Value

Character vector of information lines, invisibly.

## Connectome Workbench Help

Connectome Workbench is not installed. Run
`wb_help("-surface-information")` in a session with wb_command
available.

## Examples

``` r
if (FALSE) { # \dontrun{
surface_information("lh.midthickness.surf.gii")
} # }
```
