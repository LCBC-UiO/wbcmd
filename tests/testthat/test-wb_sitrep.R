describe("wb_sitrep()", {
  it("runs without error when wb not available", {
    local_mocked_bindings(
      have_wb = function() FALSE,
      get_wb_path = function(simplify = TRUE) {
        if (simplify) return(NULL)
        list(value = NULL, source = "not set", exists = FALSE)
      },
      wb_version = function() ""
    )

    expect_message(
      result <- wb_sitrep()
    )
    expect_type(result, "list")
    expect_false(result$available)
  })

  it("runs without error when wb is available", {
    local_mocked_bindings(
      have_wb = function() TRUE,
      get_wb_path = function(simplify = TRUE) {
        if (simplify) return("/fake/wb_command")
        list(value = "/fake/wb_command", source = "test", exists = TRUE)
      },
      wb_version = function() "1.5.0"
    )

    expect_message(
      result <- wb_sitrep()
    )
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
      wb_version = function() ""
    )

    expect_message(
      result <- wb_sitrep()
    )
    expect_named(result, c("path", "verbose", "available", "system"))
  })
})
