#' Display information about a file
#'
#' Wraps `wb_command -file-information` to list information about
#' a data file's content.
#'
#' @param data_file Path to the input file.
#' @param only_map_names Logical; show only map names?
#' @param only_number_of_maps Logical; show only number of maps?
#' @param only_metadata Logical; show only metadata?
#' @param only_cifti_xml Logical; show only CIFTI XML (CIFTI files only)?
#' @param verbose Logical; print command output?
#'
#' @return Character vector of information lines, invisibly.
#'
#' @examples
#' \dontrun{
#' file_information("data.dscalar.nii")
#' file_information("data.dscalar.nii", only_map_names = TRUE)
#' }
#'
#' @export
file_information <- function(data_file,
                             only_map_names = FALSE,
                             only_number_of_maps = FALSE,
                             only_metadata = FALSE,
                             only_cifti_xml = FALSE,
                             verbose = get_wb_verbosity()) {
  check_path(data_file, arg = "data_file")

  args <- shQuote(data_file)

  if (only_map_names) args <- c(args, "-only-map-names")
  if (only_number_of_maps) args <- c(args, "-only-number-of-maps")
  if (only_metadata) args <- c(args, "-only-metadata")
  if (only_cifti_xml) args <- c(args, "-only-cifti-xml")

  wb_cmd("-file-information", args, verbose = verbose, intern = TRUE)
}
