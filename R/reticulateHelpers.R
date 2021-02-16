
#' @title List Conda Packages
#' @description This is almost a direct copy of the unexported
#'   reticulate::conda_list_packages function and the other functions needed to
#'   run it that are also unexported from {reticulate}. Need to look into how to
#'   apply the copyright notice for the Apache 2.0 license.
#' @export
reticulate_conda_list_packages <- function(envname = NULL, conda = 'auto', no_pip = TRUE) {

  conda <- reticulate::conda_binary(conda)
  envname <- reticulate_condaenv_resolve(envname)
  # message(paste0("Using conda environment: ", envname))

  # create the environment
  args <- c("list")
  if (grepl("[/\\]", envname)) {
    args <- c(args, "--prefix", envname)
  } else {
    args <- c(args, "--name", envname)
  }

  if (no_pip)
    args <- c(args, "--no-pip")

  args <- c(args, "--json")

  output <- system2(conda, shQuote(args), stdout = TRUE)
  status <- attr(output, "status") %||% 0L
  if (status != 0L) {
    fmt <- "error listing conda environment [status code %i]"
    stopf(fmt, status)
  }

  parsed <- jsonlite::fromJSON(output)

  data.frame(
    package     = parsed$name,
    version     = parsed$version,
    requirement = paste(parsed$name, parsed$version, sep = "="),
    channel     = parsed$channel,
    stringsAsFactors = FALSE
  )


}


`%||%` <- function(x, y) if (is.null(x)) y else x

reticulate_condaenv_resolve <- function(envname = NULL) {

  reticulate_python_environment_resolve(
    envname = envname,
    resolve = identity
  )

}

reticulate_python_environment_resolve <- function(envname = NULL, resolve = identity) {

  # use RETICULATE_PYTHON_ENV as default
  envname <- envname %||% Sys.getenv("RETICULATE_PYTHON_ENV", unset = "r-reticulate")

  # treat environment 'names' containing slashes as full paths
  if (grepl("[/\\]", envname)) {
    envname <- normalizePath(envname, winslash = "/", mustWork = FALSE)
    return(envname)
  }

  # otherwise, resolve the environment name as necessary
  resolve(envname)

}



#' @title Does MiniConda Exist?
#' @export
reticulate_miniconda_exists <- function(path = reticulate::miniconda_path()) {
  conda <- reticulate_miniconda_conda(path)
  file.exists(conda)
}

reticulate_is_windows <- function() {
  identical(.Platform$OS.type, "windows")
}

reticulate_miniconda_conda <- function(path = reticulate::miniconda_path()) {
  exe <- if (reticulate_is_windows()) "condabin/conda.bat" else "bin/conda"
  file.path(path, exe)
}



# pyPackages <- c('numpy', 'pandas')

reticulate_check_dependencies <- function(pyPackages) {

  installedPyPackages <- reticulate_conda_list_packages()

  toInstall <- pyPackages[!(pyPackages %in% installedPyPackages$package)]

  if (length(toInstall) != 0) {
    condaEnv <- dirname(reticulate::py_config()[['python']])
    reticulate::conda_install(envname = condaEnv,
                              packages = pyPackages)
  }

}



