library(shiny)
library(rCharts)
library(data.table)


shinyUI(
  navbarPage("NOAA Storm Data Explorer",
             tabPanel("Explore",
                      sidebarPanel(sliderInput("range", 
                                               "Range:", 
                                               min = 1950, max = 2011, 
                                               value = c(1995, 2011)),
                                   uiOutput("evtypeControls")),
                                                
                      mainPanel(tabsetPanel(
                        tabPanel('Impact by State',
                                 column(3,
                                        wellPanel(
                                          radioButtons("populationCategory",
                                                       "Population Impact:",
                                                       c("Injuries" = "injuries", "Fatalities" = "fatalities", "Both" = "both")))),
                                 column(3,wellPanel(
                                   radioButtons("economicCategory",
                                                "Economic Impact:",
                                                c("Property" = "property", "Crops" = "crops", "Both" = "both")))),
                                 column(7,plotOutput("populationImpactByState"),plotOutput("economicImpactByState"))),
                        
                        tabPanel('Impact by Year',h4('Number of events by year', align = "center"),
                                 showOutput("eventsByYear", "nvd3"),
                                 h4('Population impact by year', align = "center"),
                                 showOutput("populationImpact", "nvd3"),
                                 h4('Economic impact by year', align = "center"),
                                 showOutput("economicImpact", "nvd3")),
                        
                        tabPanel('Data',dataTableOutput(outputId="table"),downloadButton('downloadData', 'Download'))))),
             tabPanel("About",mainPanel(includeMarkdown("README.md"))))
)