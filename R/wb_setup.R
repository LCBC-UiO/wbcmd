#' Find the wb_command executable
#'
#' Searches for the `wb_command` binary using R options, environment
#' variables, default installation paths, and `PATH`.
#'
#' @param simplify If `TRUE`, return just the path string.
#'   If `FALSE`, return the full settings list.
#'
#' @return Character path to `wb_command`, or a settings list
#'   when `simplify = FALSE`.
#'
#' @examples
#' \dontrun{
#' get_wb_path()
#' }
#'
#' @export
get_wb_path <- function(simplify = TRUE) {
  platform_defaults <- wb_default_paths()

  setting <- get_wb_setting(
    opt_var = "wbcmd.path",
    env_var = "WB_PATH",
    defaults = platform_defaults,
    is_path = TRUE
  )

  if (!setting$exists) {
    path_lookup <- Sys.which("wb_command")
    if (nzchar(path_lookup)) {
      setting <- list(
        value = unname(path_lookup),
        source = "PATH",
        exists = TRUE
      )
    }
  }

  if (simplify) setting$value else setting
}

#' Check if Connectome Workbench is available
#'
#' @return `TRUE` if `wb_command` is found and executable.
#'
#' @examples
#' have_wb()
#'
#' @export
have_wb <- function() {
  setting <- get_wb_path(simplify = FALSE)
  setting$exists
}

#' Get Connectome Workbench version
#'
#' @return Character string with the workbench version, or
#'   an empty string if unavailable.
#'
#' @examples
#' \dontrun{
#' wb_version()
#' }
#'
#' @export
wb_version <- function() {
  if (!have_wb()) return("")
  tryCatch(
    {
      res <- system2(
        get_wb_path(),
        args = "-version",
        stdout = TRUE,
        stderr = TRUE
      )
      paste(res, collapse = "\n")
    },
    error = function(e) ""
  )
}

#' Set the path to wb_command
#'
#' @param path Path to the `wb_command` executable.
#' @param check If `TRUE`, verify the path exists before setting.
#'
#' @return The previous value of the option, invisibly.
#'
#' @examples
#' \dontrun{
#' set_wb_path("/opt/workbench/bin/wb_command")
#' }
#'
#' @export
set_wb_path <- function(path, check = TRUE) {
  if (check && !file.exists(path)) {
    wb_abort("Path does not exist: {.path {path}}")
  }
  old <- getOption("wbcmd.path")
  options(wbcmd.path = path)
  invisible(old)
}

#' Default installation paths for wb_command
#'
#' @return Character vector of platform-specific default paths.
#' @noRd
wb_default_paths <- function() {
  sys <- Sys.info()[["sysname"]]
  switch(sys,
    Darwin = c(
      "/Applications/wb_view.app/Contents/usr/bin/wb_command",
      "/Applications/workbench/bin_macosx64/wb_command",
      "/Applications/workbench/bin_macosx_arm64/wb_command"
    ),
    Linux = c(
      "/usr/bin/wb_command",
      "/usr/local/bin/wb_command",
      "/opt/workbench/bin_linux64/wb_command",
      "/opt/workbench/bin_rh_linux64/wb_command"
    ),
    Windows = c(
      "C:/Program Files/workbench/bin_windows64/wb_command.exe"
    ),
    character(0)
  )
}
