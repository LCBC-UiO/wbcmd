#' Look up a workbench setting
#'
#' Resolves a setting by checking R options, then environment variables,
#' then a list of default paths.
#'
#' @param opt_var Name of the R option (e.g. `"wbcmd.path"`).
#' @param env_var Name of the environment variable (e.g. `"WB_PATH"`).
#' @param defaults Character vector of fallback values to try.
#' @param is_path If `TRUE`, checks whether the resolved value exists on disk.
#'
#' @return A list with elements `value`, `source`, and `exists`.
#'
#' @examples
#' get_wb_setting("wbcmd.path", "WB_PATH", defaults = "/usr/bin")
#'
#' @export
get_wb_setting <- function(opt_var, env_var, defaults = NULL, is_path = TRUE) {
  opt_val <- getOption(opt_var)
  if (!is.null(opt_val) && nzchar(opt_val)) {
    return(return_setting(opt_val, source = paste0("option: ", opt_var), is_path = is_path))
  }

  env_val <- Sys.getenv(env_var, unset = "")
  if (nzchar(env_val)) {
    return(return_setting(env_val, source = paste0("envvar: ", env_var), is_path = is_path))
  }

  if (!is.null(defaults) && length(defaults) > 0) {
    for (d in defaults) {
      resolved <- return_setting(d, source = "default", is_path = is_path)
      if (resolved$exists) return(resolved)
    }
    return(return_setting(defaults[[1]], source = "default (not found)", is_path = is_path))
  }

  list(value = NULL, source = "not set", exists = FALSE)
}

#' Format a resolved setting
#'
#' @param value The resolved value.
#' @param source Where the value came from.
#' @param is_path Whether to check file existence.
#'
#' @return A list with `value`, `source`, and `exists`.
#' @noRd
return_setting <- function(value, source, is_path = TRUE) {
  exists <- if (is_path) file.exists(value) else TRUE
  list(value = value, source = source, exists = exists)
}

#' Get the workbench verbosity setting
#'
#' @return Logical indicating whether verbose output is enabled.
#'
#' @examples
#' get_wb_verbosity()
#'
#' @export
get_wb_verbosity <- function() {
  setting <- get_wb_setting(
    "wbcmd.verbose",
    "WB_VERBOSE",
    defaults = "TRUE",
    is_path = FALSE
  )
  as.logical(setting$value)
}
