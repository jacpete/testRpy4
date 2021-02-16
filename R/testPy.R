
#' @title testPy
#' @export
testPy <- function() {
  reticulate::source_python(
    file = system.file("python", "testPy.py", package = packageName())
  )
  testPy()
}

