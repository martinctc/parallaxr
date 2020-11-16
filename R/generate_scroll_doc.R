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
#' @param custom_css A character vector of length 1 that holds the CSS code for the parallax
#' document. You may use a combination of `readLines()` and `paste()` to create this vector
#' from a local CSS file in your working directory. Use `default_css()` to return the default
#' CSS to use for custom editing (you'll need to save the output into a custom CSS file).
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
generate_scroll_doc <- function(path, inputs, custom_css = NULL){
  headtext <- c(
  "<!DOCTYPE html>
  <html>
  <head>")


  foottext <- readLines(con = system.file("footer.html", package = "parallaxr"), warn = FALSE) %>% paste(collapse = " ")

  ## Provide ability to return custom css

  if(!is.null(custom_css)){

    csstext <- custom_css

  } else {

    csstext <- readLines(con = system.file("style.css", package = "parallaxr"), warn = FALSE) %>% paste(collapse = " ")

  }

  p <- paste(headtext,
             '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
             '<style>',
             csstext,
             '</style>',
             '</head>')

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
