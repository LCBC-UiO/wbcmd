#' Generate inflated surface
#'
#' Wraps `wb_command -surface-generate-inflated` to create inflated and
#' very-inflated surfaces from an anatomical surface.
#'
#' @param anatomical_surface Path to the input anatomical surface file.
#' @param inflated_out Path for the output inflated surface.
#' @param very_inflated_out Path for the output very-inflated surface.
#' @param iterations_scale Scale factor for inflation iterations.
#'   Default is `1.0`; use `2.5` for 164k meshes.
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' surface_generate_inflated(
#'   "lh.midthickness.surf.gii",
#'   "lh.inflated.surf.gii",
#'   "lh.very_inflated.surf.gii"
#' )
#' }
#'
#' @export
surface_generate_inflated <- function(anatomical_surface,
                                      inflated_out,
                                      very_inflated_out,
                                      iterations_scale = NULL,
                                      verbose = get_wb_verbosity()) {
  check_path(anatomical_surface, arg = "anatomical_surface")
  inflated_out <- validate_outfile(inflated_out, ext = ".surf.gii")
  very_inflated_out <- validate_outfile(very_inflated_out, ext = ".surf.gii")

  args <- c(
    shQuote(anatomical_surface),
    shQuote(inflated_out),
    shQuote(very_inflated_out)
  )

  if (!is.null(iterations_scale)) {
    args <- c(args, "-iterations-scale", iterations_scale)
  }

  wb_cmd("-surface-generate-inflated", args, verbose = verbose)
}
