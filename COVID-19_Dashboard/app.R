ui <- {
  navbarPage(
    'COVID-19',
    position = 'fixed-top',
    id = 'idNavbarPage',
    tags$style(type='text/css', 'body {padding-top: 70px;}'),
    tags$script(src = 'ScrollToTop.js'),
    fluid = TRUE,
    navbarMenu(
      'Confirmed Cases',
      # Base stats - Cases
      tabPanel(
        'Cases',
        # Page display mode selector
        fluidRow(column(width = 12, selectInput('Selected_Case_View', 'View', view_types, 'Daily'))),
        tags$script(src = 'DisableDateInputTyping.js'),
        # Cases
        fluidRow(column(width = 1, align = 'center', uiOutput('Start_Date_Cases'), uiOutput('End_Date_Cases')), column(width = 10, plotlyOutput('Plotly_Cases', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Cases'))),
        tags$style(type='text/css', '#Start_Date_Cases { width:100%; margin-top: 150px;}'),
        tags$style(type='text/css', '#End_Date_Cases { width:100%; margin-bottom: 150px;}'),
        # Symptomatic Cases
        fluidRow(column(width = 1, align = 'center', uiOutput('Start_Date_Symp'), uiOutput('End_Date_Symp')), column(width = 10, plotlyOutput('Plotly_Symptomatic_Cases', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Symptomatic_Cases'))),
        tags$style(type='text/css', '#Start_Date_Symp { width:100%; margin-top: 150px;}'),
        tags$style(type='text/css', '#End_Date_Symp { width:100%; margin-bottom: 150px;}'),
        # Asymptomatic Cases
        fluidRow(column(width = 1, align = 'center', uiOutput('Start_Date_Asymp'), uiOutput('End_Date_Asymp')), column(width = 10, plotlyOutput('Plotly_Asymptomatic_Cases', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Asymptomatic_Cases'))),
        tags$style(type='text/css', '#Start_Date_Asymp { width:100%; margin-top: 150px;}'),
        tags$style(type='text/css', '#End_Date_Asymp { width:100%; margin-bottom: 150px;}')
      ),
      # Demographics - Cases
      tabPanel(
        'Demographics',
        # Age Group - Cases
        fluidRow(column(width = 1, radioButtons('ID_Age_Group_Cases', 'Chart Type', plot_types, 'Bar Graph')), column(width = 10, plotlyOutput('Plotly_Age_Group_Cases', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Age_Group_Cases'))),
        # Gender - Cases
        fluidRow(column(width = 1, radioButtons('ID_Gender_Cases', 'Chart Type', plot_types, 'Pie Chart')), column(width = 10, plotlyOutput('Plotly_Gender_Cases', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Gender_Cases'))),
        # Race - Cases
        fluidRow(column(width = 1, radioButtons('ID_Race_Cases', 'Chart Type', c("Bar Graph", "Line Graph"), 'Bar Graph')), column(width = 10, plotlyOutput('Plotly_Race_Cases', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Race_Cases'))),
        # Ethnicity - Cases
        fluidRow(column(width = 1, radioButtons('ID_Ethnicity_Cases', 'Chart Type', plot_types, 'Pie Chart')), column(width = 10, plotlyOutput('Plotly_Ethnicity_Cases', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Ethnicity_Cases')))
      ),
      # Municipalities - Cases
      tabPanel(
        'Municipalities',
        fluidRow(column(width = 12, sliderInput('ID_Top_Zip_Codes_Cases', 'Towns to Display (5 to 20)', min = 5, max = 20, value = 10)), column(width = 10, offset = 1, plotlyOutput('Plotly_Top_Zip_Codes_Cases', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Top_Zip_Codes_Cases'))),
        fluidRow(column(width = 12, selectInput('ID_Zip_Codes_Cases', 'Town to Display', sort(dataValidation$zipCodes$Town.City), 'Goshen')), column(width = 10, offset = 1, plotlyOutput('Plotly_Zip_Codes_Cases', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Zip_Codes_Cases')))
      ),
      # Vaccination - Cases
      tabPanel(
        'Vaccinations',
        fluidRow(column(width = 1, radioButtons('ID_Vaccination_Cases', 'Chart Type', plot_types, 'Bar Graph')), column(width = 10, plotlyOutput('Plotly_Vaccination_Cases', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Vaccination_Cases')))
      )
    ),
    navbarMenu(
      'Confirmed and Probable Deaths',
      tabPanel(
        'Deaths',
        # Page display mode selector
        fluidRow(column(width = 12, selectInput('Selected_Death_View', 'View', view_types, 'Daily'))),
        fluidRow(column(width = 1, align = 'center', uiOutput('Start_Date_Deaths'), uiOutput('End_Date_Deaths')), column(width = 10, plotlyOutput('Plotly_Deaths', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Deaths'))),
        tags$style(type='text/css', '#Start_Date_Deaths { width:100%; margin-top: 150px;}'),
        tags$style(type='text/css', '#End_Date_Deaths { width:100%; margin-bottom: 150px;}')
      ),
      # Demographics - Deaths
      tabPanel(
        'Demographics',
        # Age Group - Deaths
        fluidRow(column(width = 1, radioButtons('ID_Age_Group_Deaths', 'Chart Type', c("Bar Graph", "Line Graph"), 'Bar Graph')), column(width = 10, plotlyOutput('Plotly_Age_Group_Deaths', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Age_Group_Deaths'))),
        # Gender - Deaths
        fluidRow(column(width = 1, radioButtons('ID_Gender_Deaths', 'Chart Type', plot_types, 'Pie Chart')), column(width = 10, plotlyOutput('Plotly_Gender_Deaths', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Gender_Deaths'))),
        # Race - Deaths
        fluidRow(column(width = 1, radioButtons('ID_Race_Deaths', 'Chart Type', c("Bar Graph", "Line Graph"), 'Bar Graph')), column(width = 10, plotlyOutput('Plotly_Race_Deaths', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Race_Deaths'))),
        # Ethnicity - Deaths
        fluidRow(column(width = 1, radioButtons('ID_Ethnicity_Deaths', 'Chart Type', plot_types, 'Pie Chart')), column(width = 10, plotlyOutput('Plotly_Ethnicity_Deaths', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Ethnicity_Deaths')))
      ),
      # Municipalities - Deaths
      tabPanel(
        'Municipalities',
        fluidRow(column(width = 12, sliderInput('ID_Top_Zip_Codes_Deaths', 'Towns to Display (5 to 20)', min = 5, max = 20, value = 10)), column(width = 10, offset = 1, plotlyOutput('Plotly_Top_Zip_Codes_Deaths', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Top_Zip_Codes_Deaths'))),
        fluidRow(column(width = 12, selectInput('ID_Zip_Codes_Deaths', 'Town to Display', sort(dataValidation$zipCodes$Town.City), 'Goshen')), column(width = 10, offset = 1, plotlyOutput('Plotly_Zip_Codes_Deaths', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Zip_Codes_Deaths')))
      ),
      # Vaccination - Deaths
      tabPanel(
        'Vaccinations',
        fluidRow(column(width = 1, radioButtons('ID_Vaccination_Deaths', 'Chart Type', plot_types, 'Bar Graph')), column(width = 10, plotlyOutput('Plotly_Vaccination_Deaths', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('Text_Vaccination_Deaths')))
      )
    )
  )
}

server <- function(input, output, session) {
  observeEvent(input$idNavbarPage, updateNavbarPage(session, 'Selected_Case_View', 'Daily'))
  
  dateData <- reactive({
    req(input$Selected_Case_View, input$Start_Date_Cases, input$End_Date_Cases, input$Start_Date_Symp, input$End_Date_Symp, input$Start_Date_Asymp, input$End_Date_Asymp)
    
    switch (
      input$Selected_Case_View,
      'Daily'   = {
        cases <- GetDateLimitedData(cases_C, input$Start_Date_Cases, input$End_Date_Cases, 'day')
        symp  <- GetDateLimitedData(symptomatic_C, input$Start_Date_Symp, input$End_Date_Symp, 'day')
        asymp <- GetDateLimitedData(asymptomatic_C, input$Start_Date_Asymp, input$End_Date_Asymp, 'day')
      },
      'Weekly'  = {
        cases <- GetDateLimitedData(cases_C, input$Start_Date_Cases, input$End_Date_Cases, 'week')
        symp  <- GetDateLimitedData(symptomatic_C, input$Start_Date_Symp, input$End_Date_Symp, 'week')
        asymp <- GetDateLimitedData(asymptomatic_C, input$Start_Date_Asymp, input$End_Date_Asymp, 'week')
      },
      'Monthly' = {
        cases <- GetDateLimitedData(cases_C, input$Start_Date_Cases, input$End_Date_Cases, 'month')
        symp  <- GetDateLimitedData(symptomatic_C, input$Start_Date_Symp, input$End_Date_Symp, 'month')
        asymp <- GetDateLimitedData(asymptomatic_C, input$Start_Date_Asymp, input$End_Date_Asymp, 'month')
      },
      'Yearly'  = {
        cases <- GetDateData(cases_C, 'year')
        symp  <- GetDateData(symptomatic_C, 'year')
        asymp <- GetDateData(asymptomatic_C, 'year')
      }
    )
    list(cases=cases, symp=symp, asymp=asymp, iselview=input$Selected_Case_View)
  })
  
  data_db <- debounce(dateData, millis = 300)
  
  # Cases ----------------------------------------------------------------------
  observeEvent(input$Start_Date_Cases, {
    switch(
      input$Selected_Case_View,
      'Daily' = updateDateInput(session, 'End_Date_Cases', min = input$Start_Date_Cases + 6),
      'Weekly' = updateDateInput(session, 'End_Date_Cases', min = input$Start_Date_Cases + 34),
      'Monthly' = updateDateInput(session, 'End_Date_Cases', min = input$Start_Date_Cases %m+% months(5))
    )
  })
  observeEvent(input$End_Date_Cases, {
    switch(
      input$Selected_Case_View,
      'Daily' = updateDateInput(session, 'Start_Date_Cases', max = input$End_Date_Cases - 6),
      'Weekly' = updateDateInput(session, 'Start_Date_Cases', max = input$End_Date_Cases - 34),
      'Monthly' = updateDateInput(session, 'Start_Date_Cases', max = input$End_Date_Cases %m-% months(5))
    )
  })

  output$Start_Date_Cases <- renderUI({
    req(input$Selected_Case_View)
    switch (
      input$Selected_Case_View,
      'Daily' = {
        data <- GetDateData(cases_C, 'day')
        dateInput('Start_Date_Cases', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month')
      },
      'Weekly' = {
        data <- GetDateData(cases_C, 'week')
        dateInput('Start_Date_Cases', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(cases_C, 'month')
        min_date <- min(floor_date(data$Date, 'month'))
        max_date <- max(ceiling_date(data$Date, 'month')) - 1
        CustomDateInput('Start_Date_Cases', 'Start Date', startview = 'year', minview = 'months', maxview = 'decades', value = min_date, min = min_date, max = max_date, format = 'M, yyyy')
      },
      'Yearly' = {
        data <- GetDateData(cases_C, 'year')
        dateInput('Start_Date_Cases', 'Start Date', value = min(data$Date))
        shinyjs::disable('Start_Date_Cases')
      }
    )
  })
  output$End_Date_Cases <- renderUI({
    req(input$Selected_Case_View)
    switch (
      input$Selected_Case_View,
      'Daily' = {
        data <- GetDateData(cases_C, 'day')
        dateInput('End_Date_Cases', 'End Date', value = max(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month')
      },
      'Weekly' = {
        data <- GetDateData(cases_C, 'week')
        dateInput('End_Date_Cases', 'End Date', value = max(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(cases_C, 'month')
        min_date <- as.Date(min(floor_date(data$Date, 'month')))
        max_date <- as.Date(max(ceiling_date(data$Date, 'month'))) - 1
        CustomDateInput('End_Date_Cases', 'End Date', startview = 'year', minview = 'months', maxview = 'decades', value = max_date, min = min_date, max = max_date, format = 'M, yyyy')
      },
      'Yearly' = {
        data <- GetDateData(cases_C, 'year')
        dateInput('End_Date_Cases', 'Start Date', value = min(data$Date))
        shinyjs::disable('Start_Date_Cases')
      }
    )
  })
  
  output$Plotly_Cases <- renderPlotly({
    temp <- req(data_db())
    data <- temp$cases
    iselview <- temp$iselview
    
    switch(
      iselview,
      'Daily' = {
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Count)
        
        plot <- data %>%
          MakePlotlyLine(data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$casesD_C, second_line) %>%
          FormatX_Axis('Received Date') %>%
          layout(hovermode = 'x')
      },
      'Weekly' = {
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Count)
        
        plot <- data %>%
          MakePlotlyLine(data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$casesW_C, second_line) %>%
          FormatX_Axis('Received Week') %>%
          layout(hovermode = 'x')
      },
      'Monthly' = {
        second_line <- MakeTitleSecondLine(data$Date, '%B, %Y', data$Count)
        
        # Create the plot
        plot <- MakePlotlyBar(data, data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$casesM_C, second_line) %>%
          FormatX_Axis('Received Month') %>%
          layout(xaxis = list(range = c(min(data$Date) - 20, max(data$Date) + 20), hoverformat = '%B, %Y', dtick = 'M1', tickformat = '%b\n%Y'))
      },
      'Yearly' = {
        second_line <- MakeTitleSecondLine(data$Date, '%Y', data$Count)
        
        # Create the plot
        plot <- MakePlotlyBar(data, data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$casesY_C, second_line) %>%
          FormatX_Axis('Received Year') %>%
          layout(xaxis = list(hoverformat = '%Y', dtick = 'M12', tickformat = '%Y'))
      }
    )
    plot <- plot %>% FormatY_Axis('Cases')
  })
  
  output$Text_Cases <- renderText({
    temp <- req(data_db())
    data <- temp$cases
    
    switch (
      temp$iselview,
      'Daily'   = {
        min_date <- format(min(floor_date(data$Date, 'day')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'day')) - 1, '%B %d, %Y')
      },
      'Weekly'  = {
        min_date <- format(min(floor_date(data$Date, 'week')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'week')) - 7, '%B %d, %Y')
      },
      'Monthly' = {
        min_date <- format(min(floor_date(data$Date, 'month')), '%B, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'month')) - 1, '%B, %Y')
      },
      'Yearly'  = {
        min_date <- format(min(floor_date(data$Date, 'year')), '%Y')
        max_date <- format(max(ceiling_date(data$Date, 'year')) - 1, '%Y')
      }
    )
    
    paste('<br><b>Note: The dates in 2020 of April 24th, April 29th, December 17th, and in 2021 of March 17th and December 29th 
          were dates when laboratories uploaded backlogged data. Total cases represented in the graph between ', min_date, 
          ' and ', max_date, ' (n=', format(sum(data$Count), big.mark = ','), '). Total confirmed cases of COVID-19 reported as of ', 
          format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(cases_C$Count), big.mark = ','), ')', '.</b><br><br>', sep = '')
  })
  
  # Symptomatic Cases ----------------------------------------------------------
  observeEvent(input$Start_Date_Symp, {
    switch(
      input$Selected_Case_View,
      'Daily' = updateDateInput(session, 'End_Date_Symp', min = input$Start_Date_Symp + 6),
      'Weekly' = updateDateInput(session, 'End_Date_Symp', min = input$Start_Date_Symp + 34),
      'Monthly' = updateDateInput(session, 'End_Date_Symp', min = input$Start_Date_Symp %m+% months(5))
    )
  })
  observeEvent(input$End_Date_Symp, {
    switch(
      input$Selected_Case_View,
      'Daily' = updateDateInput(session, 'Start_Date_Symp', max = input$End_Date_Symp - 6),
      'Weekly' = updateDateInput(session, 'Start_Date_Symp', max = input$End_Date_Symp - 34),
      'Monthly' = updateDateInput(session, 'Start_Date_Symp', max = input$End_Date_Symp %m-% months(5))
    )
  })
  
  output$Start_Date_Symp <- renderUI({
    req(input$Selected_Case_View)
    switch (
      input$Selected_Case_View,
      'Daily' = {
        data <- GetDateData(symptomatic_C, 'day')
        dateInput('Start_Date_Symp', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month')
      },
      'Weekly' = {
        data <- GetDateData(symptomatic_C, 'week')
        dateInput('Start_Date_Symp', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(symptomatic_C, 'month')
        min_date <- as.Date(min(floor_date(data$Date, 'month')))
        max_date <- as.Date(max(ceiling_date(data$Date, 'month'))) - 1
        CustomDateInput('Start_Date_Symp', 'Start Date', startview = 'year', minview = 'months', maxview = 'decades', value = min_date, min = min_date, max = max_date, format = 'M, yyyy')
      },
      'Yearly' = shinyjs::disable('Start_Date_Symp')
    )
  })
  output$End_Date_Symp <- renderUI({
    req(input$Selected_Case_View)
    
    switch (
      input$Selected_Case_View,
      'Daily' = {
        data <- GetDateData(symptomatic_C, 'day')
        dateInput('End_Date_Symp', 'End Date', value = max(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month')
      },
      'Weekly' = {
        data <- GetDateData(symptomatic_C, 'week')
        dateInput('End_Date_Symp', 'End Date', value = max(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(symptomatic_C, 'month')
        min_date <- as.Date(min(floor_date(data$Date, 'month')))
        max_date <- as.Date(max(ceiling_date(data$Date, 'month'))) - 1
        CustomDateInput('End_Date_Symp', 'Start Date', startview = 'year', minview = 'months', maxview = 'decades', value = max_date, min = min_date, max = max_date, format = 'M, yyyy')
      },
      'Yearly' = shinyjs::disable('End_Date_Symp')
    )
  })
  
  output$Plotly_Symptomatic_Cases <- renderPlotly({
    temp <- req(data_db())
    data <- temp$symp
    iselview <- temp$iselview
    
    # Switch to determine view for graph
    switch(
      iselview,
      'Daily' = {
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Count)
        
        plot <- data %>%
          MakePlotlyLine(data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$sympD_C, second_line) %>%
          FormatX_Axis('Date of Symptom Onset') %>%
          layout(hovermode = 'x')
      },
      'Weekly' = {
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Count)
        
        plot <- data %>%
          MakePlotlyLine(data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$sympW_C, second_line) %>%
          FormatX_Axis('Week of Symptom Onset') %>%
          layout(hovermode = 'x')
      },
      'Monthly' = {
        second_line <- MakeTitleSecondLine(data$Date, '%B, %Y', data$Count)
        
        plot <- MakePlotlyBar(data, data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$sympM_C, second_line) %>%
          FormatX_Axis('Month of Symptom Onset') %>%
          layout(xaxis = list(range = c(min(data$Date) - 20, max(data$Date) + 20), hoverformat = '%B, %Y', dtick = 'M1', tickformat = '%b\n%Y'))
      },
      'Yearly' = {
        second_line <- MakeTitleSecondLine(data$Date, '%Y', data$Count)
        
        plot <- MakePlotlyBar(data, data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$sympY_C, second_line) %>%
          FormatX_Axis('Year of Symptom Onset') %>%
          layout(xaxis = list(hoverformat = '%Y', dtick = 'M12', tickformat = '%Y'))
      }
    )
    plot <- plot %>% FormatY_Axis('Cases')
  })
  
  output$Text_Symptomatic_Cases <- renderText({
    temp <- req(data_db())
    data <- temp$symp
    
    switch (
      temp$iselview,
      'Daily'   = {
        data <- GetDateLimitedData(symptomatic_C, input$Start_Date_Symp, input$End_Date_Symp, 'day')
        min_date <- format(min(floor_date(data$Date, 'day')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'day')) - 1, '%B %d, %Y')
      },
      'Weekly'  = {
        data <- GetDateLimitedData(symptomatic_C, input$Start_Date_Symp, input$End_Date_Symp, 'week')
        min_date <- format(min(floor_date(data$Date, 'week')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'week')) - 7, '%B %d, %Y')
      },
      'Monthly' = {
        data <- GetDateLimitedData(symptomatic_C, input$Start_Date_Symp, input$End_Date_Symp, 'month')
        min_date <- format(min(floor_date(data$Date, 'month')), '%B, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'month')) - 1, '%B, %Y')
      },
      'Yearly'  = {
        data <- GetDateData(symptomatic_C, 'year')
        min_date <- format(min(floor_date(data$Date, 'year')), '%Y')
        max_date <- format(max(ceiling_date(data$Date, 'year')) - 1, '%Y')
      }
    )
    
    paste('<br><b>Note: This graph does not reflect the most recent cases due to case investigation and data processing. Individuals who were asymptomatic 
          (', format(sum(asymptomatic_C$Count), big.mark = ','), '), in data processing, were lost to follow up and/or had an unknown date of first symptom 
          (', format(sum(cases_C$Count) - (sum(asymptomatic_C$Count) + sum(symptomatic_C$Count)), big.mark = ','),') were excluded from analysis. 
          Cases represented in graph between ', min_date, ' and ', max_date, ' (n=', format(sum(data$Count), big.mark = ','), '). 
          Symptomatic cases reported and processed as of ', format(max(cases_C$Date), '%B %d, %Y'),' (n=', format(sum(symptomatic_C$Count), big.mark = ','), ')', '.</b><br><br>', sep = '')
  })
  
  # Asymptomatic Cases ---------------------------------------------------------
  observeEvent(input$Start_Date_Asymp, {
    switch(
      input$Selected_Case_View,
      'Daily' = updateDateInput(session, 'End_Date_Asymp', min = input$Start_Date_Asymp + 6),
      'Weekly' = updateDateInput(session, 'End_Date_Asymp', min = input$Start_Date_Asymp + 34),
      'Monthly' = updateDateInput(session, 'End_Date_Asymp', min = input$Start_Date_Asymp %m+% months(5))
    )
  })
  observeEvent(input$End_Date_Asymp, {
    switch(
      input$Selected_Case_View,
      'Daily' = updateDateInput(session, 'Start_Date_Asymp', max = input$End_Date_Asymp - 6),
      'Weekly' = updateDateInput(session, 'Start_Date_Asymp', max = input$End_Date_Asymp - 34),
      'Monthly' = updateDateInput(session, 'Start_Date_Asymp', max = input$End_Date_Asymp %m-% months(5))
    )
  })
  
  output$Start_Date_Asymp <- renderUI({
    req(input$Selected_Case_View)
    
    switch (
      input$Selected_Case_View,
      'Daily' = {
        data <- GetDateData(asymptomatic_C, 'day')
        dateInput('Start_Date_Asymp', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month')
      },
      'Weekly' = {
        data <- GetDateData(asymptomatic_C, 'week')
        dateInput('Start_Date_Asymp', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(asymptomatic_C, 'month')
        min_date <- as.Date(min(floor_date(data$Date, 'month')))
        max_date <- as.Date(max(ceiling_date(data$Date, 'month'))) - 1
        CustomDateInput('Start_Date_Asymp', 'Start Date', startview = 'year', minview = 'months', maxview = 'decades', value = min_date, min = min_date, max = max_date, format = 'M, yyyy')
      },
      'Yearly' = {
        shinyjs::disable('Start_Date_Asymp')
      }
    )
  })
  output$End_Date_Asymp <- renderUI({
    req(input$Selected_Case_View)
    
    switch (
      input$Selected_Case_View,
      'Daily' = {
        data <- GetDateData(asymptomatic_C, 'day')
        dateInput('End_Date_Asymp', 'End Date', value = max(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month')
      },
      'Weekly' = {
        data <- GetDateData(asymptomatic_C, 'week')
        dateInput('End_Date_Asymp', 'End Date', value = max(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(asymptomatic_C, 'month')
        min_date <- as.Date(min(floor_date(data$Date, 'month')))
        max_date <- as.Date(max(ceiling_date(data$Date, 'month'))) - 1
        CustomDateInput('End_Date_Asymp', 'End Date', startview = 'year', minview = 'months', maxview = 'decades', value = max_date, min = min_date, max = max_date, format = 'M, yyyy')
      },
      'Yearly' = {
        shinyjs::disable('End_Date_Asymp')
      }
    )
  })
  
  output$Plotly_Asymptomatic_Cases <- renderPlotly({
    temp <- req(data_db())
    data <- temp$asymp
    iselview <- temp$iselview
    
    # Switch to determine view for graph
    switch(
      iselview,
      'Daily' = {
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Count)
        
        plot <- MakePlotlyLine(data, data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$asympD_C, second_line) %>%
          FormatX_Axis('Received Date') %>%
          layout(hovermode = 'x')
      },
      'Weekly' = {
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Count)
        
        plot <- MakePlotlyLine(data, data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$asympW_C, second_line) %>%
          FormatX_Axis('Received Week') %>%
          layout(hovermode = 'x')
      },
      'Monthly' = {
        second_line <- MakeTitleSecondLine(data$Date, '%B, %Y', data$Count)
        
        plot <- MakePlotlyBar(data, data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$asympM_C, second_line) %>%
          FormatX_Axis('Received Month') %>%
          layout(xaxis = list(range = c(min(data$Date) - 20, max(data$Date) + 20), hoverformat = '%B, %Y', dtick = 'M1', tickformat = '%b\n%Y'))
      },
      'Yearly' = {
        second_line <- MakeTitleSecondLine(data$Date, '%Y', data$Count)
        
        plot <- MakePlotlyBar(data, data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$asympY_C, second_line) %>%
          FormatX_Axis('Received Year') %>%
          layout(xaxis = list(hoverformat = '%Y', dtick = 'M12', tickformat = '%Y'))
      }
    )
    plot <- plot %>% FormatY_Axis('Cases')
  })
  
  output$Text_Asymptomatic_Cases <- renderText({
    temp <- req(data_db())
    data <- temp$asymp
    
    switch (
      temp$iselview,
      'Daily'   = {
        data <- GetDateLimitedData(asymptomatic_C, input$Start_Date_Asymp, input$End_Date_Asymp, 'day')
        min_date <- format(min(floor_date(data$Date, 'day')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'day')) - 1, '%B %d, %Y')
      },
      'Weekly'  = {
        data <- GetDateLimitedData(asymptomatic_C, input$Start_Date_Asymp, input$End_Date_Asymp, 'week')
        min_date <- format(min(floor_date(data$Date, 'week')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'week')) - 7, '%B %d, %Y')
      },
      'Monthly' = {
        data <- GetDateLimitedData(asymptomatic_C, input$Start_Date_Asymp, input$End_Date_Asymp, 'month')
        min_date <- format(min(floor_date(data$Date, 'month')), '%B, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'month')) - 1, '%B, %Y')
      },
      'Yearly'  = {
        data <- GetDateData(asymptomatic_C, 'year')
        min_date <- format(min(floor_date(data$Date, 'year')), '%Y')
        max_date <- format(max(ceiling_date(data$Date, 'year')) - 1, '%Y')
      }
    )
    
    paste('<br><b>Note: This graph does not reflect the most recent cases due to case investigation and data processing. 
          Asymptomatic cases reported and processed represented in graph between ', min_date, ' and ', max_date, ' (n=', 
          format(sum(data$Count), big.mark = ','), '). Asymptomatic cases reported and processed as of ', format(max(cases_C$Date), '%B %d, %Y'), 
          ' (n=', format(sum(asymptomatic_C$Count), big.mark = ','), ')', '.</b><br><br>', sep = '')
  })
  
  # Age Group ------------------------------------------------------------------
  output$Plotly_Age_Group_Cases <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(cases_C$Count), sum(ageGroup_C$Count), titleStrings$ageGroup_C)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(ageGroup_C$Count), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue)
    
    # Create the chart based on user input
    switch (input$ID_Age_Group_Cases,
      'Bar Graph' = {
        data <- group_by(ageGroup_C, Age.Group) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyBar(data, data$Age.Group, data$Count, colors) %>%
          FormatX_Axis('Age Group', 'category ascending') %>%
          FormatY_Axis('Cases')
      },
      'Pie Chart' = {
        data <- group_by(ageGroup_C, Age.Group) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyPie(data, data$Age.Group, data$Count, 'Age Group', 'Cases', colors) %>%
          layout(legend = list(x = .9, y = .5))
      },
      'Line Graph' = {
        data <- ageGroup_C %>% pivot_wider(names_from = Age.Group, values_from = Count)
        
        first_line <- CheckTitleWhereKnown(sum(cases_C$Count), sum(ageGroup_C$Count), titleStrings$ageGroupD_C)

        plot <- plot_ly(data, x = ~Date, hovertemplate = paste('<b>%{y}</b>')) %>%
          add_trace(y = ~`0-17`,  name = '0-17',  type = 'scatter', mode = 'lines', line = list(color = colors[1]), hoverinfo = 'text', hovertext = paste('<b>0-17</b>:',  format(data$`0-17`, big.mark = ','))) %>%
          add_trace(y = ~`18-44`, name = '18-44', type = 'scatter', mode = 'lines', line = list(color = colors[2]), hoverinfo = 'text', hovertext = paste('<b>18-44</b>:', format(data$`18-44`, big.mark = ','))) %>%
          add_trace(y = ~`45-64`, name = '45-64', type = 'scatter', mode = 'lines', line = list(color = colors[3]), hoverinfo = 'text', hovertext = paste('<b>45-64</b>:', format(data$`45-64`, big.mark = ','))) %>%
          add_trace(y = ~`65-74`, name = '65-74', type = 'scatter', mode = 'lines', line = list(color = colors[4]), hoverinfo = 'text', hovertext = paste('<b>65-74</b>:', format(data$`65-74`, big.mark = ','))) %>%
          add_trace(y = ~`75+`,   name = '75+',   type = 'scatter', mode = 'lines', line = list(color = colors[5]), hoverinfo = 'text', hovertext = paste('<b>75+</b>:',   format(data$`75+`, big.mark = ','))) %>%
          FormatX_Axis('Received Date', 'trace') %>%
          FormatY_Axis('Cases') %>%
          layout(hovermode = 'x unified', legend = list(x = 1, y = .5, title = list(text = '<b>Click to Add/Remove</b>')))
      }
    )
    plot <- plot %>% SetTitle(first_line, second_line)
  })
  
  output$Text_Age_Group_Cases <- renderText({
    percentages <- GetPercent(ageGroup_C, ageGroup_C$Age.Group, ageGroup_C$Count, dataValidation$ageGroup)
    
    paste(
      '<br><b>Note: Ages were calculated using laboratory reported or case reported date of birth. Missing data (n=', 
      format(sum(cases_C$Count) - sum(ageGroup_C$Count), big.mark = ','), '). The percent per age group is: 0-17 = ', 
      percentages[1], '; 18-44 = ', percentages[2], '; 45-64 = ', percentages[3], '; 65-74 = ', percentages[4], '; and 75+ = ', 
      percentages[5], '.</b><br><br>', sep = '')
  })
  
  # Gender ---------------------------------------------------------------------
  output$Plotly_Gender_Cases <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(cases_C$Count), sum(gender_C$Count), titleStrings$gender_C)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(gender_C$Count), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$red, myColors$blue)
    
    # Create the chart based on user input
    switch (
      input$ID_Gender_Cases,
      'Bar Graph' = {
        data <- group_by(gender_C, Gender) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyBar(data, data$Gender, data$Count, colors) %>%
          FormatX_Axis('Gender', 'category ascending') %>%
          FormatY_Axis('Cases')
      },
      'Pie Chart' = {
        data <- group_by(gender_C, Gender) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyPie(data, data$Gender, data$Count, 'Gender', 'Cases', colors) %>%
          layout(legend = list(x = .9, y = .5))
      },
      'Line Graph' = {
        data <- gender_C %>% pivot_wider(names_from = Gender, values_from = Count)
        
        first_line <- CheckTitleWhereKnown(sum(cases_C$Count), sum(gender_C$Count), titleStrings$genderD_C)
        
        plot <- plot_ly(data, x = ~Date, hovertemplate = paste('<b>%{y}</b>'))
        
        # Add trace for female
        plot <- plot %>%
          add_trace(y = ~Female, name = 'Female', type = 'scatter', mode = 'lines', hoverinfo = 'text', line = list(color = colors[1]), hovertext = paste('<b>Female</b>:', format(data$Female, big.mark = ',')))%>%
          add_trace(y = ~Male, name = 'Male', type = 'scatter', mode = 'lines', hoverinfo = 'text', line = list(color = colors[2]), hovertext = paste('<b>Male</b>:', format(data$Male, big.mark = ',')))
        
        data$MaxCases <- pmax(data$Male, data$Female)
        
        plot <- plot %>%
          FormatX_Axis('Received Date', 'trace') %>%
          FormatY_Axis('Cases') %>%
          layout(hovermode = 'x unified', legend = list(x = 1, y = .5))
      }
    )
    
    plot <- plot %>% SetTitle(first_line, second_line)
  })
  
  output$Text_Gender_Cases <- renderText({
    paste(
      '<br><b>Note: Gender is self-reported field. Missing or Unknown when laboratory reporting did not provide this information and 
      case has not been reached yet (n=', format(sum(cases_C$Count) - sum(gender_C$Count), big.mark = ','), ').</b><br><br>', sep = '')
  })
  
  # Race -----------------------------------------------------------------------
  output$Plotly_Race_Cases <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(cases_C$Count), sum(race_C$Count), titleStrings$race_C)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(race_C$Count), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue)
    
    # Create the chart based on user input
    switch (
      input$ID_Race_Cases,
      'Bar Graph' = {
        data <- group_by(race_C, Race) %>% summarise(Count = sum(Count))
        data$Race[data$Race == 'Asian/Native Hawaiian/Other Pacific Islander'] = 'Asian/\nNative Hawaiian/\nOther Pacific Islander'
        data$Race[data$Race == 'Native American/Alaska Native'] = 'Native American/\nAlaska Native'
        
        plot <- MakePlotlyBar(data, data$Race, data$Count, colors) %>%
          FormatX_Axis('Race', 'total descending') %>%
          FormatY_Axis('Cases')
      },
      'Line Graph' = {
        data <- race_C %>% pivot_wider(names_from = Race, values_from = Count) %>%
          rename(Asian = `Asian/Native Hawaiian/Other Pacific Islander`, Native = `Native American/Alaska Native`)
        
        first_line <- CheckTitleWhereKnown(sum(cases_C$Count), sum(race_C$Count), titleStrings$raceD_C)
        
        names <- c('Asian/\nNative Hawaiian/\nOther Pacific Islander', 'Black', 'Native American/\nAlaska Native', 'Other', 'White')
        
        plot <- data %>%
          # Create the graph with just the x-axis, no data on the graph
          plot_ly(x = ~ Date, hovertemplate = paste('<b>%{y}</b>')) %>%
          add_trace(y = ~Asian,  legendgroup = names[1], name = names[1], type = 'scatter', mode = 'lines', line = list(color = colors[1]), hoverinfo = 'text', hovertext = paste('<b>', names[1], '</b>:', format(data$Asian, big.mark = ','))) %>%
          add_trace(y = ~Black,  legendgroup = names[2], name = names[2], type = 'scatter', mode = 'lines', line = list(color = colors[2]), hoverinfo = 'text', hovertext = paste('<b>', names[2], '</b>:', format(data$Black, big.mark = ','))) %>%
          add_trace(y = ~Native, legendgroup = names[3], name = names[3], type = 'scatter', mode = 'lines', line = list(color = colors[3]), hoverinfo = 'text', hovertext = paste('<b>', names[3], '</b>:', format(data$Native, big.mark = ','))) %>%
          add_trace(y = ~Other,  legendgroup = names[4], name = names[4], type = 'scatter', mode = 'lines', line = list(color = colors[4]), hoverinfo = 'text', hovertext = paste('<b>', names[4], '</b>:', format(data$Other, big.mark = ','))) %>%
          add_trace(y = ~White,  legendgroup = names[5], name = names[5], type = 'scatter', mode = 'lines', line = list(color = colors[5]), hoverinfo = 'text', hovertext = paste('<b>', names[5], '</b>:', format(data$White, big.mark = ',')))
        
        
        data$MaxCases <- pmax(data$White, data$Black, data$Native, data$Asian, data$Other)
        
        plot <- plot %>%
          FormatX_Axis('Received Date', 'trace') %>%
          FormatY_Axis('Cases') %>%
          layout(hovermode = 'x unified', legend = list(x = 1, y = .5, title = list(text = '<b>Click to Add/Remove</b>')))
      }
    )
    
    plot <- plot %>%
      SetTitle(first_line, second_line) %>% 
      config(plot, displayModeBar = FALSE) %>%
      layout(margin = list(l = 10, r = 10, b = 10, t = 100, pad = 10))
  })
  
  output$Text_Race_Cases <- renderText({
    percentages <- GetPercent(race_C, race_C$Race, race_C$Count, dataValidation$race)
    
    paste(
      '<br><b>Note: Race is largely self-reported data and are identified through case investigation. Data are incomplete 
      due to delays in reporting, data entry, unknown or undetermined risk factors and persons lost to follow up (n=', 
      format(sum(cases_C$Count) - sum(race_C$Count), big.mark = ','), '). The percent per race is: White = ', percentages[1], 
      '; Black = ', percentages[2], '; Native American/Alaska Native = ', percentages[3], '; Asian/Native Hawaiian/Other Pacific Islander = ', 
      percentages[4], '; and Other = ', percentages[5], '.</b><br><br>', sep = '')
  })
  
  # Ethnicity ------------------------------------------------------------------
  output$Plotly_Ethnicity_Cases <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(cases_C$Count), sum(ethnicity_C$Count), titleStrings$ethnicity_C)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(ethnicity_C$Count), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple)
    
    # Create the chart based on user input
    switch (
      input$ID_Ethnicity_Cases,
      'Bar Graph' = {
        data <- group_by(ethnicity_C, Ethnicity) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyBar(data, data$Ethnicity, data$Count, colors) %>%
          FormatX_Axis('Ethnicity', 'category ascending') %>%
          FormatY_Axis('Cases')
      },
      'Pie Chart' = {
        data <- group_by(ethnicity_C, Ethnicity) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyPie(data, data$Ethnicity, data$Count, 'Ethnicity', 'Cases', colors) %>%
          layout(legend = list(x = .9, y = .5))
      },
      'Line Graph' = {
        data <- ethnicity_C %>% pivot_wider(names_from = Ethnicity, values_from = Count)
        
        first_line <- CheckTitleWhereKnown(sum(cases_C$Count), sum(ethnicity_C$Count), titleStrings$ethnicityD_C)
        
        plot <- plot_ly(data, x = ~Date, hovertemplate = paste('<b>%{y}</b>'))
        
        # Add trace for male
        plot <- plot %>% add_trace(
          y = ~Hispanic,
          name = 'Hispanic',
          type = 'scatter',
          mode = 'lines',
          hoverinfo = 'text',
          line = list(color = colors[1]),
          hovertext = paste('<b>Hispanic</b>:', format(data$Hispanic, big.mark = ','))
        )
        
        # Add trace for female
        plot <- plot %>% add_trace(
          y = ~`Non-Hispanic`,
          name = 'Non-Hispanic',
          type = 'scatter',
          mode = 'lines',
          hoverinfo = 'text',
          line = list(color = colors[2]),
          hovertext = paste('<b>Non-Hispanic</b>:', format(data$`Non-Hispanic`, big.mark = ','))
        )
        
        data$MaxCases <- pmax(data$Hispanic, data$`Non-Hispanic`)
        
        plot <- plot %>%
          FormatX_Axis('Received Date', 'trace') %>%
          FormatY_Axis('Cases') %>%
          layout(hovermode = 'x unified', legend = list(x = 1, y = .5))
      }
    )
    
    plot <- plot %>%
      SetTitle(first_line, second_line) %>% 
      config(plot, displayModeBar = FALSE) %>%
      layout(margin = list(l = 10, r = 10, b = 10, t = 100, pad = 10))
  })
  
  output$Text_Ethnicity_Cases <- renderText({
    paste(
      '<br><b>Note: Ethnicity is largely self-reported data and are identified through case investigation. 
      Data are incomplete due to delays in reporting, data entry, unknown, or undetermined risk factors and persons lost 
      to follow-up (n=', format(sum(cases_C$Count) - sum(ethnicity_C$Count), big.mark = ','), ').</b><br><br>', sep = '')
  })
  
  # Top Zip Codes --------------------------------------------------------------
  output$Plotly_Top_Zip_Codes_Cases <- renderPlotly({
    req(input$ID_Top_Zip_Codes_Cases)
    
    # Create the strings for the title
    data <- topZipCodes_C %>% slice_head(n = input$ID_Top_Zip_Codes_Cases)
    
    first_line <- paste(titleStrings$topZip_C, ' (Top ', input$ID_Top_Zip_Codes_Cases, ')', sep = '')
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(data$Count), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue, myColors$yellow, myColors$lblue, myColors$dgreen,
                myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue, myColors$yellow, myColors$lblue, myColors$dgreen,
                myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue, myColors$yellow, myColors$lblue, myColors$dgreen,
                myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue, myColors$yellow, myColors$lblue, myColors$dgreen)
    
    plot <- plot_ly(
      data,
      x = ~Zip.Code,
      y = ~Count,
      type = 'bar',
      text = ~format(Count, big.mark = ','),
      textposition = 'outside',
      textfont = list(color = '#000000'),
      marker = list(color = colors),
      showlegend = FALSE,
      hoverlabel = list(align = 'left', font = myFonts$tooltip),
      hovertemplate = paste(
        '<br><b>Zip Code</b>: %{x}',
        '<br><b>Town/City</b>:', data$Town.City,
        '<br><b>Cases</b>: %{y:,}',
        '<extra></extra>'
      )
    )
    
    # Create the chart
    plot <- plot %>%
      SetTitle(first_line, second_line) %>% 
      FormatX_Axis(label = 'Zip Code', 'total descending') %>%
      FormatY_Axis('Cases') %>%
      config(plot, displayModeBar = FALSE) %>%
      layout(margin = list(l = 10, r = 10, b = 10, t = 100, pad = 10))
  })
  
  output$Text_Top_Zip_Codes_Cases <- renderText({
    paste(
      '<br><b>Note: Data are incomplete due to ongoing case investigation. ', str_to_title(as.english(input$ID_Top_Zip_Codes_Cases)), 
      ' most reported zip codes represented in graph (n=', format(sum(top_n(topZipCodes_C, input$ID_Top_Zip_Codes_Cases, Count)$Count), big.mark = ','), 
      ') representing ', sprintf('%0.1f%%', sum(top_n(topZipCodes_C, input$ID_Top_Zip_Codes_Cases, Count)$Count) / sum(cases_C$Count) * 100), ' of cases.</b><br><br>', sep = ''
    )
  })
  
  # Zip Codes by Date ----------------------------------------------------------
  output$Plotly_Zip_Codes_Cases <- renderPlotly({
    req(input$ID_Zip_Codes_Cases)
    
    # Filter the data to the town/city selected by the user
    data <- filter(zip_daily_C, Town.City == input$ID_Zip_Codes_Cases)
    data <- data[order(data$Date, decreasing = FALSE), ]
    
    # Create string for the title
    first_line <- 'Confirmed Cases of COVID-19'
    second_line <- paste(input$ID_Zip_Codes_Cases, ', NY - As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(data$Count), big.mark = ','), ')', sep = '')
    
    plot <- MakePlotlyLine(data, data$Date, data$Count, myColors$blue)
    
    # Create the chart
    plot <- plot %>%
      SetTitle(first_line, second_line) %>% 
      FormatX_Axis(label = 'Received Date', 'trace') %>%
      FormatY_Axis('Cases') %>%
      config(plot, displayModeBar = FALSE) %>%
      layout(margin = list(l = 10, r = 10, b = 10, t = 100, pad = 10), hovermode = 'x')
  })
  
  output$Text_Zip_Codes_Cases <- renderText({
    req(input$ID_Zip_Codes_Cases)
    
    # Filter the data to the town/city selected by the user
    data <- filter(zip_daily_C, Town.City == input$ID_Zip_Codes_Cases)
    
    paste(
      '<br><b>Note: This graph does not reflect the most recent cases due to case investigation and data processing. 
      The data in the chart represents the cases in ', input$ID_Zip_Codes_Cases, ', NY (n=', format(sum(data$Count), big.mark = ','), ') as 
      of ', format(max(cases_C$Date), '%B %d, %Y'), '. The reported cases in ', input$ID_Zip_Codes_Cases, ' represent ', 
      sprintf('%0.2f%%', sum(data$Count) / sum(cases_C$Count) * 100), ' of all cases reported.</b><br><br>', sep = '')
  })
  
  # Vaccination ----------------------------------------------------------------
  output$Plotly_Vaccination_Cases <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(cases_C$Count), sum(vaccination_C$Count), titleStrings$vaccination_C)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(vaccination_C$Count), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue)
    
    # Create the chart based on user input
    switch (
      input$ID_Vaccination_Cases,
      'Bar Graph' = {
        data <- group_by(vaccination_C, Vaccinated) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyBar(data, data$Vaccinated, data$Count, colors) %>%
          FormatX_Axis('Age Group', 'total descending') %>%
          FormatY_Axis('Cases')
      },
      'Pie Chart' = {
        data <- group_by(vaccination_C, Vaccinated) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyPie(data, data$Vaccinated, data$Count, 'Age Group', 'Cases', colors) %>%
          layout(legend = list(x = .9, y = .5))
      },
      'Line Graph' = {
        data <- vaccination_C %>% pivot_wider(names_from = Vaccinated, values_from = Count) %>%
          rename(Partial = Partially)
        
        first_line <- CheckTitleWhereKnown(sum(cases_C$Count), sum(vaccination_C$Count), titleStrings$ageGroupD_C)
        
        plot <- plot_ly(data, x = ~Date, hovertemplate = paste('<b>%{y}</b>'))
        plot <- add_trace(plot, y = ~None, name = 'None',  type = 'scatter', mode = 'lines', line = list(color = colors[1]), hoverinfo = 'text', hovertext = paste('<b>None</b>:',  format(data$None, big.mark = ',')))
        plot <- add_trace(plot, y = ~Partial, name = 'Partial', type = 'scatter', mode = 'lines', line = list(color = colors[2]), hoverinfo = 'text', hovertext = paste('<b>Partial</b>:', format(data$Partial, big.mark = ',')))
        plot <- add_trace(plot, y = ~Fully, name = 'Fully', type = 'scatter', mode = 'lines', line = list(color = colors[3]), hoverinfo = 'text', hovertext = paste('<b>Fully</b>:', format(data$Fully, big.mark = ',')))
        plot <- add_trace(plot, y = ~Boosted, name = 'Boosted', type = 'scatter', mode = 'lines', line = list(color = colors[4]), hoverinfo = 'text', hovertext = paste('<b>Boosted</b>:', format(data$Boosted, big.mark = ',')))
        
        data$MaxCases <- pmax(data$None, data$Partial, data$Fully, data$Boosted)
        
        plot <- plot %>%
          FormatX_Axis('Received Date', 'trace') %>%
          FormatY_Axis('Cases') %>%
          layout(hovermode = 'x unified', legend = list(x = 1, y = .5, title = list(text = '<b>Click to Add/Remove</b>')), yaxis = list(rangemode = 'tozero'))
      }
    )
    
    plot <- plot %>%
      SetTitle(first_line, second_line) %>% 
      config(plot, displayModeBar = FALSE) %>%
      layout(margin = list(l = 10, r = 10, b = 10, t = 100, pad = 10))
  })
  
  output$Text_Vaccination_Cases <- renderText({
    percentages <- GetPercent(vaccination_C, vaccination_C$Vaccinated, vaccination_C$Count, dataValidation$vaccination)
    
    paste(
      '<br><b>Note: This graph does not reflect the most recent cases due to case investigation and data processing. 
      Missing data (n=', format(sum(cases_C$Count) - sum(vaccination_C$Count), big.mark = ','), '). The percent per 
      vaccination status is: None = ', percentages[1], '; Partially = ', percentages[2], '; Fully = ', percentages[3], 
      '; Boosted = ', percentages[4], '; and Second Booster = ', percentages[5], '.</b><br><br>', sep = '')
  })
  
  # Deaths ---------------------------------------------------------------------
  observeEvent(input$Start_Date_Deaths, {
    switch(
      input$Selected_Death_View,
      'Daily' = updateDateInput(session, 'End_Date_Deaths', min = input$Start_Date_Deaths + 6),
      'Weekly' = updateDateInput(session, 'End_Date_Deaths', min = input$Start_Date_Deaths + 34),
      'Monthly' = updateDateInput(session, 'End_Date_Deaths', min = input$Start_Date_Deaths %m+% months(5))
    )
  })
  observeEvent(input$End_Date_Deaths, {
    switch(
      input$Selected_Death_View,
      'Daily' = updateDateInput(session, 'Start_Date_Deaths', max = input$End_Date_Deaths - 6),
      'Weekly' = updateDateInput(session, 'Start_Date_Deaths', max = input$End_Date_Deaths - 34),
      'Monthly' = updateDateInput(session, 'Start_Date_Deaths', max = input$End_Date_Deaths %m-% months(5))
    )
  })
  
  output$Start_Date_Deaths <- renderUI({
    req(input$Selected_Death_View)
    switch (
      input$Selected_Death_View,
      'Daily' = {
        data <- GetDateData(deaths_D, 'day')
        dateInput('Start_Date_Deaths', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month')
      },
      'Weekly' = {
        data <- GetDateData(deaths_D, 'week')
        dateInput('Start_Date_Deaths', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(deaths_D, 'month')
        min_date <- min(floor_date(data$Date, 'month'))
        max_date <- max(ceiling_date(data$Date, 'month')) - 1
        CustomDateInput('Start_Date_Deaths', 'Start Date', startview = 'year', minview = 'months', maxview = 'decades', value = min_date, min = min_date, max = max_date, format = 'M, yyyy')
      },
      'Yearly' = {
        data <- GetDateData(deaths_D, 'year')
        dateInput('Start_Date_Deaths', 'Start Date', value = min(data$Date))
        shinyjs::disable('Start_Date_Deaths')
      }
    )
  })
  output$End_Date_Deaths <- renderUI({
    req(input$Selected_Death_View)
    switch (
      input$Selected_Death_View,
      'Daily' = {
        data <- GetDateData(deaths_D, 'day')
        dateInput('End_Date_Deaths', 'End Date', value = max(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month')
      },
      'Weekly' = {
        data <- GetDateData(deaths_D, 'week')
        dateInput('End_Date_Deaths', 'End Date', value = max(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(deaths_D, 'month')
        min_date <- as.Date(min(floor_date(data$Date, 'month')))
        max_date <- as.Date(max(ceiling_date(data$Date, 'month'))) - 1
        CustomDateInput('End_Date_Deaths', 'End Date', startview = 'year', minview = 'months', maxview = 'decades', value = max_date, min = min_date, max = max_date, format = 'M, yyyy')
      },
      'Yearly' = {
        data <- GetDateData(deaths_D, 'year')
        dateInput('End_Date_Deaths', 'Start Date', value = min(data$Date))
        shinyjs::disable('Start_Date_Deaths')
      }
    )
  })
  
  deaths <- reactive({
    req(input$Selected_Death_View, input$Start_Date_Deaths, input$End_Date_Deaths)
    
    switch (
      input$Selected_Death_View,
      'Daily'   = deaths <- GetDateLimitedData(deaths_D, input$Start_Date_Deaths, input$End_Date_Deaths, 'day'),
      'Weekly'  = deaths <- GetDateLimitedData(deaths_D, input$Start_Date_Deaths, input$End_Date_Deaths, 'week'),
      'Monthly' = deaths <- GetDateLimitedData(deaths_D, input$Start_Date_Deaths, input$End_Date_Deaths, 'month'),
      'Yearly'  = deaths <- GetDateData(deaths_D, 'year')
    )
    list(deaths=deaths, iselview=input$Selected_Death_View)
  })
  
  deaths_db <- debounce(deaths, millis = 300)
  
  output$Plotly_Deaths <- renderPlotly({
    temp <- req(deaths_db())
    data <- temp$deaths
    
    switch(
      temp$iselview,
      'Daily' = {
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Count)
        
        plot <- data %>%
          MakePlotlyLine(data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$deathsD_D, second_line) %>%
          FormatX_Axis('Date of Death') %>%
          layout(hovermode = 'x')
      },
      'Weekly' = {
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Count)
        
        plot <- data %>%
          MakePlotlyLine(data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$deathsW_D, second_line) %>%
          FormatX_Axis('Week of Death') %>%
          layout(hovermode = 'x')
      },
      'Monthly' = {
        second_line <- MakeTitleSecondLine(data$Date, '%B, %Y', data$Count)
        
        # Create the plot
        plot <- MakePlotlyBar(data, data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$deathsM_D, second_line) %>%
          FormatX_Axis('Month of Death') %>%
          layout(xaxis = list(range = c(min(data$Date) - 20, max(data$Date) + 20), hoverformat = '%B, %Y', dtick = 'M1', tickformat = '%b\n%Y'))
      },
      'Yearly' = {
        second_line <- MakeTitleSecondLine(data$Date, '%Y', data$Count)
        
        # Create the plot
        plot <- MakePlotlyBar(data, data$Date, data$Count, myColors$green) %>%
          SetTitle(titleStrings$deathsY_D, second_line) %>%
          FormatX_Axis('Year of Death') %>%
          layout(xaxis = list(hoverformat = '%Y', dtick = 'M12', tickformat = '%Y'))
      }
    )
    plot <- plot %>% FormatY_Axis('Deaths')
  })
  
  output$Text_Deaths <- renderText({
    temp <- req(deaths_db())
    data <- temp$deaths
    
    switch (
      temp$iselview,
      'Daily'   = {
        min_date <- format(min(floor_date(data$Date, 'day')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'day')) - 1, '%B %d, %Y')
      },
      'Weekly'  = {
        min_date <- format(min(floor_date(data$Date, 'week')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'week')) - 7, '%B %d, %Y')
      },
      'Monthly' = {
        min_date <- format(min(floor_date(data$Date, 'month')), '%B, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'month')) - 1, '%B, %Y')
      },
      'Yearly'  = {
        min_date <- format(min(floor_date(data$Date, 'year')), '%Y')
        max_date <- format(max(ceiling_date(data$Date, 'year')) - 1, '%Y')
      }
    )
    
    paste('<br><b>Note: Due to delays in reporting recent data are incomplete. Total deaths represented in the graph between ', 
          min_date, ' and ', max_date, ' (n=', format(sum(data$Count), big.mark = ','), '). Total confirmed deaths of COVID-19 
          reported as of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(deaths_D$Count), big.mark = ','), ')', '.</b><br><br>', sep = '')
  })
  
  # Age Group ------------------------------------------------------------------
  output$Plotly_Age_Group_Deaths <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(deaths_D$Count), sum(ageGroup_D$Count), titleStrings$ageGroup_D)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(ageGroup_D$Count), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue)
    
    # Create the chart based on user input
    switch (input$ID_Age_Group_Deaths,
            'Bar Graph' = {
              data <- group_by(ageGroup_D, Age.Group) %>% summarise(Count = sum(Count))
              
              plot <- MakePlotlyBar(data, data$Age.Group, data$Count, colors) %>%
                FormatX_Axis('Age Group', 'category ascending') %>%
                FormatY_Axis('Deaths')
            },
            'Line Graph' = {
              data <- ageGroup_D %>% pivot_wider(names_from = Age.Group, values_from = Count)
              
              first_line <- CheckTitleWhereKnown(sum(deaths_D$Count), sum(ageGroup_D$Count), titleStrings$ageGroup_D)
              
              plot <- plot_ly(data, x = ~Date, hovertemplate = paste('<b>%{y}</b>')) %>%
                add_trace(y = ~`0-17`,  name = '0-17',  type = 'scatter', mode = 'lines', line = list(color = colors[1]), hoverinfo = 'text', hovertext = paste('<b>0-17</b>:',  format(data$`0-17`, big.mark = ','))) %>%
                add_trace(y = ~`18-44`, name = '18-44', type = 'scatter', mode = 'lines', line = list(color = colors[2]), hoverinfo = 'text', hovertext = paste('<b>18-44</b>:', format(data$`18-44`, big.mark = ','))) %>%
                add_trace(y = ~`45-64`, name = '45-64', type = 'scatter', mode = 'lines', line = list(color = colors[3]), hoverinfo = 'text', hovertext = paste('<b>45-64</b>:', format(data$`45-64`, big.mark = ','))) %>%
                add_trace(y = ~`65-74`, name = '65-74', type = 'scatter', mode = 'lines', line = list(color = colors[4]), hoverinfo = 'text', hovertext = paste('<b>65-74</b>:', format(data$`65-74`, big.mark = ','))) %>%
                add_trace(y = ~`75+`,   name = '75+',   type = 'scatter', mode = 'lines', line = list(color = colors[5]), hoverinfo = 'text', hovertext = paste('<b>75+</b>:',   format(data$`75+`, big.mark = ','))) %>%
                FormatX_Axis('Received Date', 'trace') %>%
                FormatY_Axis('Deaths') %>%
                layout(hovermode = 'x unified', legend = list(x = 1, y = .5, title = list(text = '<b>Click to Add/Remove</b>')))
            }
    )
    plot <- plot %>% SetTitle(first_line, second_line)
  })
  
  output$Text_Age_Group_Deaths <- renderText({
    percentages <- GetPercent(ageGroup_D, ageGroup_D$Age.Group, ageGroup_D$Count, dataValidation$ageGroup)
    
    paste(
      '<br><b>Note: Due to delays in reporting recent data are incomplete.',
      if (sum(ageGroup_D$Count) < sum(deaths_D$Count)) { paste(' Missing data (n=', format(sum(deaths_D$Count) - sum(ageGroup_D$Count), big.mark = ','), ').', sep = '') },
      ' The percent per age group is: 0-17 = ', percentages[1], '; 18-44 = ', percentages[2], '; 45-64 = ', percentages[3], '; 65-74 = ', percentages[4], '; and 75+ = ', percentages[5], '.</b><br><br>',
      sep = ''
    )
  })
  
  # Gender ---------------------------------------------------------------------
  output$Plotly_Gender_Deaths <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(deaths_D$Count), sum(gender_D$Count), titleStrings$gender_D)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(gender_D$Count), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$red, myColors$blue)
    
    # Create the chart based on user input
    switch (
      input$ID_Gender_Deaths,
      'Bar Graph' = {
        data <- group_by(gender_D, Gender) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyBar(data, data$Gender, data$Count, colors) %>%
          FormatX_Axis('Gender', 'category ascending') %>%
          FormatY_Axis('Deaths')
      },
      'Pie Chart' = {
        data <- group_by(gender_D, Gender) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyPie(data, data$Gender, data$Count, 'Gender', 'Deaths', colors) %>%
          layout(legend = list(x = .9, y = .5))
      },
      'Line Graph' = {
        data <- gender_D %>% pivot_wider(names_from = Gender, values_from = Count)
        
        first_line <- CheckTitleWhereKnown(sum(deaths_D$Count), sum(gender_D$Count), titleStrings$genderD_D)
        
        plot <- plot_ly(data, x = ~Date, hovertemplate = paste('<b>%{y}</b>'))
        
        # Add trace for female
        plot <- plot %>%
          add_trace(y = ~Female, name = 'Female', type = 'scatter', mode = 'lines', hoverinfo = 'text', line = list(color = colors[1]), hovertext = paste('<b>Female</b>:', format(data$Female, big.mark = ',')))%>%
          add_trace(y = ~Male, name = 'Male', type = 'scatter', mode = 'lines', hoverinfo = 'text', line = list(color = colors[2]), hovertext = paste('<b>Male</b>:', format(data$Male, big.mark = ',')))
        
        data$MaxDeaths <- pmax(data$Male, data$Female)
        
        plot <- plot %>%
          FormatX_Axis('Received Date', 'trace') %>%
          FormatY_Axis('Deaths') %>%
          layout(hovermode = 'x unified', legend = list(x = 1, y = .5))
      }
    )
    
    plot <- plot %>% SetTitle(first_line, second_line)
  })
  
  output$Text_Gender_Deaths <- renderText({
    
    paste(
      '<br><b>Note: Due to delays in reporting recent data are incomplete.',
      if (sum(gender_D$Count) < sum(deaths_D$Count)) { paste(' Missing data (n=', format(sum(deaths_D$Count) - sum(gender_D$Count), big.mark = ','), ').', sep = '') },
      '</b><br><br>', sep = ''
    )
  })
  
  # Race -----------------------------------------------------------------------
  output$Plotly_Race_Deaths <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(deaths_D$Count), sum(race_D$Count), titleStrings$race_D)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(race_D$Count), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue)
    
    # Create the chart based on user input
    switch (
      input$ID_Race_Deaths,
      'Bar Graph' = {
        data <- group_by(race_D, Race) %>% summarise(Count = sum(Count))
        data$Race[data$Race == 'Asian/Native Hawaiian/Other Pacific Islander'] = 'Asian/\nNative Hawaiian/\nOther Pacific Islander'
        data$Race[data$Race == 'Native American/Alaska Native'] = 'Native American/\nAlaska Native'
        
        plot <- MakePlotlyBar(data, data$Race, data$Count, colors) %>%
          FormatX_Axis('Race', 'total descending') %>%
          FormatY_Axis('Deaths')
      },
      'Line Graph' = {
        data <- race_D %>% pivot_wider(names_from = Race, values_from = Count) %>%
          rename(Asian = `Asian/Native Hawaiian/Other Pacific Islander`, Native = `Native American/Alaska Native`)
        
        first_line <- CheckTitleWhereKnown(sum(deaths_D$Count), sum(race_D$Count), titleStrings$raceD_D)
        
        names <- c('Asian/\nNative Hawaiian/\nOther Pacific Islander', 'Black', 'Native American/\nAlaska Native', 'Other', 'White')
        
        plot <- data %>%
          # Create the graph with just the x-axis, no data on the graph
          plot_ly(x = ~ Date, hovertemplate = paste('<b>%{y}</b>')) %>%
          add_trace(y = ~Asian,  legendgroup = names[1], name = names[1], type = 'scatter', mode = 'lines', line = list(color = colors[1]), hoverinfo = 'text', hovertext = paste('<b>', names[1], '</b>:', format(data$Asian, big.mark = ','))) %>%
          add_trace(y = ~Black,  legendgroup = names[2], name = names[2], type = 'scatter', mode = 'lines', line = list(color = colors[2]), hoverinfo = 'text', hovertext = paste('<b>', names[2], '</b>:', format(data$Black, big.mark = ','))) %>%
          add_trace(y = ~Native, legendgroup = names[3], name = names[3], type = 'scatter', mode = 'lines', line = list(color = colors[3]), hoverinfo = 'text', hovertext = paste('<b>', names[3], '</b>:', format(data$Native, big.mark = ','))) %>%
          add_trace(y = ~Other,  legendgroup = names[4], name = names[4], type = 'scatter', mode = 'lines', line = list(color = colors[4]), hoverinfo = 'text', hovertext = paste('<b>', names[4], '</b>:', format(data$Other, big.mark = ','))) %>%
          add_trace(y = ~White,  legendgroup = names[5], name = names[5], type = 'scatter', mode = 'lines', line = list(color = colors[5]), hoverinfo = 'text', hovertext = paste('<b>', names[5], '</b>:', format(data$White, big.mark = ',')))
        
        
        data$MaxDeaths <- pmax(data$White, data$Black, data$Native, data$Asian, data$Other)
        
        plot <- plot %>%
          FormatX_Axis('Received Date', 'trace') %>%
          FormatY_Axis('Deaths') %>%
          layout(hovermode = 'x unified', legend = list(x = 1, y = .5, title = list(text = '<b>Click to Add/Remove</b>')))
      }
    )
    
    plot <- plot %>%
      SetTitle(first_line, second_line) %>% 
      config(plot, displayModeBar = FALSE) %>%
      layout(margin = list(l = 10, r = 10, b = 10, t = 100, pad = 10))
  })
  
  output$Text_Race_Deaths <- renderText({
    percentages <- GetPercent(race_D, race_D$Race, race_D$Count, dataValidation$race)
    
    paste(
      '<br><b>Note: Due to delays in reporting recent data are incomplete. ',
      if (sum(race_D$Count) < sum(deaths_D$Count)) { paste(' Missing data (n=', format(sum(deaths_D$Count) - sum(race_D$Count), big.mark = ','), ').', sep = '') },
      'The percent per race is: White = ', percentages[1], '; Black = ', percentages[2], '; Native American/Alaska Native = ', percentages[3], '; Asian/Native Hawaiian/Other Pacific Islander = ', percentages[4], '; and Other = ', percentages[5], '.</b><br><br>',
      sep = ''
    )

  })
  
  # Ethnicity ------------------------------------------------------------------
  output$Plotly_Ethnicity_Deaths <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(deaths_D$Count), sum(ethnicity_D$Count), titleStrings$ethnicity_D)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(ethnicity_D$Count), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple)
    
    # Create the chart based on user input
    switch (
      input$ID_Ethnicity_Deaths,
      'Bar Graph' = {
        data <- group_by(ethnicity_D, Ethnicity) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyBar(data, data$Ethnicity, data$Count, colors) %>%
          FormatX_Axis('Ethnicity', 'category ascending') %>%
          FormatY_Axis('Deaths')
      },
      'Pie Chart' = {
        data <- group_by(ethnicity_D, Ethnicity) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyPie(data, data$Ethnicity, data$Count, 'Ethnicity', 'Deaths', colors) %>%
          layout(legend = list(x = .9, y = .5))
      },
      'Line Graph' = {
        data <- ethnicity_D %>% pivot_wider(names_from = Ethnicity, values_from = Count)
        
        first_line <- CheckTitleWhereKnown(sum(deaths_D$Count), sum(ethnicity_D$Count), titleStrings$ethnicityD_D)
        
        plot <- plot_ly(data, x = ~Date, hovertemplate = paste('<b>%{y}</b>'))
        
        # Add trace for male
        plot <- plot %>% add_trace(
          y = ~Hispanic,
          name = 'Hispanic',
          type = 'scatter',
          mode = 'lines',
          hoverinfo = 'text',
          line = list(color = colors[1]),
          hovertext = paste('<b>Hispanic</b>:', format(data$Hispanic, big.mark = ','))
        )
        
        # Add trace for female
        plot <- plot %>% add_trace(
          y = ~`Non-Hispanic`,
          name = 'Non-Hispanic',
          type = 'scatter',
          mode = 'lines',
          hoverinfo = 'text',
          line = list(color = colors[2]),
          hovertext = paste('<b>Non-Hispanic</b>:', format(data$`Non-Hispanic`, big.mark = ','))
        )
        
        data$MaxDeaths <- pmax(data$Hispanic, data$`Non-Hispanic`)
        
        plot <- plot %>%
          FormatX_Axis('Received Date', 'trace') %>%
          FormatY_Axis('Deaths') %>%
          layout(hovermode = 'x unified', legend = list(x = 1, y = .5))
      }
    )
    
    plot <- plot %>%
      SetTitle(first_line, second_line) %>% 
      config(plot, displayModeBar = FALSE) %>%
      layout(margin = list(l = 10, r = 10, b = 10, t = 100, pad = 10))
  })
  
  output$Text_Ethnicity_Deaths <- renderText({
    paste(
      '<br><b>Note: Due to delays in reporting recent data are incomplete. ',
      if (sum(ethnicity_D$Count) < sum(deaths_D$Count)) { paste(' Missing data (n=', format(sum(deaths_D$Count) - sum(ethnicity_D$Count), big.mark = ','), ').</b><br><br>', sep = '') },
      '</b><br><br>', sep = ''
    )
  })
  
  # Top Zip Codes --------------------------------------------------------------
  output$Plotly_Top_Zip_Codes_Deaths <- renderPlotly({
    req(input$ID_Top_Zip_Codes_Deaths)
    
    # Create the strings for the title
    data <- topZipCodes_D %>% slice_head(n = input$ID_Top_Zip_Codes_Deaths)
    
    first_line <- paste(titleStrings$topZip_D, ' (Top ', input$ID_Top_Zip_Codes_Deaths, ')', sep = '')
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(data$Count), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue, myColors$yellow, myColors$lblue, myColors$dgreen,
                myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue, myColors$yellow, myColors$lblue, myColors$dgreen,
                myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue, myColors$yellow, myColors$lblue, myColors$dgreen,
                myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue, myColors$yellow, myColors$lblue, myColors$dgreen)
    
    plot <- plot_ly(
      data,
      x = ~Zip.Code,
      y = ~Count,
      type = 'bar',
      text = ~format(Count, big.mark = ','),
      textposition = 'outside',
      textfont = list(color = '#000000'),
      marker = list(color = colors),
      showlegend = FALSE,
      hoverlabel = list(align = 'left', font = myFonts$tooltip),
      hovertemplate = paste(
        '<br><b>Zip Code</b>: %{x}',
        '<br><b>Town/City</b>:', data$Town.City,
        '<br><b>Deaths</b>: %{y:,}',
        '<extra></extra>'
      )
    )
    
    # Create the chart
    plot <- plot %>%
      SetTitle(first_line, second_line) %>% 
      FormatX_Axis(label = 'Zip Code', 'total descending') %>%
      FormatY_Axis('Deaths') %>%
      config(plot, displayModeBar = FALSE) %>%
      layout(margin = list(l = 10, r = 10, b = 10, t = 100, pad = 10))
  })
  
  output$Text_Top_Zip_Codes_Deaths <- renderText({
    paste(
      '<br><b>Note: Data are incomplete due to ongoing case investigation. ',
      str_to_title(as.english(input$ID_Top_Zip_Codes_Deaths)), ' most reported zip codes represented in graph (n=',
      format(sum(top_n(topZipCodes_D, input$ID_Top_Zip_Codes_Deaths, Count)$Count), big.mark = ','), ') representing ',
      sprintf('%0.1f%%', sum(top_n(topZipCodes_D, input$ID_Top_Zip_Codes_Deaths, Count)$Count) / sum(deaths_D$Count) * 100), ' of deaths.</b><br><br>',
      sep = ''
    )
  })
  
  # Zip Codes by Date ----------------------------------------------------------
  output$Plotly_Zip_Codes_Deaths <- renderPlotly({
    req(input$ID_Zip_Codes_Deaths)
    
    # Filter the data to the town/city selected by the user
    data <- filter(zip_daily_D, Town.City == input$ID_Zip_Codes_Deaths)
    data <- data[order(data$Date, decreasing = FALSE), ]
    
    # Create string for the title
    first_line <- 'Confirmed Deaths of COVID-19'
    second_line <- paste(input$ID_Zip_Codes_Deaths, ', NY - As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(data$Count), big.mark = ','), ')', sep = '')
    
    plot <- MakePlotlyLine(data, data$Date, data$Count, myColors$blue)
    
    # Create the chart
    plot <- plot %>%
      SetTitle(first_line, second_line) %>% 
      FormatX_Axis(label = 'Received Date', 'trace') %>%
      FormatY_Axis('Deaths') %>%
      config(plot, displayModeBar = FALSE) %>%
      layout(margin = list(l = 10, r = 10, b = 10, t = 100, pad = 10), hovermode = 'x')
  })
  
  output$Text_Zip_Codes_Deaths <- renderText({
    req(input$ID_Zip_Codes_Deaths)
    
    # Filter the data to the town/city selected by the user
    data <- filter(zip_daily_D, Town.City == input$ID_Zip_Codes_Deaths)
    
    paste(
      '<br><b>Note: This graph does not reflect the most recent deaths due to case investigation and data processing. 
      The data in the chart represents the deaths in ', input$ID_Zip_Codes_Deaths, ', NY (n=', format(sum(data$Count), big.mark = ','), ') as 
      of ', format(max(deaths_D$Date), '%B %d, %Y'), '. The reported deaths in ', input$ID_Zip_Codes_Deaths, ' represent ', 
      sprintf('%0.2f%%', sum(data$Count) / sum(deaths_D$Count) * 100), ' of all deaths reported.</b><br><br>', sep = '')
  })
  
  # Vaccination ----------------------------------------------------------------
  output$Plotly_Vaccination_Deaths <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(deaths_D$Count), sum(vaccination_D$Count), titleStrings$vaccination_D)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(vaccination_D$Count), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue)
    
    # Create the chart based on user input
    switch (
      input$ID_Vaccination_Deaths,
      'Bar Graph' = {
        data <- group_by(vaccination_D, Vaccinated) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyBar(data, data$Vaccinated, data$Count, colors) %>%
          FormatX_Axis('Age Group', 'total descending') %>%
          FormatY_Axis('Deaths')
      },
      'Pie Chart' = {
        data <- group_by(vaccination_D, Vaccinated) %>% summarise(Count = sum(Count))
        
        plot <- MakePlotlyPie(data, data$Vaccinated, data$Count, 'Age Group', 'Deaths', colors) %>%
          layout(legend = list(x = .9, y = .5))
      },
      'Line Graph' = {
        data <- vaccination_D %>% pivot_wider(names_from = Vaccinated, values_from = Count) %>%
          rename(Partial = Partially)
        
        first_line <- CheckTitleWhereKnown(sum(deaths_D$Count), sum(vaccination_D$Count), titleStrings$ageGroupD_D)
        
        plot <- plot_ly(data, x = ~Date, hovertemplate = paste('<b>%{y}</b>'))
        plot <- add_trace(plot, y = ~None, name = 'None',  type = 'scatter', mode = 'lines', line = list(color = colors[1]), hoverinfo = 'text', hovertext = paste('<b>None</b>:',  format(data$None, big.mark = ',')))
        plot <- add_trace(plot, y = ~Partial, name = 'Partial', type = 'scatter', mode = 'lines', line = list(color = colors[2]), hoverinfo = 'text', hovertext = paste('<b>Partial</b>:', format(data$Partial, big.mark = ',')))
        plot <- add_trace(plot, y = ~Fully, name = 'Fully', type = 'scatter', mode = 'lines', line = list(color = colors[3]), hoverinfo = 'text', hovertext = paste('<b>Fully</b>:', format(data$Fully, big.mark = ',')))
        plot <- add_trace(plot, y = ~Boosted, name = 'Boosted', type = 'scatter', mode = 'lines', line = list(color = colors[4]), hoverinfo = 'text', hovertext = paste('<b>Boosted</b>:', format(data$Boosted, big.mark = ',')))
        
        data$MaxDeaths <- pmax(data$None, data$Partial, data$Fully, data$Boosted)
        
        plot <- plot %>%
          FormatX_Axis('Received Date', 'trace') %>%
          FormatY_Axis('Deaths') %>%
          layout(hovermode = 'x unified', legend = list(x = 1, y = .5, title = list(text = '<b>Click to Add/Remove</b>')), yaxis = list(rangemode = 'tozero'))
      }
    )
    
    plot <- plot %>%
      SetTitle(first_line, second_line) %>% 
      config(plot, displayModeBar = FALSE) %>%
      layout(margin = list(l = 10, r = 10, b = 10, t = 100, pad = 10))
  })
  
  output$Text_Vaccination_Deaths <- renderText({
    percentages <- GetPercent(vaccination_D, vaccination_D$Vaccinated, vaccination_D$Count, dataValidation$vaccination)
    temp <- sum(filter(deaths_D, Date >= as.Date(as.character(20210101), format = '%Y%m%d'))[,2])
    
    paste('<br><b>Note: COVID-19 vaccines became available January 2021. ', format(sum(filter(deaths_D, Date >= as.Date(as.character(20210101), format = '%Y%m%d'))[,2]), big.mark = ','),
    ' (', sprintf('%0.1f%%', temp / sum(deaths_D$Count) * 100), ') of the total deaths occurred in 2021 - 2022. In order to determine vaccination status, medical records and the New York',
    ' State Immunization Information System are accessed. ', sum(vaccination_D$Count), ' (', sprintf('%0.1f%%', sum(vaccination_D$Count) / temp * 100), ') of the deaths that', 
    ' occurred in 2021 - 2022 have a known vaccination status and ', temp - sum(vaccination_D$Count), ' (', sprintf('%0.1f%%', (temp - sum(vaccination_D$Count)) / temp * 100),
    ') have an unknown vaccination status.</b><br><br>', sep = '')
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
