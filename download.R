library("sf")
library("httr")
library("dplyr")
library("purrr")
source("fisbroker-functions.R")

### LOR-Planungsräume:

z <- sf_fisbroker("https://fbinter.stadt-berlin.de/fb/wfs/data/senstadt/s_lor_plan")

z <- z %>%
  mutate(RAUMID = stringr::str_sub(gml_id, 12, 19)) %>%
  select(gml_id, RAUMID, everything()) %>%
  arrange(RAUMID)

dplyr::glimpse(z)

sf_save(z, "LOR_Planungsraum", export_format = "shp")


### Umweltgerechtigkeit 2013: Grünflächenversorgung

# https://www.berlin.de/umweltatlas/mensch/umweltgerechtigkeit/2013/zusammenfassung/

z <- sf_fisbroker("https://fbinter.stadt-berlin.de/fb/wfs/data/senstadt/s09_01_3UGgruen2012")

z <- z %>%
  mutate(RAUMID = stringr::str_extract(gml_id, "([0-9]{8})$")) %>%
  select(gml_id, RAUMID, everything()) %>%
  arrange(RAUMID)

dplyr::glimpse(z)

sf_save(z, "Gruenflaechen", export_format = "shp")


### Umweltgerechtigkeit 2013: Luftbelastung

# https://www.berlin.de/umweltatlas/mensch/umweltgerechtigkeit/2013/zusammenfassung/

z <- sf_fisbroker("https://fbinter.stadt-berlin.de/fb/wfs/data/senstadt/s09_01_2UGluft2009")

z <- z %>%
  mutate(RAUMID = stringr::str_extract(gml_id, "([0-9]{8})$")) %>%
  select(gml_id, RAUMID, everything()) %>%
  arrange(RAUMID)

dplyr::glimpse(z)

sf_save(z, "Luftbelastung", export_format = "shp")


### Umweltgerechtigkeit 2013 (Umweltatlas): 
### Integrierte Mehrfachbelastung (Lärm, Grünflächen etc.)

# https://www.berlin.de/umweltatlas/mensch/umweltgerechtigkeit/2013/zusammenfassung/

z <- sf_fisbroker("https://fbinter.stadt-berlin.de/fb/wfs/data/senstadt/s09_01_6UGumwelt2013")

z <- z %>%
  mutate(RAUMID = stringr::str_extract(gml_id, "([0-9]{8})$")) %>%
  select(gml_id, RAUMID, everything()) %>%
  arrange(RAUMID)

dplyr::glimpse(z)

sf_save(z, "Umweltgerechtigkeit", export_format = "shp")


### Umweltgerechtigkeit 2013 (Umweltatlas): 
### Integrierte Mehrfachbelastung (Lärm, Grünflächen etc.)

# https://www.berlin.de/umweltatlas/mensch/umweltgerechtigkeit/2013/zusammenfassung/

z <- sf_fisbroker("https://fbinter.stadt-berlin.de/fb/wfs/data/senstadt/s09_01_8UGthematisch_2013")

z <- z %>%
  mutate(RAUMID = stringr::str_extract(gml_id, "([0-9]{8})$")) %>%
  select(gml_id, RAUMID, everything()) %>%
  arrange(RAUMID)

dplyr::glimpse(z)

sf_save(z, "UGthematisch", export_format = "shp")
