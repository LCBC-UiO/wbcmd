describe("metric_math()", {
  it("constructs correct command with variables", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".func.gii")
    file.create(f)
    withr::defer(unlink(f))

    metric_math("x * 2", tempfile(fileext = ".func.gii"),
                var = list(x = f), verbose = FALSE)

    expect_match(captured$cmd, "-metric-math")
    expect_match(captured$cmd, "x \\* 2")
    expect_match(captured$cmd, "-var x")
  })

  it("includes fixnan flag", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".func.gii")
    file.create(f)
    withr::defer(unlink(f))

    metric_math("x / y", tempfile(fileext = ".func.gii"),
                var = list(x = f, y = f), fixnan = TRUE,
                verbose = FALSE)

    expect_match(captured$cmd, "-fixnan")
  })

  it("errors on missing input", {
    expect_error(
      metric_math("x", tempfile(), var = list(x = "/nonexistent.gii")),
      class = "wbcmd_error"
    )
  })
})

describe("metric_stats()", {
  it("constructs command with reduce", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".func.gii")
    file.create(f)
    withr::defer(unlink(f))

    metric_stats(f, operation = "MEAN", verbose = FALSE)

    expect_match(captured$cmd, "-metric-stats")
    expect_match(captured$cmd, "-reduce MEAN")
  })

  it("constructs command with percentile", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".func.gii")
    file.create(f)
    withr::defer(unlink(f))

    metric_stats(f, percentile = 75, verbose = FALSE)

    expect_match(captured$cmd, "-percentile 75")
  })

  it("computes stats on real metric file", {
    skip_if_no_wb()
    sphere <- create_test_sphere()
    withr::defer(unlink(sphere))
    areas <- tempfile(fileext = ".func.gii")
    withr::defer(unlink(areas))

    surface_vertex_areas(sphere, areas, verbose = FALSE)
    result <- metric_stats(areas, operation = "MEAN", verbose = FALSE)

    expect_type(result, "character")
    expect_true(length(result) > 0)
    expect_false(is.na(as.numeric(trimws(result[[1]]))))
  })
})
