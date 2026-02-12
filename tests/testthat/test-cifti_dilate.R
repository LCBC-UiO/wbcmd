describe("cifti_dilate()", {
  it("constructs correct command", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_dilate(f, direction = "COLUMN",
                 surface_distance = 10, volume_distance = 10,
                 cifti_out = tempfile(fileext = ".dscalar.nii"),
                 verbose = FALSE)

    expect_match(captured$cmd, "-cifti-dilate")
    expect_match(captured$cmd, "COLUMN 10 10")
  })

  it("includes surface arguments", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    ls <- tempfile(fileext = ".surf.gii")
    rs <- tempfile(fileext = ".surf.gii")
    file.create(f, ls, rs)
    withr::defer(unlink(c(f, ls, rs)))

    cifti_dilate(f, direction = "COLUMN",
                 surface_distance = 5, volume_distance = 5,
                 cifti_out = tempfile(fileext = ".dscalar.nii"),
                 left_surface = ls, right_surface = rs,
                 verbose = FALSE)

    expect_match(captured$cmd, "-left-surface")
    expect_match(captured$cmd, "-right-surface")
  })

  it("includes nearest flag", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_dilate(f, surface_distance = 5, volume_distance = 5,
                 cifti_out = tempfile(fileext = ".dscalar.nii"),
                 nearest = TRUE, verbose = FALSE)

    expect_match(captured$cmd, "-nearest")
  })
})
