describe("get_wb_path()", {
  it("returns path from R option", {
    fake_path <- tempfile()
    file.create(fake_path)
    withr::defer(unlink(fake_path))
    local_wb_path(fake_path)

    expect_equal(get_wb_path(), fake_path)
  })

  it("returns full settings list when simplify = FALSE", {
    fake_path <- tempfile()
    file.create(fake_path)
    withr::defer(unlink(fake_path))
    local_wb_path(fake_path)

    result <- get_wb_path(simplify = FALSE)
    expect_type(result, "list")
    expect_equal(result$value, fake_path)
    expect_true(result$exists)
  })

  it("returns NULL when nothing configured", {
    local_wb_unset()
    local_mocked_bindings(
      wb_default_paths = function() character(0),
      sys_which = function(...) c(wb_command = "")
    )

    result <- get_wb_path(simplify = FALSE)
    expect_false(result$exists)
  })
})

describe("have_wb()", {
  it("returns TRUE when wb_command is accessible", {
    local_mocked_bindings(
      get_wb_path = function(simplify = TRUE) {
        if (simplify) return("/fake/wb_command")
        list(value = "/fake/wb_command", source = "test", exists = TRUE)
      }
    )
    expect_true(have_wb())
  })

  it("returns FALSE when wb_command is not found", {
    local_mocked_bindings(
      get_wb_path = function(simplify = TRUE) {
        if (simplify) return(NULL)
        list(value = NULL, source = "not set", exists = FALSE)
      }
    )
    expect_false(have_wb())
  })
})

describe("wb_version()", {
  it("returns empty string when workbench not available", {
    local_mocked_bindings(have_wb = function() FALSE)
    expect_equal(wb_version(), "")
  })

  it("returns version string when available", {
    skip_if_no_wb()
    version <- wb_version()
    expect_type(version, "character")
    expect_true(nzchar(version))
  })
})

describe("set_wb_path()", {
  it("sets the wbcmd.path option", {
    fake_path <- tempfile()
    file.create(fake_path)
    withr::defer(unlink(fake_path))
    withr::local_options(wbcmd.path = NULL)

    set_wb_path(fake_path)
    expect_equal(getOption("wbcmd.path"), fake_path)
  })

  it("errors on nonexistent path when check = TRUE", {
    expect_error(
      set_wb_path("/nonexistent/wb_command"),
      class = "wbcmd_error"
    )
  })

  it("skips check when check = FALSE", {
    withr::local_options(wbcmd.path = NULL)
    set_wb_path("/nonexistent/wb_command", check = FALSE)
    expect_equal(getOption("wbcmd.path"), "/nonexistent/wb_command")
  })

  it("returns old value invisibly", {
    withr::local_options(wbcmd.path = "old_path")
    fake_path <- tempfile()
    file.create(fake_path)
    withr::defer(unlink(fake_path))

    old <- set_wb_path(fake_path)
    expect_equal(old, "old_path")
  })
})
