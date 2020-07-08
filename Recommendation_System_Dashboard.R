library(shinydashboard)
library(shiny)

# !!! use fluidrows -> columns or boxes for each dashboard tab (CH 3 shinydashboards:datacamp) --> and color them (also CH 3)
# !!! Add fontawesome Icons to tab names
# Prolly not -> ideas: read in data(csv) real time?
# !!! use DT:Table to display data (head) with some sort function after describing the pre-processing procedures.


header <- dashboardHeader(
  dropdownMenu(
    type = "notifications",
    notificationItem(
      text ="Check out my Website by clicking here.",
      href ="http://www.datacamp.com",
      icon = icon(name ="fa-globe-americas",class ="fa-globe-americas")
    ),
    notificationItem(
      text ="Check out my GitHub by clicking here.",
      href ="https://github.com/fuchsfranklin",
      icon = icon(name ="fa-github",class ="fa-github"))
  )
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Recommender Settings",
             tabName ="rec_set"
    ),
    menuItem("Product Recommendations",
             tabName ="prod_rec"
    ),
    menuItem("Algorithm Information",
             tabName ="algo_info"
    ),
    menuItem("Performance Metrics and Plots",
             tabName ="perf_mets"
    ),
    menuItem("Data Information",
             tabName ="data_info"
    ),
    menuItem("Dashboard Information",
             tabName ="dash_info"
    )
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName ="rec_set",
            "No Settigns yet"),
    tabItem(tabName ="prod_rec",
            "No Recommendations yet"),
    tabItem(tabName ="algo_info",
            "No Information About Algorithms yet"),
    tabItem(tabName ="perf_mets",
            "No Metrics or Plots yet."),
    tabItem(tabName ="data_info",
            "No Data Information yet."),
    tabItem(tabName ="dash_info",
            "No References yet.")
    
  )
)

ui <- dashboardPage(header=header, sidebar=sidebar, body=body)

server <- function(input, output) {}

shiny::shinyApp(ui, server)