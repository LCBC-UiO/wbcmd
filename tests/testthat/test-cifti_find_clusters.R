describe("cifti_find_clusters()", {
  it("constructs correct command with thresholds", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_find_clusters(
      f,
      surface_value_threshold = 2.3,
      surface_minimum_area = 100,
      volume_value_threshold = 2.3,
      volume_minimum_size = 200,
      direction = "COLUMN",
      cifti_out = tempfile(fileext = ".dscalar.nii"),
      verbose = FALSE
    )

    expect_match(captured$cmd, "-cifti-find-clusters")
    expect_match(captured$cmd, "2\\.3 100 2\\.3 200 COLUMN")
  })

  it("includes less-than flag", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_find_clusters(
      f, 2.3, 100, 2.3, 200,
      cifti_out = tempfile(fileext = ".dscalar.nii"),
      less_than = TRUE, verbose = FALSE
    )

    expect_match(captured$cmd, "-less-than")
  })
})
