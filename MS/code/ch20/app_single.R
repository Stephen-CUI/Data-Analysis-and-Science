library(shiny)

monthFeedbackUI <- function(id) {
  textOutput(NS(id, "feedback"))
}

monthFeedBackServer <- function(id, month) {
  stopifnot(is.reactive(month))

  moduleServer(id, function(input, output, session) {
    output$feedback <- renderText({
      if (month() == "October") {
        "You picked a great month!"
      } else {
        "Eh, you could do better."
      }
    })
  })
}

stones <- vroom::vroom("birthstones.csv")

birthstoneUI <- function(id) {
  p(
    "The birthstone for ", textOutput(NS(id, "month"), inline = TRUE),
    " is ", textOutput(NS(id, "stone"), inline = TRUE)
  )
}

birthstoneServer <- function(id, month) {
  stopifnot(is.reactive(month))

  moduleServer(id, function(input, output, session) {
    stone <- reactive(stones$stone[stones$month == month()])
    output$month <- renderText(month())
    output$stone <- renderText(stone())
  })
}

months <- c(
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
)
ui <- navbarPage(
  "Sample app",
  tabPanel(
    "Pick a month",
    selectInput("month", "What's your favourite month?", choices = months)
  ),
  tabPanel("Feedback", monthFeedbackUI("tab1")),
  tabPanel("Birthstone", birthstoneUI("tab2"))
)

server <- function(input, output, session) {
  monthFeedBackServer("tab1", reactive(input$month))
  birthstoneServer("tab2", reactive(input$month))
}

shinyApp(ui, server)
