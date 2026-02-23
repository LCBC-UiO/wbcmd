# Display information about a file

Wraps `wb_command -file-information` to list information about a data
file's content.

## Usage

``` r
file_information(
  data_file,
  only_map_names = FALSE,
  only_number_of_maps = FALSE,
  only_metadata = FALSE,
  only_cifti_xml = FALSE,
  verbose = get_wb_verbosity()
)
```

## Arguments

- data_file:

  Path to the input file.

- only_map_names:

  Logical; show only map names?

- only_number_of_maps:

  Logical; show only number of maps?

- only_metadata:

  Logical; show only metadata?

- only_cifti_xml:

  Logical; show only CIFTI XML (CIFTI files only)?

- verbose:

  Logical; print command output?

## Value

Character vector of information lines, invisibly.

## Connectome Workbench Help

Connectome Workbench is not installed. Run
`wb_help("-file-information")` in a session with wb_command available.

## Examples

``` r
if (FALSE) { # \dontrun{
file_information("data.dscalar.nii")
file_information("data.dscalar.nii", only_map_names = TRUE)
} # }
```
