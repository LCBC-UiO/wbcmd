describe("volume_math()", {
  it("constructs correct command with variables", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".nii.gz")
    file.create(f)
    withr::defer(unlink(f))

    volume_math("x + 1", tempfile(fileext = ".nii.gz"),
                var = list(x = f), verbose = FALSE)

    expect_match(captured$cmd, "-volume-math")
    expect_match(captured$cmd, "x \\+ 1")
    expect_match(captured$cmd, "-var x")
  })

  it("includes fixnan flag", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".nii.gz")
    file.create(f)
    withr::defer(unlink(f))

    volume_math("x / y", tempfile(fileext = ".nii.gz"),
                var = list(x = f, y = f), fixnan = TRUE,
                verbose = FALSE)

    expect_match(captured$cmd, "-fixnan")
  })

  it("errors on missing input", {
    expect_error(
      volume_math("x", tempfile(), var = list(x = "/nonexistent.nii.gz")),
      class = "wbcmd_error"
    )
  })
})

describe("volume_to_surface_mapping()", {
  it("constructs command with trilinear method", {
    captured <- capture_wb_cmd()
    vol <- tempfile(fileext = ".nii.gz")
    surf <- tempfile(fileext = ".surf.gii")
    file.create(vol, surf)
    withr::defer(unlink(c(vol, surf)))

    volume_to_surface_mapping(
      vol, surf,
      metric_out = tempfile(fileext = ".func.gii"),
      method = "trilinear",
      verbose = FALSE
    )

    expect_match(captured$cmd, "-volume-to-surface-mapping")
    expect_match(captured$cmd, "-trilinear")
  })

  it("constructs command with ribbon-constrained method", {
    captured <- capture_wb_cmd()
    vol <- tempfile(fileext = ".nii.gz")
    surf <- tempfile(fileext = ".surf.gii")
    inner <- tempfile(fileext = ".surf.gii")
    outer <- tempfile(fileext = ".surf.gii")
    file.create(vol, surf, inner, outer)
    withr::defer(unlink(c(vol, surf, inner, outer)))

    volume_to_surface_mapping(
      vol, surf,
      metric_out = tempfile(fileext = ".func.gii"),
      method = "ribbon-constrained",
      inner_surface = inner,
      outer_surface = outer,
      verbose = FALSE
    )

    expect_match(captured$cmd, "-ribbon-constrained")
  })

  it("errors when ribbon-constrained missing surfaces", {
    vol <- tempfile(fileext = ".nii.gz")
    surf <- tempfile(fileext = ".surf.gii")
    file.create(vol, surf)
    withr::defer(unlink(c(vol, surf)))

    expect_error(
      volume_to_surface_mapping(vol, surf, tempfile(),
                                method = "ribbon-constrained"),
      class = "wbcmd_error"
    )
  })
})
