
#' @title testPy
#' @export
testPy <- function() {

  reticulate_check_miniconda_setup(pyPackages = c('numpy', 'pandas'))

  reticulate::source_python(
    file = system.file("python", "testPy.py", package = packageName())
  )
  testPy()
}

