#' @title Convert Markdown text to HTML fragment
#'
#' @description
#' This is a wrapper around `markdown::markdownToHTML()`, where
#' the default behaviour is to produce a HTML fragment.
#' `htmltools::HTML()` is then used to evaluate the HTML code
#' within a RMarkdown chunk.
#'
#' @importFrom htmltools HTML
#' @importFrom markdown markdownToHTML
#'
#' @param text Character vector containing Markdown text
#'
md2html <- function(text){

  html_chunk <- markdown::markdownToHTML(text = text,
                                         fragment.only = TRUE)

  htmltools::HTML(html_chunk)

}
