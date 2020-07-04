library(shiny)
library(shinythemes)

ui <- fluidPage(
  
  theme = shinytheme("cerulean"),
  titlePanel("Product Recommendation System"),
  tags$ul(
    #tags$li("This project is motivated by the idea to better understand the (simplified versions of) collaborative-filtering based recommender systems that companies such as Amazon or Netflix currently utilize. The primary aim of this project is to implement a product recommendation system based on the ... dataset, where the web-application user can choose models and parameters such as which model should be used to generate recommendations and their top five favorite ... . The second aim of this project is generate recommendations from the user input and provide additional useful information such as the theory behind the used model or model performance metrics."),
    tags$li("Please choose settings below and then press the generate recommendations button for personalized recommendations based on the chosen algorithm.")
  ),
  sidebarLayout(
    sidebarPanel(
      titlePanel("Settings"),
      radioButtons("algo", "Recommendation Algorithm :",
                   c("User-Based Collaborative Filtering (UBCF)" = "user",
                     "Item-Based Collaborative Filtering (IBCF)" = "item",
                     "Singular Value Decomposition Approximation (SVD)" = "svd",
                     "Random Items " = "lnorm",
                     "Popular Items" = "exp")),
      sliderInput("n",
                  "Number of observations:",
                  value = 500,
                  min = 1,
                  max = 1000),
      
      actionButton("reccom_button", "Generate Recommendations")
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Product Recommendations", tableOutput("table")),
                  tabPanel("Algorithm Information", plotOutput("plot")),
                  tabPanel("Perforance Metrics", verbatimTextOutput("summary")),
                  tabPanel("Dataset Information", tableOutput("table")),
                  tabPanel("App Information", tableOutput("table"))
                  
      )
    )
  )
)

server <- function(input, output) {
  
  d <- reactive({
    dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   lnorm = rlnorm,
                   exp = rexp,
                   rnorm)
    dist(input$n)
  })

  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$n
    
    hist(d(),
         main = paste("r", dist, "(", n, ")", sep = ""),
         col = "#75AADB", border = "white")
  })
  
  output$summary <- renderPrint({
    summary(d())
  })
  
  output$table <- renderTable({
    d()
  })
}


#App Construction
###################################################################
shinyApp(server = server, ui = ui)