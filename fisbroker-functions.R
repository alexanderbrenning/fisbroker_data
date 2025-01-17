get_X_Y_coordinates <- function(x) {
  
  sftype <- as.character(sf::st_geometry_type(x, by_geometry = FALSE))
  
  if(sftype == "POINT") {
    
    xy <- as.data.frame(sf::st_coordinates(x))
    dplyr::bind_cols(x, xy)
    
  } else {
    x
  }
  
}

sf_fisbroker <- function(url, in_epsg = 25833, 
                         out_epsg = NULL) {
  
  stopifnot(any(c(25833, 4258) == in_epsg))
  
  typenames <- basename(url)
  
  url <- httr::parse_url(url)
  
  url$query <- list(service = "wfs",
                    version = "2.0.0",
                    request = "GetFeature",
                    srsName = paste0("EPSG:", in_epsg),
                    TYPENAMES = typenames)
  
  request <- httr::build_url(url)
  
  print(request)
  
  out <- sf::read_sf(request)

  if (!is.null(out_epsg))  
    out <- sf::st_transform(out, out_epsg)
  
  out <- get_X_Y_coordinates(out)
  
  out
}



sf_save <- function(z, fname, path = fname,
                    export_format = c("geojson", "sqlite")) {
  ff <- paste(file.path(path, fname), export_format, sep = ".")
  purrr::walk(ff, ~{ sf::st_write(z, .x, delete_dsn = TRUE)})
  saveRDS(z, paste0(file.path(path, fname), ".rds"))
}
