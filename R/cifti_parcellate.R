#' Parcellate a CIFTI file
#'
#' Wraps `wb_command -cifti-parcellate` to create parcellated data from
#' a dense CIFTI file using a label parcellation.
#'
#' @param cifti_in Path to the input CIFTI file.
#' @param cifti_label Path to the parcellation label file (`.dlabel.nii`).
#' @param direction Direction to parcellate along. One of `"COLUMN"` or `"ROW"`.
#' @param cifti_out Path for the output parcellated CIFTI file.
#' @param spatial_weights Optional spatial weights specification. A list with
#'   one element: either `left_area_surf` and `right_area_surf` paths, or
#'   `cifti_weights` path.
#' @param method Parcellation method. One of `"MEAN"` (default), `"MAX"`,
#'   `"MIN"`, `"INDEXMAX"`, `"INDEXMIN"`, `"MEDIAN"`, `"MODE"`, `"COUNT_NONZERO"`,
#'   `"SUM"`, `"STDEV"`, `"SAMPSTDEV"`, `"PERCENTILE"`.
#' @param only_numeric Logical; exclude non-numeric values?
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' cifti_parcellate(
#'   "data.dtseries.nii",
#'   "atlas.dlabel.nii",
#'   direction = "COLUMN",
#'   cifti_out = "parcellated.ptseries.nii"
#' )
#' }
#'
#' @wbHelp -cifti-parcellate
#' @export
cifti_parcellate <- function(
  cifti_in,
  cifti_label,
  direction = c("COLUMN", "ROW"),
  cifti_out,
  spatial_weights = NULL,
  method = NULL,
  only_numeric = FALSE,
  verbose = get_wb_verbosity()
) {
  check_path(cifti_in, arg = "cifti_in")
  check_path(cifti_label, arg = "cifti_label")
  direction <- match.arg(direction)
  cifti_out <- validate_outfile(cifti_out, ext = ".ptseries.nii")

  args <- c(
    shQuote(cifti_in),
    shQuote(cifti_label),
    direction,
    shQuote(cifti_out)
  )

  if (!is.null(spatial_weights)) {
    if (!is.null(spatial_weights$cifti_weights)) {
      check_path(spatial_weights$cifti_weights)
      args <- c(
        args,
        "-spatial-weights",
        "-cifti-weights",
        shQuote(spatial_weights$cifti_weights)
      )
    } else if (!is.null(spatial_weights$left_area_surf)) {
      check_path(spatial_weights$left_area_surf)
      check_path(spatial_weights$right_area_surf)
      args <- c(
        args,
        "-spatial-weights",
        "-left-area-surface",
        shQuote(spatial_weights$left_area_surf),
        "-right-area-surface",
        shQuote(spatial_weights$right_area_surf)
      )
    }
  }

  if (!is.null(method)) {
    args <- c(args, "-method", method)
  }
  if (only_numeric) {
    args <- c(args, "-only-numeric")
  }

  wb_cmd("-cifti-parcellate", args, verbose = verbose)
}
