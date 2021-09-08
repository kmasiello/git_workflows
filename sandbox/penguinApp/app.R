library(shiny)
library(ggplot2)
library(dplyr)
library(palmerpenguins)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Penguin Measurements for our Project"),

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
