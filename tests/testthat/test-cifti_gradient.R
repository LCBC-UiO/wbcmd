describe("cifti_gradient()", {
  it("constructs correct command", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_gradient(f, direction = "COLUMN",
                   cifti_out = tempfile(fileext = ".dscalar.nii"),
                   verbose = FALSE)

    expect_match(captured$cmd, "-cifti-gradient")
    expect_match(captured$cmd, "COLUMN")
  })

  it("includes surface and presmooth arguments", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    ls <- tempfile(fileext = ".surf.gii")
    rs <- tempfile(fileext = ".surf.gii")
    file.create(f, ls, rs)
    withr::defer(unlink(c(f, ls, rs)))

    cifti_gradient(f, direction = "COLUMN",
                   cifti_out = tempfile(fileext = ".dscalar.nii"),
                   left_surface = ls, right_surface = rs,
                   surface_presmooth = 2, verbose = FALSE)

    expect_match(captured$cmd, "-left-surface")
    expect_match(captured$cmd, "-right-surface")
    expect_match(captured$cmd, "-surface-presmooth 2")
  })

  it("includes average-output flag", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_gradient(f, cifti_out = tempfile(fileext = ".dscalar.nii"),
                   average_output = TRUE, verbose = FALSE)

    expect_match(captured$cmd, "-average-output")
  })
})
