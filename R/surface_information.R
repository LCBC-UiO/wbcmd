#' Display surface information
#'
#' Wraps `wb_command -surface-information` to print summary information
#' about a surface file (vertices, triangles, bounding box, spacing).
#'
#' @param surface_in Path to the input surface file.
#' @param verbose Logical; print command output?
#'
#' @return Character vector of information lines, invisibly.
#'
#' @examples
#' \dontrun{
#' surface_information("lh.midthickness.surf.gii")
#' }
#'
#' @export
surface_information <- function(surface_in,
                                verbose = get_wb_verbosity()) {
  check_path(surface_in, arg = "surface_in")

  wb_cmd("-surface-information", shQuote(surface_in),
         verbose = verbose, intern = TRUE)
}
