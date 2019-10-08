library(shiny)
library(shinydashboard)
library(wordcloud)
library(tm)
library(slam)
library(RColorBrewer)
library(arules)
library(arulesViz)
library(dplyr)
library(ggpubr)
library(cluster)
library(leaflet)


shinyServer(function(input,output,session){
  
  
  output$plot12<-renderPlot({ 
    zz<-as(split(total[,"Cuisines"],total[,"Votes"]),'transactions')
    itemFrequencyPlot(zz,topN=10,type="absolute",col=brewer.pal(8,'Pastel2'),
                      main="Top 10 Cuisines",horiz=TRUE)
  })
  
  
  
  observeEvent(
    input$Country,
    updateSelectInput(session, "City", "City", 
                      choices = unique(total$City
                                       [total$Country == input$Country]))
  )
  
  
  
  output$tab<-renderDataTable({
    ff<-filter(total,total$Country==input$Country)
    gg<-filter(ff,ff$City==input$City)
    
    tas<-gg %>% select(Restaurant.ID,Restaurant.Name,Address,
                City,Locality,Cuisines,Rating.text,Votes)
    
    gd<-filter(tas,tas$City == input$City)
  
  })
  
  output$plot3=renderPlot({
    ff<-filter(total,total$Country==input$Country)
    gg<-filter(ff,ff$City==input$City)
    wordcloud(gg$Cuisines,min.freq=input$slider1,scale=c(6,0.5),
     rot.per=0.25,max.words = input$slider,colors = brewer.pal(8,"Dark2"))
    })
  
  
  
  fit<-kmeans(total$Aggregate.rating,4)
  output$plot4<-renderPlot({plot(total$Aggregate.rating,col=fit$cluster)})
  
  
  output$plot6<-renderPlot({
    
    ff<-filter(total,total$Country==input$Country)
    gg<-filter(ff,ff$City==input$City)
    
    df <- gg %>%
      group_by(Rating.color) %>%
      summarise(counts = n())
    
    
    dz <- df %>%
    arrange(desc(Rating.color)) %>%
    mutate(prop = round(counts*100/sum(counts), 1),
           lab.ypos = cumsum(prop) - 0.5*prop)
  
  ggplot(dz, aes(x = "", y = prop, fill = Rating.color)) +
    geom_bar(width = 1, stat = "identity", color = "white") +
    geom_text(aes(y = lab.ypos, label = prop), color = "white")+
    coord_polar("y", start = 0)+
    ggpubr::fill_palette("jco")+
    theme_void()
  })
  
  output$plot5<-renderPlot({
    
    ff<-filter(total,total$Country==input$Country)
    gg<-filter(ff,ff$City==input$City)
    
    df <- gg %>%
      group_by(Rating.text) %>%
      summarise(counts = n())
    
    ggplot(df, aes(x = Rating.text,y=counts)) +
      geom_bar(fill = "#0073C2FF", stat = "identity") +
      geom_text(aes(label =counts ), vjust = -0.3) + 
      theme_classic()
    
  })
  
  
  output$plot7<-renderLeaflet({ 
    ff<-filter(total,total$Country==input$Country)
    
    
    gg<-filter(ff,ff$City==input$City)
    
    leaflet(data = gg[1:20,]) %>% addTiles() %>% 
      addMarkers(~Longitude, ~Latitude, popup = ~as.character(Price.range), label = ~as.character(Price.range))
    
  })
  output$plot2<-renderPlot({ 
    ff<-filter(total,total$Country==input$Country)
    gg<-filter(ff,ff$City==input$City)
    zz<-as(split(gg[,"Cuisines"],total[,"Votes"]),'transactions')
    itemFrequencyPlot(zz,topN=10,type="absolute",col=brewer.pal(8,'Pastel2'),
                      main="Top 10 Cuisines",horiz=TRUE)
  })
  
  observe({
    if(input$action>0)
      stopApp()
  })
  
})

