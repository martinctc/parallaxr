# parallaxr
Generate a parallax scroll document in R with YAML and Markdown

![](https://raw.githubusercontent.com/martinctc/parallaxr/main/.dev/parallaxr.gif)

This is an R package that allows you to create a parallax scroll document with YAML and Markdown files. 

Check out this demo output: 
https://martinctc.github.io/examples/parallaxr-examples-output.html

You can install the package with the following line of code. Make sure you have **devtools** installed first, of course:

```R
devtools::install_github("martinctc/parallaxr")
```
In the `examples` folder of this repo, you will find the script and the Markdown documents that were used to produce this page. Here is a snippet of the starter code, but please visit the repo for the latest version:

```R
## Load packages
library(parallaxr)

## Character vector of all MD files
all_md_str <- list.files(path = "examples/Markdown", full.names = TRUE)


## Loop through each MD file, parse, and return a single tibble
md_tibble <-
  all_md_str %>%
  purrr::map_dfr(parse_md) # Return a tibble with row-binding

## Output HTML file

generate_scroll_doc(path = "examples/parallaxr-examples-output.html",
                    inputs = md_tibble)
```

More documentation is available for the individual functions, e.g. 

```R
?generate_scroll_doc
```

You may also visit https://martinctc.github.io/parallaxr/reference.

## Examples

Further examples and use cases can be found below:

- https://frankpopham.github.io/side/ (@frankpopham)
- https://durraniu.github.io/BBC100/ (@durranniu)

Thank you all who have contributed examples! If you would like to add your example to this list, please fork this repo and create a pull request to edit this README page.

## Getting involved

If you have any questions, bugs, or suggestions for enhancements, please log an issue with https://github.com/martinctc/parallaxr/issues. This is an open-source project, so any contribution is very welcome! Pull requests are welcome. 