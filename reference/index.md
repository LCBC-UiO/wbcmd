# Package index

## Command execution

Core dispatcher and command helpers

- [`wb_cmd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_cmd.md) :
  Execute a Connectome Workbench command
- [`wb_help()`](https://lcbc-uio.github.io/wbcmd/reference/wb_help.md) :
  Access wb_command help text
- [`wb_help_rd()`](https://lcbc-uio.github.io/wbcmd/reference/wb_help_rd.md)
  : Render wb_command CLI help as Rd markup
- [`check_wb_result()`](https://lcbc-uio.github.io/wbcmd/reference/check_wb_result.md)
  : Check the result of a workbench command

## Environment setup

Detect, configure, and diagnose the workbench environment

- [`wb_sitrep()`](https://lcbc-uio.github.io/wbcmd/reference/wb_sitrep.md)
  : Situation report for Connectome Workbench
- [`wb_version()`](https://lcbc-uio.github.io/wbcmd/reference/wb_version.md)
  : Get Connectome Workbench version
- [`have_wb()`](https://lcbc-uio.github.io/wbcmd/reference/have_wb.md) :
  Check if Connectome Workbench is available
- [`set_wb_path()`](https://lcbc-uio.github.io/wbcmd/reference/set_wb_path.md)
  : Set the path to wb_command
- [`get_wb_path()`](https://lcbc-uio.github.io/wbcmd/reference/get_wb_path.md)
  : Find the wb_command executable
- [`get_wb_setting()`](https://lcbc-uio.github.io/wbcmd/reference/get_wb_setting.md)
  : Look up a workbench setting
- [`get_wb_verbosity()`](https://lcbc-uio.github.io/wbcmd/reference/get_wb_verbosity.md)
  : Get the workbench verbosity setting

## CIFTI operations

Operations on CIFTI files not covered by ciftiTools

- [`cifti_average()`](https://lcbc-uio.github.io/wbcmd/reference/cifti_average.md)
  : Average multiple CIFTI files
- [`cifti_correlation()`](https://lcbc-uio.github.io/wbcmd/reference/cifti_correlation.md)
  : Compute correlation of CIFTI rows
- [`cifti_dilate()`](https://lcbc-uio.github.io/wbcmd/reference/cifti_dilate.md)
  : Dilate a CIFTI file
- [`cifti_find_clusters()`](https://lcbc-uio.github.io/wbcmd/reference/cifti_find_clusters.md)
  : Find clusters in a CIFTI file
- [`cifti_gradient()`](https://lcbc-uio.github.io/wbcmd/reference/cifti_gradient.md)
  : Compute gradient of a CIFTI file
- [`cifti_math()`](https://lcbc-uio.github.io/wbcmd/reference/cifti_math.md)
  : Evaluate expression on CIFTI files
- [`cifti_parcellate()`](https://lcbc-uio.github.io/wbcmd/reference/cifti_parcellate.md)
  : Parcellate a CIFTI file
- [`cifti_reduce()`](https://lcbc-uio.github.io/wbcmd/reference/cifti_reduce.md)
  : Reduce a CIFTI file along a dimension
- [`cifti_stats()`](https://lcbc-uio.github.io/wbcmd/reference/cifti_stats.md)
  : Compute statistics on a CIFTI file
- [`cifti_weighted_stats()`](https://lcbc-uio.github.io/wbcmd/reference/cifti_weighted_stats.md)
  : Compute weighted statistics on a CIFTI file

## Surface operations

Surface geometry computations

- [`surface_curvature()`](https://lcbc-uio.github.io/wbcmd/reference/surface_curvature.md)
  : Compute surface curvature
- [`surface_distortion()`](https://lcbc-uio.github.io/wbcmd/reference/surface_distortion.md)
  : Measure distortion between surfaces
- [`surface_generate_inflated()`](https://lcbc-uio.github.io/wbcmd/reference/surface_generate_inflated.md)
  : Generate inflated surface
- [`surface_geodesic_distance()`](https://lcbc-uio.github.io/wbcmd/reference/surface_geodesic_distance.md)
  : Compute geodesic distance from a vertex
- [`surface_information()`](https://lcbc-uio.github.io/wbcmd/reference/surface_information.md)
  : Display surface information
- [`surface_vertex_areas()`](https://lcbc-uio.github.io/wbcmd/reference/surface_vertex_areas.md)
  : Compute vertex areas of a surface

## Metric operations

Operations on metric (per-vertex) files

- [`metric_math()`](https://lcbc-uio.github.io/wbcmd/reference/metric_math.md)
  : Evaluate expression on metric files
- [`metric_stats()`](https://lcbc-uio.github.io/wbcmd/reference/metric_stats.md)
  : Compute spatial statistics on a metric file

## Volume operations

Operations on volume files

- [`volume_math()`](https://lcbc-uio.github.io/wbcmd/reference/volume_math.md)
  : Evaluate expression on volume files
- [`volume_to_surface_mapping()`](https://lcbc-uio.github.io/wbcmd/reference/volume_to_surface_mapping.md)
  : Map volume data to a surface

## General

File inspection utilities

- [`file_information()`](https://lcbc-uio.github.io/wbcmd/reference/file_information.md)
  : Display information about a file
