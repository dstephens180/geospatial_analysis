library(bslib)
library(shiny)
library(sass)

# TNS SPECS
TITLE        <- "Geo Spatial Analysis"
TNS_LOGO     <- "https://tnsinc.com/wp-content/uploads/2022/05/TNS-Horizontal-Logo-medium500-RGB-color.png"
RENTED_LOGO  <- "https://tnsinc.com/wp-content/uploads/2023/01/Rented-white-icon-only-sm.png.webp"

FONT_HEADING <- "Montserrat"
FONT_BASE    <- "Montserrat"
PRIMARY      <- "#a087ae"
SUCCESS      <- "#6ab5da"
INFO         <- "#00F5FB"
WARNING      <- "#ee9c0f"
DANGER       <- "#f06698"
FG           <- "#000000"
BG           <- "#FFFFFF"


app_theme <- bs_theme(
  font_scale   = 1.0,
  heading_font = font_google(FONT_HEADING, wght = c(300, 400, 500, 600, 700, 800), ital = c(0, 1)),
  base_font    = font_google(FONT_BASE, wght = c(300, 400, 500, 600, 700, 800), ital = c(0, 1)),
  primary      = PRIMARY,
  success      = SUCCESS,
  info         = INFO,
  warning      = WARNING,
  danger       = DANGER,
  fg           = FG,
  bg           = BG,
  "navbar-bg"  = PRIMARY,
  "body-color" = PRIMARY,
  "accordion-button-active-bg"    = SUCCESS,
  "accordion-button-active-color" = PRIMARY,
  "bs-accordion-color" = PRIMARY,
  "light" = BG
)

app_title <- list(
  tags$img(
    src   = RENTED_LOGO,
    id    = "logo",
    style = "height:46px;margin-right:24px;"
  ),
  h4(TITLE, id = "title")
)
