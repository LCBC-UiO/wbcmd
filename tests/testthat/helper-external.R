skip_if_no_wb <- function() {
  testthat::skip_if_not(have_wb(), "wb_command not available")
}

local_wb_unset <- function(.local_envir = parent.frame()) {
  withr::local_options(wbcmd.path = NULL, .local_envir = .local_envir)
  withr::local_envvar(WB_PATH = NA, .local_envir = .local_envir)
}

local_wb_path <- function(path, .local_envir = parent.frame()) {
  withr::local_options(wbcmd.path = path, .local_envir = .local_envir)
}

capture_wb_cmd <- function(.env = rlang::caller_env()) {
  captured <- new.env(parent = emptyenv())
  local_mocked_bindings(
    validate_wb_env = function(...) invisible(TRUE),
    get_wb_path = function(...) "/mock/wb_command",
    try_wb_cmd = function(command, args = character(), ...) {
      captured$command <- command
      captured$args <- args
      captured$cmd <- paste(c(command, args), collapse = " ")
      ""
    },
    .env = .env
  )
  captured
}

create_test_sphere <- function(n_vertices = 100, dir = tempdir()) {
  skip_if_no_wb()
  path <- file.path(dir, "test_sphere.surf.gii")
  wb_cmd("-surface-create-sphere", c(n_vertices, path),
         verbose = FALSE, intern = TRUE)
  path
}
