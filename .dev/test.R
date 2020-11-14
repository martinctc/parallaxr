headtext <-
  c(
    "<!DOCTYPE html>
  <html>
  <head>")

foottext <- readLines(con = "inst/footer.html", warn = FALSE) %>% paste(collapse = " ")

csstext <- readLines(con = "inst/style.css", warn = FALSE)

csstext_col <- paste(csstext, collapse = " ")


p <-
  paste(headtext,
        '<style>',
        csstext_col,
        '</style>',
        '</head>')

htmltools::HTML(p)


scroll_section <- function(content,
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

# scroll_section(content = "hello", position = "left", imgurl = "google.com") %>%
#   htmltools::html_print()
#
#
# paste0(headtext,
#        "<body>",
#        scroll_section(content = "hello", position = "left", imgurl = "google.com"),
#        "</body>",
#        foottext) %>%
#   htmltools::html_print()

paste0(p,
       "<body>",
       scroll_section(content = "<h1>hello</h1>", position = "left", imgurl = "https://outwardhound.com/furtropolis//wp-content/uploads/2020/03/Doggo-Lingo-Post.jpg"),
       scroll_section(content = "hello again", position = "right", imgurl = "https://outwardhound.com/furtropolis//wp-content/uploads/2020/03/Doggo-Lingo-Post.jpg"),
       scroll_section(content = "hello x three", position = "right", imgurl = "https://outwardhound.com/furtropolis//wp-content/uploads/2020/03/Doggo-Lingo-Post.jpg"),
       "</body>",
       foottext) %>%
  writeLines("test.html")






