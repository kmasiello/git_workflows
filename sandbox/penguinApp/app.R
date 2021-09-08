library(shiny)
library(ggplot2)
library(dplyr)
library(palmerpenguins)
library(bslib)
library(thematic)

thematic_shiny(font = "auto")

# Define UI for application that draws a histogram
ui <- fluidPage(
    theme  = bslib::bs_theme(
        bg = "#485862", fg = "#E9EAEE", primary = "#2AA198",
        # consider #9EC1D8 over #485862
        base_font = bslib::font_google("Montserrat")),


    # Application title
    titlePanel("Penguin Measurements"),

    sidebarLayout(
        sidebarPanel(radioButtons(inputId = "island",
                                  label = "Island",
                                  choices = c("Biscoe" = "Biscoe",
                                              "Dream" = "Dream",
                                              "Torgersen" = "Torgersen"))),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        ggplot(data = filter(penguins, island == input$island), aes(x = flipper_length_mm, y = body_mass_g)) +
            geom_point(aes(color = species,
                           shape = species),
                       size = 2) +
            scale_color_manual(values = c("darkorange","darkorchid","cyan4")) +
            xlim(170,240) + ylim(2600,6400)
    })
}

# Run the application
shinyApp(ui = ui, server = server)
