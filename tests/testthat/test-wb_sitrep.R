describe("wb_sitrep()", {
  mock_sys_info <- function() {
    list(
      platform = "x86_64-pc-linux-gnu",
      r_version = "4.4.0",
      os = "Ubuntu 22.04",
      shell = "/bin/bash"
    )
  }

  it("reports when wb not available", {
    local_mocked_bindings(
      have_wb = function() FALSE,
      get_wb_path = function(simplify = TRUE) {
        if (simplify) return(NULL)
        list(value = NULL, source = "not set", exists = FALSE)
      },
      wb_version = function() "",
      sys_info = mock_sys_info
    )

    expect_snapshot(result <- wb_sitrep())
    expect_type(result, "list")
    expect_false(result$available)
  })

  it("reports when wb is available", {
    local_mocked_bindings(
      have_wb = function() TRUE,
      get_wb_path = function(simplify = TRUE) {
        if (simplify) return("/fake/wb_command")
        list(value = "/fake/wb_command", source = "test", exists = TRUE)
      },
      wb_version = function() "1.5.0",
      sys_info = mock_sys_info
    )

    expect_snapshot(result <- wb_sitrep())
    expect_type(result, "list")
    expect_true(result$available)
  })

  it("returns diagnostic information invisibly", {
    local_mocked_bindings(
      have_wb = function() FALSE,
      get_wb_path = function(simplify = TRUE) {
        if (simplify) return(NULL)
        list(value = NULL, source = "not set", exists = FALSE)
      },
      wb_version = function() "",
      sys_info = mock_sys_info
    )

    expect_snapshot(result <- wb_sitrep())
    expect_named(result, c("path", "verbose", "available", "system"))
  })
})
