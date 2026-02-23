describe("wb_cmd()", {
  it("errors when workbench is not available", {
    local_mocked_bindings(have_wb = function() FALSE)

    expect_error(
      wb_cmd("-version"),
      class = "wbcmd_error"
    )
  })

  it("constructs and executes command", {
    skip_if_no_wb()
    result <- wb_cmd("-version", verbose = FALSE, intern = TRUE)
    expect_type(result, "character")
    expect_true(length(result) > 0)
  })

  it("passes args correctly", {
    executed_args <- NULL
    local_mocked_bindings(
      validate_wb_env = function(...) invisible(TRUE),
      get_wb_path = function(...) "/fake/wb_command",
      try_wb_cmd = function(command, args = character(), ...) {
        executed_args <<- args
        ""
      }
    )

    wb_cmd("-cifti-info", c("input.nii"), verbose = FALSE, intern = TRUE)
    expect_true("-cifti-info" %in% executed_args)
    expect_true("input.nii" %in% executed_args)
  })

  it("informs when verbose = TRUE", {
    local_mocked_bindings(
      validate_wb_env = function(...) invisible(TRUE),
      get_wb_path = function(...) "/fake/wb_command",
      try_wb_cmd = function(command, ...) ""
    )

    expect_message(
      wb_cmd("-version", verbose = TRUE, intern = TRUE),
      class = "wbcmd_message"
    )
  })
})

describe("try_wb_cmd()", {
  it("captures output when intern = TRUE", {
    skip_if_no_wb()
    result <- try_wb_cmd(
      get_wb_path(),
      args = "-version",
      intern = TRUE
    )
    expect_type(result, "character")
  })
})
