
#' @title testPy
#' @export
testPy <- function(a,b) {
  reticulate::source_python(
    file = system.file("python", "testPy.py", package = packageName())
  )
  testPy()
}

