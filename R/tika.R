
#' Apache tika parser to html in R
#'
#' @param file file path
#' @importFrom rJava .jinit
#' @importFrom rJava .jaddClassPath
#' @importFrom rJava .jnew
#' @return html
#' @export
#'
#' @examples
#' \dontrun{
#' tika_parse_to_html("presentation.pptx")
#' }

tika_parse_to_html <- function(file){
    .jinit()
    .jaddClassPath(system.file("tika-app-1.16.jar",package="tikaR"))
    fileIO <- .jnew("java.io.FileInputStream",file)
    parser <- .jnew("org.apache.tika.parser.AutoDetectParser")
    handler <- .jnew("org.apache.tika.sax.ToXMLContentHandler")
    metadata <- .jnew("org.apache.tika.metadata.Metadata")
    parser$parse(fileIO,handler,metadata)

    result <- handler$toString()
    fileIO$close()

    return(iconv(result,"UTF-8","UTF-8")) # こうしないと文字化けする(Windows)。謎。 //逕ｻ髱｢縺ｫ蜷医ｏ縺帙ｋ (4:3) => 画面に合わせる (4:3)

}
