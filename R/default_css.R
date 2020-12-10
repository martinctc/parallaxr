#' @title Return the default CSS document used in the parallaxr package
#'
#' @description This returns a character vector of length 1 containing the default
#' CSS document used to generate the parallax scroll document.
#'
#' @export
default_css <- function(){

  readLines(con = system.file("style.css", package = "parallaxr"), warn = FALSE) %>%
    paste(collapse = " ")

}
