#' @title Generate the HTML div fragment for the scroll document
#'
#' @description This is designed to be used with `parse_md()` and
#' `purrr::pmap_chr()` to generate a HTML fragment for `generate_scroll_doc()`.
#' For the typical usage, you should not need to use this function directly.
#' This is exported for transparency reasons.
#'
#' @param content character. Content in HTML
#' @param position character. Valid values include "right" (default) or "left".
#' @param imgurl character. URL string for the image to be displayed.
#'
#' @export
scroll_section <- function(content = "right",
                           position,
                           imgurl){

  if(position == "right"){
    term <- "scrollHalf"
  } else if(position == "left"){
    term <- "halfScroll"
  }

  group_tag <- paste0(term, "__group")
  group_tag_content <- paste0(term, "__group__content")
  group_tag_imagen <- paste0(term, "__group__imagen")

  inside_div <-
    paste0(
      paste0("<div class='", group_tag, "' data-scroll>"),
      paste0("<div class='", group_tag_content, "' >",
             content, "</div>"),
      paste0("<div class='", group_tag_imagen, "' >",
             htmltools::img(src = imgurl), "</div>"),
      "</div>"
    )

  inside_div
}
