#' @title Parse a Markdown document with YAML headers and return a data frame for
#' generating a scroll document
#'
#' @param input_file character. File path to the Markdown document. The Markdown
#' document must contain a YAML header with the following keys:
#' - position
#' - imgurl
#'
#' @examples
#' \dontrun{
#' parse_md("Markdown/1.md")
#' }
#' @export
parse_md <- function(input_file) {

  input_lines <- readLines(input_file, warn = FALSE)

  delimiters <- grep("^---\\s*$", input_lines)

  if (!length(delimiters)) {

    stop("unable to find yaml delimiters")

  } else if (length(delimiters) == 1L) {

    if (delimiters[1] == 1L) {

      stop("cannot find second delimiter, first is on line 1")

    } else {
      # found just one set, assume it is *closing* the yaml matter;
      # fake a preceding line of delimiter
      delimiters <- c(0L, delimiters[1])
    }
  }
  delimiters <- delimiters[1:2]

  yaml_list <- yaml::yaml.load(input_lines[ (delimiters[1]+1):(delimiters[2]-1) ])
  content <- input_lines[(delimiters[2]+1): length(input_lines)]
  content <- paste(content, collapse = "\n")

  tibble::tibble(position = yaml_list[["position"]],
                 imgurl = yaml_list[["imgurl"]],
                 content = md2html(content)) # convert to HTML from Markdown
}
