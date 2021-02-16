#' @title addR
#' @export
addR <- function(a,b) {
  return(a + b)
}

#' @title addPy
#' @param a,b Things to add
#' @export
addPy <- function(a,b) {
  reticulate::source_python(
    file = system.file("python", "addPy.py", package = packageName())
  )
  addPy(a,b)
}

