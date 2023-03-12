# LIBRARIES ----
library(tidyverse)
library(tidyquant)
library(here)
library(plotly)
library(timetk)
library(gridlayout)
library(shiny)
library(ggplot2)
library(bslib)
library(sass)
library(mapview)
library(leaflet)
library(DT)
library(sf)



# SCRIPTS ----
source("C:\\Users\\Dave\\Desktop\\GitHub\\vacation-rental-analysis\\shiny-themes\\theme_light.R")



# DATA ----
ca_hosts_by_county_sf  <- read_rds("C:\\Users\\Dave\\Desktop\\GitHub\\vacation-rental-analysis\\01_geospatial\\hosts_by_ca_county_sf.rds")
usa_hosts_by_county_sf <- read_rds("C:\\Users\\Dave\\Desktop\\GitHub\\vacation-rental-analysis\\01_geospatial\\usa_hosts_by_county_sf.rds")



# MAPS ----
map_median_hosts <- usa_hosts_by_county_sf %>%
  mapview(
    zcol       = "median_hosts",
    color      = "white",
    layer.name = "Median Hosts")

map_total_hosts <- usa_hosts_by_county_sf %>%
  mapview(
    zcol       = "sum_hosts",
    color      = "white",
    layer.name = "Total Hosts")





### SHINY DEVELOPMENT ###
# USER INTERFACE ----
ui <- navbarPage(

  tags$head(tags$style(HTML(".navbar-brand {display: flex;}"))),

  title       = app_title,
  collapsible = T,
  theme       = app_theme,

  sidebarLayout(
    position = "left",
    sidebarPanel(
      h2("Analysis"),
      p("Marketing efforts should be focused on where the host is located."),
      code('install.packages("shiny")'),
      br(),
      br(),
      br(),
      br(),
      img(src = TNS_LOGO, height = "50%", width = "50%"),
      br(),
      "Rented is a part of ",
      span("TravelNet Solutions", style = "color:purple")
    ),
    mainPanel(
      title = "USA Host Locations by County",
      grid_container(
        layout = c(
          "area0 area1",
          ".     .    "
        ),

        row_sizes = c(
          "1.0fr",
          "1.0fr"
        ),

        col_sizes = c(
          "1fr",
          "1fr"
        ),
        gap_size = "1rem",


        # Median Hosts
        grid_card(
          title = "Median Hosts",
          area = "area0",
          leafletOutput(
            outputId = "median_hosts",
            width = "100%",
            height = "400px"
          )
        ),

        grid_card(
          area = ". ",
          DTOutput(
            outputId = "median_hosts_tbl",
            width = "100%",
            height = "400px"
          )
        ),

        # Total Hosts
        grid_card(
          title = "Total Hosts",
          area = "area1",
          leafletOutput(
            outputId = "total_hosts",
            width = "100%",
            height = "400px"
          )
        ),

        grid_card(
          area = ". ",
          DTOutput(
            outputId = "total_hosts_tbl",
            width = "100%",
            height = "400px"
          )
        )

      )
    )
  )
)

# SERVER ----
server <- function(input, output) {

  output$median_hosts <- renderLeaflet({
    map_median_hosts@map
  })

  output$median_hosts_tbl <- renderDataTable({
    usa_hosts_by_county_sf %>%
      as_tibble() %>%
      select(NAME, STATE_NAME, median_hosts) %>%
      rename(county_name = NAME,
             state_name  = STATE_NAME) %>%
      arrange(desc(median_hosts))
  })


  # Total Hosts
  output$total_hosts <- renderLeaflet({
    map_total_hosts@map
  })

  output$total_hosts_tbl <- renderDataTable({
    usa_hosts_by_county_sf %>%
      as_tibble() %>%
      select(NAME, STATE_NAME, sum_hosts) %>%
      rename(county_name = NAME,
             state_name  = STATE_NAME) %>%
      arrange(desc(sum_hosts))
  })



}



shinyApp(ui, server)
