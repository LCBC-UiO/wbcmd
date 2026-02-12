describe("surface_generate_inflated()", {
  it("constructs correct command", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".surf.gii")
    file.create(f)
    withr::defer(unlink(f))

    surface_generate_inflated(
      f,
      tempfile(fileext = ".surf.gii"),
      tempfile(fileext = ".surf.gii"),
      verbose = FALSE
    )

    expect_match(captured$cmd, "-surface-generate-inflated")
  })

  it("includes iterations-scale", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".surf.gii")
    file.create(f)
    withr::defer(unlink(f))

    surface_generate_inflated(
      f,
      tempfile(fileext = ".surf.gii"),
      tempfile(fileext = ".surf.gii"),
      iterations_scale = 2.5,
      verbose = FALSE
    )

    expect_match(captured$cmd, "-iterations-scale 2.5")
  })

  it("produces output files", {
    skip_if_no_wb()
    sphere <- create_test_sphere()
    withr::defer(unlink(sphere))
    inflated <- tempfile(fileext = ".surf.gii")
    very_inflated <- tempfile(fileext = ".surf.gii")
    withr::defer(unlink(c(inflated, very_inflated)))

    surface_generate_inflated(sphere, inflated, very_inflated,
                              verbose = FALSE)

    expect_true(file.exists(inflated))
    expect_true(file.exists(very_inflated))
  })
})

describe("surface_geodesic_distance()", {
  it("constructs correct command", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".surf.gii")
    file.create(f)
    withr::defer(unlink(f))

    surface_geodesic_distance(f, vertex = 0,
                              metric_out = tempfile(fileext = ".func.gii"),
                              verbose = FALSE)

    expect_match(captured$cmd, "-surface-geodesic-distance")
    expect_match(captured$cmd, " 0 ")
  })

  it("includes limit", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".surf.gii")
    file.create(f)
    withr::defer(unlink(f))

    surface_geodesic_distance(f, vertex = 10,
                              metric_out = tempfile(fileext = ".func.gii"),
                              limit = 50, verbose = FALSE)

    expect_match(captured$cmd, "-limit 50")
  })

  it("computes distances from a vertex", {
    skip_if_no_wb()
    sphere <- create_test_sphere()
    withr::defer(unlink(sphere))
    metric_out <- tempfile(fileext = ".func.gii")
    withr::defer(unlink(metric_out))

    surface_geodesic_distance(sphere, vertex = 0,
                              metric_out = metric_out, verbose = FALSE)

    expect_true(file.exists(metric_out))
  })
})

describe("surface_vertex_areas()", {
  it("constructs correct command", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".surf.gii")
    file.create(f)
    withr::defer(unlink(f))

    surface_vertex_areas(f, tempfile(fileext = ".func.gii"),
                         verbose = FALSE)

    expect_match(captured$cmd, "-surface-vertex-areas")
  })

  it("computes vertex areas", {
    skip_if_no_wb()
    sphere <- create_test_sphere()
    withr::defer(unlink(sphere))
    metric_out <- tempfile(fileext = ".func.gii")
    withr::defer(unlink(metric_out))

    surface_vertex_areas(sphere, metric_out, verbose = FALSE)

    expect_true(file.exists(metric_out))
  })
})

describe("surface_curvature()", {
  it("constructs command with mean curvature", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".surf.gii")
    file.create(f)
    withr::defer(unlink(f))

    surface_curvature(f, mean_out = tempfile(fileext = ".func.gii"),
                      verbose = FALSE)

    expect_match(captured$cmd, "-surface-curvature")
    expect_match(captured$cmd, "-mean")
  })

  it("constructs command with gaussian curvature", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".surf.gii")
    file.create(f)
    withr::defer(unlink(f))

    surface_curvature(f, gauss_out = tempfile(fileext = ".func.gii"),
                      verbose = FALSE)

    expect_match(captured$cmd, "-gauss")
  })

  it("computes curvature", {
    skip_if_no_wb()
    sphere <- create_test_sphere()
    withr::defer(unlink(sphere))
    mean_out <- tempfile(fileext = ".func.gii")
    withr::defer(unlink(mean_out))

    surface_curvature(sphere, mean_out = mean_out, verbose = FALSE)

    expect_true(file.exists(mean_out))
  })
})

describe("surface_distortion()", {
  it("constructs correct command", {
    captured <- capture_wb_cmd()
    f1 <- tempfile(fileext = ".surf.gii")
    f2 <- tempfile(fileext = ".surf.gii")
    file.create(f1, f2)
    withr::defer(unlink(c(f1, f2)))

    surface_distortion(f1, f2, tempfile(fileext = ".func.gii"),
                       verbose = FALSE)

    expect_match(captured$cmd, "-surface-distortion")
  })

  it("includes method flags", {
    captured <- capture_wb_cmd()
    f1 <- tempfile(fileext = ".surf.gii")
    f2 <- tempfile(fileext = ".surf.gii")
    file.create(f1, f2)
    withr::defer(unlink(c(f1, f2)))

    surface_distortion(f1, f2, tempfile(fileext = ".func.gii"),
                       edge_method = TRUE, verbose = FALSE)

    expect_match(captured$cmd, "-edge-method")
  })
})

describe("surface_information()", {
  it("constructs correct command", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".surf.gii")
    file.create(f)
    withr::defer(unlink(f))

    surface_information(f, verbose = FALSE)

    expect_match(captured$cmd, "-surface-information")
  })

  it("returns surface info", {
    skip_if_no_wb()
    sphere <- create_test_sphere()
    withr::defer(unlink(sphere))

    info <- surface_information(sphere, verbose = FALSE)

    expect_type(info, "character")
    expect_true(any(grepl("Vertices", info)))
    expect_true(any(grepl("Triangles", info)))
  })
})
