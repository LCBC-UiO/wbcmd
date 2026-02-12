describe("get_wb_setting()", {
  it("returns value from R option first", {
    withr::local_options(test.setting = "/custom/path")
    withr::local_envvar(TEST_SETTING = "/env/path")

    result <- get_wb_setting("test.setting", "TEST_SETTING", is_path = FALSE)
    expect_equal(result$value, "/custom/path")
    expect_match(result$source, "option")
  })

  it("falls back to env var when option is not set", {
    withr::local_options(test.setting = NULL)
    withr::local_envvar(TEST_SETTING = "/env/path")

    result <- get_wb_setting("test.setting", "TEST_SETTING", is_path = FALSE)
    expect_equal(result$value, "/env/path")
    expect_match(result$source, "envvar")
  })

  it("falls back to defaults when option and env var are not set", {
    withr::local_options(test.setting = NULL)
    withr::local_envvar(TEST_SETTING = NA)

    result <- get_wb_setting(
      "test.setting",
      "TEST_SETTING",
      defaults = "fallback_val",
      is_path = FALSE
    )
    expect_equal(result$value, "fallback_val")
    expect_match(result$source, "default")
  })

  it("returns not set when nothing is configured", {
    withr::local_options(test.setting = NULL)
    withr::local_envvar(TEST_SETTING = NA)

    result <- get_wb_setting("test.setting", "TEST_SETTING")
    expect_null(result$value)
    expect_equal(result$source, "not set")
    expect_false(result$exists)
  })

  it("checks path existence when is_path = TRUE", {
    withr::local_options(test.setting = tempdir())

    result <- get_wb_setting("test.setting", "TEST_SETTING", is_path = TRUE)
    expect_true(result$exists)
  })

  it("reports non-existent paths", {
    withr::local_options(test.setting = "/nonexistent/path/xyz")

    result <- get_wb_setting("test.setting", "TEST_SETTING", is_path = TRUE)
    expect_false(result$exists)
  })
})

describe("get_wb_verbosity()", {
  it("returns TRUE by default", {
    withr::local_options(wbcmd.verbose = NULL)
    withr::local_envvar(WB_VERBOSE = NA)

    expect_true(get_wb_verbosity())
  })

  it("respects R option", {
    withr::local_options(wbcmd.verbose = "FALSE")

    expect_false(get_wb_verbosity())
  })

  it("respects env var", {
    withr::local_options(wbcmd.verbose = NULL)
    withr::local_envvar(WB_VERBOSE = "FALSE")

    expect_false(get_wb_verbosity())
  })
})
