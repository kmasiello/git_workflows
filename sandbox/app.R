library(shiny)
library(ggplot2)
library(dplyr)
library(palmerpenguins)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Penguin Measurements"),

    sidebarLayout(
        sidebarPanel(radioButtons(inputId = "species",
                                  label = "Species",
                                  choices = c("Adelie" = "Adelie",
                                              "Chinstrap" = "Chinstrap",
                                              "Gentoo" = "Gentoo"))),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        ggplot(data = filter(penguins, species == input$species), aes(x = flipper_length_mm, y = body_mass_g)) +
            geom_point(aes(color = species,
                           shape = species),
                       size = 2) +
            scale_color_manual(values = c("darkorange","darkorchid","cyan4"))
    })
}

# Run the application
shinyApp(ui = ui, server = server)
