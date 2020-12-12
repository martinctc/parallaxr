#' @title Return the default CSS document used in the parallaxr package
#'
#' @description This returns a character vector of length 1 containing the
#' default CSS document used to generate the parallax scroll document.
#'
#' @param path character. Path to where the CSS file should be saved, including
#' a file name with the ".css" file extension.
#' Defaults to NULL, where the css will be displayed on the console instead.
#'
#' @examples
#' default_css()
#'
#' @export
default_css <- function(path = NULL){

  return_css <-
    readLines(con = system.file("style.css", package = "parallaxr"), warn = FALSE) %>%
    paste(collapse = "\n")

  if(is.null(path)){
    message(return_css)

  } else {

    writeLines(return_css, con = path)
  }
}
