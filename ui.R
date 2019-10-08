library(shiny)
library(shinydashboard)
library(leaflet)

shinyUI(
  dashboardPage( title="ZOMATO",skin="red",
    
  dashboardHeader(title = tags$body(tags$style(HTML('.main-header .logo{
     font-family:"Times New Roman";
     font-weight:bold;
     font-size:24px;}')),"ZOMATO"),
      dropdownMenu(type="notification",notificationItem(
        actionButton("action",label="CLOSE THE APP"),
          icon=icon("fas fa-sign-out")), icon=icon("fas fa-sign-out")                                                 
                    )
                  ),
  
  dashboardSidebar(
      sidebarMenu(
        menuItem("HOMEPAGE",icon=icon("far fa-home"),tabName = "homepage"),
        menuItem("TREEMAP",icon=icon("far fa-trello"), tabName = "treemap"),
        menuItem("TOP 10 CUISINES",icon=icon("far fa-chart-bar"), tabName = "top10"),

        menuItem("FILTER",icon=icon("far fa-filter"),startExpanded =TRUE,
          menuSubItem("SEARCH",icon=icon("far fa-search"),tabName = "search",selected=TRUE),
          menuSubItem("ITEM FREQUENCY",icon=icon("far fa-chart-bar"),tabName="itemfrequency"),
          menuSubItem("TABLE",icon=icon("fal fa-table"),tabName="table"),
          menuSubItem("WORD CLOUD",icon=icon("far fa-file-word"),tabName="wordcloud"),
          menuSubItem("RATING TEXT",icon=icon("far fa-chart-bar"),tabName="ratingtext"),
          menuSubItem("PIE CHART",icon=icon("far fa-chart-pie"),tabName="piechart"),
          menuSubItem("MAPPING",icon=icon("far fa-search-location"),tabName="mapping")
      ),
        
        menuItem("KMEANS", icon=icon("fa fa-scatter-chart"),tabName = "kmeans")
      )),
  
    dashboardBody( 
      tabItems(
        tabItem( 
          tabName = "homepage",fluidRow(
                        HTML('<center><img src="zz.jpg", height=400, width=1050></center>'),
                        h3("Zomato is an Indian restaurant search and discovery service founded in 2008 
                            by Deepinder Goyal and Pankaj Chaddah. It currently operates in 24 countries."),

                            h3("It provides information and reviews of restaurants, including images of menus 
                            where the restaurant does not have its own website and also online delivery 
                            services in some countries.The restaurant search and discovery platform began 
                            its operations under the name, Foodiebay. In November 2010, the brand was renamed 
                            as Zomato. By 2011, Zomato launched in Bengaluru, Pune, Chennai, Hyderabad and Ahmedabad.
                            With the introduction in 2011, Zomato also launched zomato.xxx, a site dedicated to food porn.
                            The company launched a print version of the website content named, Citibank Zomato Restaurant Guide,
                            in collaboration with Citibank in May 2012, but it has since been discontinued. 
                            In September 2012, Zomato expanded overseas to the United Arab Emirates, Sri Lanka, Qatar,
                            the United Kingdom, the Philippines, and South Africa. In 2013, the company launched in New Zealand,
                            Turkey, Brazil and Indonesia with its website and apps available in Turkish, Brazilian Portuguese, 
                            Indonesian and English. In April 2014, Zomato launched its services in Portugal, followed by 
                            launches in Canada, Lebanon and Ireland the same year.")
                        )
          ),
         tabItem( 
           tabName = "search",fluidRow(
            box(title="CONTROLS FOR ITEMFREQUENCY",status="warning",solidHeader=T,
            selectInput("Country", "Country", choices = unique(total$Country)),
            
            selectInput("City", "City", choices = "", selected = ""))
      )),
      tabItem(
        tabName="itemfrequency",
        plotOutput('plot2')
      ),
      tabItem(
        tabName = "table",
        dataTableOutput('tab')
        
      ),
        
        
      
tabItem(
  tabName = "top10",
  plotOutput("plot12")
  
),
tabItem(
  tabName = "wordcloud",fluidRow(
  box(plotOutput("plot3"),title="CUISINES",status="primary",solidHeader=T),
  
  box(title="CONTROLS FOR WORDCLOUD",status="warning",solidHeader=T,
      sliderInput("slider","MAXIMUM WORDS",1,21,15),
      sliderInput("slider1","MINIMUM FREQUENCY",1,50,25))
)),
tabItem(
  tabName = "piechart",
  plotOutput('plot6')
  
),
tabItem(
  tabName = "mapping",
  leafletOutput('plot7')
  
),
tabItem(
  tabName = "ratingtext",
  plotOutput('plot5')
  
),
tabItem(
  tabName = "kmeans",
  plotOutput('plot4')
  
),

tabItem(
  tabName = "treemap",
  HTML('<p><img src="zomato-treemap1.png", height=1200, width=1250/></p>')
)
        
      )
    )
    )
      )
    
    
 

    