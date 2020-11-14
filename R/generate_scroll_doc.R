#' @title Generate a HTML scroll document, passing a tibble with parameters as an argument
#'
#' @description Pass a tibble with three columns to the `inputs` argument in
#' `generate_scroll_doc()`: `content`, `position`, and `imgurl`. The function then returns
#' a HTML document that will be saved in the location specified with `path`. The tibble
#' with parameters can be generated with `parse_md()` and `purrr::bind_rows()` (see
#' examples).
#'
#' @param path character string. Specify the path for the HTML file to be written.
#' @param inputs A tibble or data frame with three columns:
#' - `content`: content in HTML to be written onto the page
#' - `position`: either "left" or "right" to specify whether content
#' should appear on the left or right.
#' - `imgurl`: URL for the image.
#'
#' @examples
#' \dontrun{
#' md_tibble <-
#'   purrr::bind_rows(parse_md("Markdown/1.md"),
#'                    parse_md("Markdown/2.md"),
#'                    parse_md("Markdown/3.md"))
#'
#' generate_scroll_doc(path = "parallax-document.html",
#'                     inputs = md_tibble)
#' }
#'
#' @export
generate_scroll_doc <- function(path, inputs){
  headtext <- c(
  "<!DOCTYPE html>
  <html>
  <head>")

  foottext <- readLines(con = system.file("footer.html", package = "parallaxr"), warn = FALSE) %>% paste(collapse = " ")
  csstext <- readLines(con = system.file("style.css", package = "parallaxr"), warn = FALSE)
  csstext_col <- paste(csstext, collapse = " ")

  p <- paste(headtext, '<style>', csstext_col, '</style>', '</head>')

  input_chr <-
    inputs %>%
    purrr::pmap_chr(scroll_section) %>%
    paste(collapse = " ")


  paste0(p,
         "<body>",
         input_chr,
         "</body>",
         foottext) %>%
    writeLines(path)
}
