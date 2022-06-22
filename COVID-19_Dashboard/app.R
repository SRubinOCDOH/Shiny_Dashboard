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
        fluidRow(column(width = 12, selectInput('idCasesDateType', 'View', view_types, 'Daily'))),
        tags$script(src = 'DisableDateInputTyping.js'),
        # Cases
        fluidRow(column(width = 1, align = 'center', uiOutput('minDate_Cases'), uiOutput('maxDate_Cases')), column(width = 10, plotlyOutput('plotlyCases_C', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('textCases_C'))),
        tags$style(type='text/css', '#minDate_Cases { width:100%; margin-top: 150px;}'),
        tags$style(type='text/css', '#maxDate_Cases { width:100%; margin-bottom: 150px;}'),
        # Symptomatic Cases
        fluidRow(column(width = 1, align = 'center', uiOutput('minDate_Symp'), uiOutput('maxDate_Symp')), column(width = 10, plotlyOutput('plotlySymptomatic_C', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('textSymp_C'))),
        tags$style(type='text/css', '#minDate_Symp { width:100%; margin-top: 150px;}'),
        tags$style(type='text/css', '#maxDate_Symp { width:100%; margin-bottom: 150px;}'),
        # Asymptomatic Cases
        fluidRow(column(width = 1, align = 'center', uiOutput('minDate_Asymp'), uiOutput('maxDate_Asymp')), column(width = 10, plotlyOutput('plotlyAsymptomatic_C', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('textAsymp_C'))),
        tags$style(type='text/css', '#minDate_Asymp { width:100%; margin-top: 150px;}'),
        tags$style(type='text/css', '#maxDate_Asymp { width:100%; margin-bottom: 150px;}')
      ),
      # Demographics - Cases
      tabPanel(
        'Demographics',
        # Age Group - Cases
        fluidRow(column(width = 1, radioButtons('idAgeGroup_C', 'Chart Type', plot_types, 'Bar Graph')), column(width = 10, plotlyOutput('plotlyAgeGroup_C', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('textAgeGroup_C'))),
        # Gender - Cases
        fluidRow(column(width = 1, radioButtons('idGender_C', 'Chart Type', plot_types, 'Pie Chart')), column(width = 10, plotlyOutput('plotlyGender_C', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('textGender_C'))),
        # Race - Cases
        fluidRow(column(width = 1, radioButtons('idRace_C', 'Chart Type', plot_types, 'Bar Graph')), column(width = 10, plotlyOutput('plotlyRace_C', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('textRace_C'))),
        # Ethnicity - Cases
        fluidRow(column(width = 1, radioButtons('idEthnicity_C', 'Chart Type', plot_types, 'Pie Chart')), column(width = 10, plotlyOutput('plotlyEthnicity_C', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('textEthnicity_C')))
      ),
      # Municipalities - Cases
      tabPanel(
        'Municipalities',
        fluidRow(column(width = 12, sliderInput('idTopZipCodes_C', 'Towns to Display (5 to 20)', min = 5, max = 20, value = 10)), column(width = 10, offset = 1, plotlyOutput('plotlyTopZipCodes_C', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('textTipZipCodes_C'))),
        fluidRow(column(width = 12, selectInput('idZipCodes_C', 'Town to Display', sort(dataValidation$zipCodes$Town.City), 'Goshen')), column(width = 10, offset = 1, plotlyOutput('plotlyZipCodes_C', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('textZipCodes_C'))),
      ),
      # Vaccination - Cases
      tabPanel(
        'Vaccinations',
        fluidRow(column(width = 1, radioButtons('vaccination_C_ID', 'Chart Type', plot_types, 'Bar Graph')), column(width = 10, plotlyOutput('vaccination_C_Plotly', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('vaccination_C_Text')))
      )
    ),
    navbarMenu(
      'Confirmed and Probable Deaths',
      tabPanel(
        'Deaths',
        fluidRow(column(width = 1, align = 'center', uiOutput('minDate_Deaths'), uiOutput('maxDate_Deaths')), column(width = 10, plotlyOutput('plotlyDeaths_DC', height = '500px'))),
        fluidRow(column(width = 10, offset = 1, htmlOutput('textDeaths_D'))),
        tags$style(type='text/css', '#minDate_Deaths { width:100%; margin-top: 150px;}'),
        tags$style(type='text/css', '#maxDate_Deaths { width:100%; margin-bottom: 150px;}')
      )
    )
  )
}

server <- function(input, output, session) {
  observeEvent(input$idNavbarPage, updateNavbarPage(session, 'idCasesDateType', 'Daily'))
  
  # Cases ----------------------------------------------------------------------
  observeEvent(input$idCasesDateType, {
    
    cat('View Selection changed!\n')
    
    switch(
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateData(cases_C, 'day')
        cat('Selected Daily\n')
        updateDateInput(session, 'minDate_Cases', max = max(data$Date) - 6)
        updateDateInput(session, 'minDate_Cases', value = min(data$Date))
        updateDateInput(session, 'maxDate_Cases', min = min(data$Date) + 6)
        updateDateInput(session, 'maxDate_Cases', value = max(data$Date))
      },
      'Weekly' = {
        data <- GetDateData(cases_C, 'week')
        cat('Selected Weekly\n')
        updateDateInput(session, 'minDate_Cases', max = max(data$Date) - 34)
        updateDateInput(session, 'minDate_Cases', value = min(data$Date))
        updateDateInput(session, 'maxDate_Cases', min = min(data$Date) + 34)
        updateDateInput(session, 'maxDate_Cases', value = max(data$Date))
      },
      'Monthly' = {
        data <- GetDateData(cases_C, 'month')
        cat('Selected Monthly\n')
        updateDateInput(session, 'minDate_Cases', max = max(data$Date) %m-% months(5))
        updateDateInput(session, 'minDate_Cases', value = min(data$Date))
        updateDateInput(session, 'maxDate_Cases', min = min(data$Date) %m+% months(5))
        updateDateInput(session, 'maxDate_Cases', value = max(data$Date))
      },
      'Yearly' = {
        updateDateInput(session, 'minDate_Cases', value = min(cases_C$Date))
        updateDateInput(session, 'maxDate_Cases', value = max(cases_C$Date))
        
        # Disable the input - user cannot select input for the year view
        shinyjs::disable('maxDate_Cases')
      }
    )
    cat('Min date - ', format(input$minDate_Cases, '%B %d, %Y'), '\n')
    cat('Max date - ', format(input$maxDate_Cases, '%B %d, %Y'), '\n\n')
  })
  
  observeEvent(input$minDate_Cases, {
    switch(
      input$idCasesDateType,
      'Daily' = updateDateInput(session, 'maxDate_Cases', min = input$minDate_Cases + 6),
      'Weekly' = updateDateInput(session, 'maxDate_Cases', min = input$minDate_Cases + 34),
      'Monthly' = updateDateInput(session, 'maxDate_Cases', min = input$minDate_Cases %m+% months(5))
    )
  })
  observeEvent(input$maxDate_Cases, {
    switch(
      input$idCasesDateType,
      'Daily' = updateDateInput(session, 'minDate_Cases', max = input$maxDate_Cases - 6),
      'Weekly' = updateDateInput(session, 'minDate_Cases', max = input$maxDate_Cases - 34),
      'Monthly' = updateDateInput(session, 'minDate_Cases', max = input$maxDate_Cases %m-% months(5))
    )
  })

  # Update the start date input based on the selected view
  output$minDate_Cases <- renderUI({
    req(input$idCasesDateType)
    
    cat('renderUI - minDate\n')
    
    switch (
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateData(cases_C, 'day')
        dateInput('minDate_Cases', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month')
      },
      'Weekly' = {
        data <- GetDateData(cases_C, 'week')
        dateInput('minDate_Cases', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(cases_C, 'month')
        min_date <- as.Date(min(floor_date(data$Date, 'month')))
        max_date <- as.Date(max(ceiling_date(data$Date, 'month'))) - 1
        CustomDateInput('minDate_Cases', 'Start Date', startview = 'year', minview = 'months', maxview = 'decades', value = min_date, min = min_date, max = max_date, format = 'M, yyyy')
      },
      'Yearly' = {
        shinyjs::disable('minDate_Cases')
      }
    )
  })
  # Update the end date input based on the selected view
  output$maxDate_Cases <- renderUI({
    req(input$idCasesDateType)
    
    cat('renderUI - maxDate\n')
    
    switch (
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateData(cases_C, 'day')
        dateInput('maxDate_Cases', 'End Date', max(data$Date), min(data$Date), max(data$Date), 'mm/dd/yyyy', 'month')
      },
      'Weekly' = {
        data <- GetDateData(cases_C, 'week')
        dateInput('maxDate_Cases', 'End Date', max(data$Date), min(data$Date), max(data$Date), 'mm/dd/yyyy', 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(cases_C, 'month')
        min_date <- as.Date(min(floor_date(data$Date, 'month')))
        max_date <- as.Date(max(ceiling_date(data$Date, 'month'))) - 1
        CustomDateInput('maxDate_Cases', 'End Date', minview = 'year', 'decades', max_date, min_date, max_date, 'M, yyyy', 'year')
      },
      'Yearly' = {
        shinyjs::disable('maxDate_Cases')
      }
    )
  })
  
  # Render the plot for the data using the selected inputs
  output$plotlyCases_C <- renderPlotly({
    req(input$minDate_Cases, input$maxDate_Cases, input$idCasesDateType)
    
    cat('Render plotly\n')
    cat('Min date - ', format(input$minDate_Cases, '%B %d, %Y'), '\n')
    cat('Max date - ', format(input$maxDate_Cases, '%B %d, %Y'), '\n\n')
    
    # Switch to determine view for graph
    switch(
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateLimitedData(cases_C, input$minDate_Cases, input$maxDate_Cases, 'day')
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Cases)
        
        plot <- data %>%
          MakePlotlyLine(data$Date, data$Cases, myColors$green) %>%
          SetTitle(titleStrings$casesD_C, second_line) %>%
          FormatX_Axis('Received Date') %>%
          layout(hovermode = 'x')
      },
      'Weekly' = {
        data <- GetDateLimitedData(cases_C, input$minDate_Cases, input$maxDate_Cases, 'week')
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Cases)
        
        plot <- data %>%
          MakePlotlyLine(data$Date, data$Cases, myColors$green) %>%
          SetTitle(titleStrings$casesW_C, second_line) %>%
          FormatX_Axis('Received Week') %>%
          layout(hovermode = 'x')
      },
      'Monthly' = {
        data <- GetDateLimitedData(cases_C, input$minDate_Cases, input$maxDate_Cases, 'month')
        
        second_line <- MakeTitleSecondLine(data$Date, '%B, %Y', data$Cases)
        
        # Create the plot
        plot <- MakePlotlyBar(data, data$Date, data$Cases, myColors$green) %>%
          SetTitle(titleStrings$casesM_C, second_line) %>%
          FormatX_Axis('Received Month') %>%
          layout(xaxis = list(range = c(min(data$Date) - 20, max(data$Date) + 20), hoverformat = '%B, %Y', dtick = 'M1', tickformat = '%b\n%Y'))
      },
      'Yearly' = {
        data <- GetDateData(cases_C, 'year')
        
        second_line <- MakeTitleSecondLine(data$Date, '%Y', data$Cases)
        
        # Create the plot
        plot <- MakePlotlyBar(data, data$Date, data$Cases, myColors$green) %>%
          SetTitle(titleStrings$casesY_C, second_line) %>%
          FormatX_Axis('Received Year') %>%
          layout(xaxis = list(hoverformat = '%Y', dtick = 'M12', tickformat = '%Y'))
      }
    )
    plot <- plot %>% FormatY_Axis('Cases')
  })
  
  # Render the footnote text for the plot
  output$textCases_C <- renderText({
    req(input$idCasesDateType, input$minDate_Cases, input$maxDate_Cases)
    
    switch (
      input$idCasesDateType,
      'Daily'   = {
        data <- GetDateLimitedData(cases_C, input$minDate_Cases, input$maxDate_Cases, 'day')
        min_date <- format(min(floor_date(data$Date, 'day')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'day')) - 1, '%B %d, %Y')
      },
      'Weekly'  = {
        data <- GetDateLimitedData(cases_C, input$minDate_Cases, input$maxDate_Cases, 'week')
        min_date <- format(min(floor_date(data$Date, 'week')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'week')) - 7, '%B %d, %Y')
      },
      'Monthly' = {
        data <- GetDateLimitedData(cases_C, input$minDate_Cases, input$maxDate_Cases, 'month')
        min_date <- format(min(floor_date(data$Date, 'month')), '%B, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'month')) - 1, '%B, %Y')
      },
      'Yearly'  = {
        data <- GetDateLimitedData(cases_C, input$minDate_Cases, input$maxDate_Cases, 'year')
        min_date <- format(min(floor_date(data$Date, 'year')), '%Y')
        max_date <- format(max(ceiling_date(data$Date, 'year')) - 1, '%Y')
      }
    )
    
    paste('<br><b>Note: The dates in 2020 of April 24th, April 29th, December 17th, and in 2021 of March 17th and December 29th were dates when laboratories uploaded backlogged data. Total cases represented in the graph between ', min_date, ' and ', max_date, ' (n=', format(sum(data$Cases), big.mark = ','), '). Total confirmed cases of COVID-19 reported as of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(cases_C$Cases), big.mark = ','), ')', '.</b><br><br>', sep = '')
  })
  
  # Symptomatic Cases ----------------------------------------------------------
  # Change the minimum date of maxDate so maxDate cannot be less than minDate
  observeEvent(input$minDate_Symp, {
    switch(
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateLimitedData(symptomatic_C, input$minDate_Symp, input$maxDate_Symp, 'day')
        updateDateInput(session, 'maxDate_Symp', min = input$minDate_Symp + 6)
      },
      'Weekly' = {
        data <- GetDateLimitedData(symptomatic_C, input$minDate_Symp, input$maxDate_Symp, 'week')
        updateDateInput(session, 'maxDate_Symp', min = input$minDate_Symp + 34)
      },
      'Monthly' = {
        data <- GetDateLimitedData(symptomatic_C, input$minDate_Symp, input$maxDate_Symp, 'month')
        updateDateInput(session, 'maxDate_Symp', min = input$minDate_Symp %m+% months(5))
      },
      'Yearly' = {
        updateDateInput(session, 'maxDate_Symp', value = max(symptomatic_C$Date))
        shinyjs::disable('maxDate_Symp')
      }
    )
  })
  # Change the maximum date of minDate so minDate cannot be greater than maxDate
  observeEvent(input$maxDate_Symp, {
    switch(
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateLimitedData(symptomatic_C, input$maxDate_Symp, input$minDate_Symp, 'day')
        updateDateInput(session, 'minDate_Symp', max = input$maxDate_Symp - 6)
      },
      'Weekly' = {
        data <- GetDateLimitedData(symptomatic_C, input$maxDate_Symp, input$minDate_Symp, 'week')
        updateDateInput(session, 'minDate_Symp', max = input$maxDate_Symp - 34)
      },
      'Monthly' = {
        data <- GetDateLimitedData(symptomatic_C, input$maxDate_Symp, input$minDate_Symp, 'month')
        updateDateInput(session, 'minDate_Symp', max = input$maxDate_Symp %m-% months(5))
      },
      'Yearly' = {
        updateDateInput(session, 'minDate_Symp', value = min(symptomatic_C$Date))
        shinyjs::disable('maxDate_Symp')
      }
    )
  })
  
  # Update the start date input based on the selected view
  output$minDate_Symp <- renderUI({
    req(input$idCasesDateType)
    
    switch (
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateData(symptomatic_C, 'day')
        dateInput('minDate_Symp', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month')
      },
      'Weekly' = {
        data <- GetDateData(symptomatic_C, 'week')
        dateInput('minDate_Symp', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(symptomatic_C, 'month')
        min_date <- as.Date(min(floor_date(data$Date, 'month')))
        max_date <- as.Date(max(ceiling_date(data$Date, 'month'))) - 1
        CustomDateInput('minDate_Symp', 'Start Date', minview = 'year', 'decades', min_date, min_date, max_date, 'M, yyyy', 'year')
      },
      'Yearly' = {
        shinyjs::disable('minDate_Symp')
      }
    )
  })
  # Update the end date input based on the selected view
  output$maxDate_Symp <- renderUI({
    req(input$idCasesDateType)
    
    switch (
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateData(symptomatic_C, 'day')
        dateInput('maxDate_Symp', 'End Date', max(data$Date), min(data$Date), max(data$Date), 'mm/dd/yyyy', 'month')
      },
      'Weekly' = {
        data <- GetDateData(symptomatic_C, 'week')
        dateInput('maxDate_Symp', 'End Date', max(data$Date), min(data$Date), max(data$Date), 'mm/dd/yyyy', 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(symptomatic_C, 'month')
        min_date <- as.Date(min(floor_date(data$Date, 'month')))
        max_date <- as.Date(max(ceiling_date(data$Date, 'month'))) - 1
        CustomDateInput('maxDate_Symp', 'End Date', minview = 'year', 'decades', max_date, min_date, max_date, 'M, yyyy', 'year')
      },
      'Yearly' = {
        shinyjs::disable('maxDate_Symp')
      }
    )
  })
  
  # Render the plot for the data using the selected inputs
  output$plotlySymptomatic_C <- renderPlotly({
    req(input$minDate_Symp, input$maxDate_Symp, input$idCasesDateType)
    
    # Switch to determine view for graph
    switch(
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateLimitedData(symptomatic_C, input$minDate_Symp, input$maxDate_Symp, 'day')
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Cases)
        
        plot <- data %>%
          MakePlotlyLine(data$Date, data$Cases, myColors$green) %>%
          SetTitle(titleStrings$sympD_C, second_line) %>%
          FormatX_Axis('Date of Symptom Onset') %>%
          layout(hovermode = 'x')
      },
      'Weekly' = {
        data <- GetDateLimitedData(symptomatic_C, input$minDate_Symp, input$maxDate_Symp, 'week')
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Cases)
        
        plot <- data %>%
          MakePlotlyLine(data$Date, data$Cases, myColors$green) %>%
          SetTitle(titleStrings$sympW_C, second_line) %>%
          FormatX_Axis('Week of Symptom Onset') %>%
          layout(hovermode = 'x')
      },
      'Monthly' = {
        data <- GetDateLimitedData(symptomatic_C, input$minDate_Symp, input$maxDate_Symp, 'month')
        
        second_line <- MakeTitleSecondLine(data$Date, '%B, %Y', data$Cases)
        
        # Create the plot
        plot <- MakePlotlyBar(data, data$Date, data$Cases, myColors$green) %>%
          SetTitle(titleStrings$sympM_C, second_line) %>%
          FormatX_Axis('Month of Symptom Onset') %>%
          layout(xaxis = list(range = c(min(data$Date) - 20, max(data$Date) + 20), hoverformat = '%B, %Y', dtick = 'M1', tickformat = '%b\n%Y'))
      },
      'Yearly' = {
        data <- GetDateData(symptomatic_C, 'year')
        
        second_line <- MakeTitleSecondLine(data$Date, '%Y', data$Cases)
        
        # Create the plot
        plot <- MakePlotlyBar(data, data$Date, data$Cases, myColors$green) %>%
          SetTitle(titleStrings$sympY_C, second_line) %>%
          FormatX_Axis('Year of Symptom Onset') %>%
          layout(xaxis = list(hoverformat = '%Y', dtick = 'M12', tickformat = '%Y'))
      }
    )
    plot <- plot %>% FormatY_Axis('Cases')
  })
  
  # Render the footnote text for the plot
  output$textSymp_C <- renderText({
    req(input$minDate_Symp, input$maxDate_Symp, input$idCasesDateType)
    
    switch (
      input$idCasesDateType,
      'Daily'   = {
        data <- GetDateLimitedData(symptomatic_C, input$minDate_Symp, input$maxDate_Symp, 'day')
        min_date <- format(min(floor_date(data$Date, 'day')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'day')) - 1, '%B %d, %Y')
      },
      'Weekly'  = {
        data <- GetDateLimitedData(symptomatic_C, input$minDate_Symp, input$maxDate_Symp, 'week')
        min_date <- format(min(floor_date(data$Date, 'week')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'week')) - 7, '%B %d, %Y')
      },
      'Monthly' = {
        data <- GetDateLimitedData(symptomatic_C, input$minDate_Symp, input$maxDate_Symp, 'month')
        min_date <- format(min(floor_date(data$Date, 'month')), '%B, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'month')) - 1, '%B, %Y')
      },
      'Yearly'  = {
        data <- GetDateLimitedData(symptomatic_C, input$minDate_Symp, input$maxDate_Symp, 'year')
        min_date <- format(min(floor_date(data$Date, 'year')), '%Y')
        max_date <- format(max(ceiling_date(data$Date, 'year')) - 1, '%Y')
      }
    )
    
    paste('<br><b>Note: This graph does not reflect the most recent cases due to case investigation and data processing. Individuals who were asymptomatic (', format(sum(asymptomatic_C$Cases), big.mark = ','), '), in data processing, were lost to follow up and/or had an unknown date of first symptom (', format(sum(cases_C$Cases) - (sum(asymptomatic_C$Cases) + sum(symptomatic_C$Cases)), big.mark = ','),') were excluded from analysis. Cases represented in graph between ', min_date, ' and ', max_date, ' (n=', format(sum(data$Cases), big.mark = ','), '). Symptomatic cases reported and processed as of ', format(max(cases_C$Date), '%B %d, %Y'),' (n=', format(sum(symptomatic_C$Cases), big.mark = ','), ')', '.</b><br><br>', sep = '')
  })
  
  # Asymptomatic Cases ---------------------------------------------------------
  # Change the minimum date of maxDate so maxDate cannot be less than minDate
  observeEvent(input$minDate_Asymp, {
    switch(
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateLimitedData(asymptomatic_C, input$minDate_Asymp, input$maxDate_Asymp, 'day')
        updateDateInput(session, 'maxDate_Asymp', min = input$minDate_Asymp + 6)
      },
      'Weekly' = {
        data <- GetDateLimitedData(asymptomatic_C, input$minDate_Asymp, input$maxDate_Asymp, 'week')
        updateDateInput(session, 'maxDate_Asymp', min = input$minDate_Asymp + 34)
      },
      'Monthly' = {
        data <- GetDateLimitedData(asymptomatic_C, input$minDate_Asymp, input$maxDate_Asymp, 'month')
        updateDateInput(session, 'maxDate_Asymp', min = input$minDate_Asymp %m+% months(5))
      },
      'Yearly' = {
        updateDateInput(session, 'maxDate_Asymp', value = max(asymptomatic_C$Date))
        shinyjs::disable('maxDate_Asymp')
      }
    )
  })
  # Change the maximum date of minDate so minDate cannot be greater than maxDate
  observeEvent(input$maxDate_Asymp, {
    switch(
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateLimitedData(asymptomatic_C, input$maxDate_Asymp, input$minDate_Asymp, 'day')
        updateDateInput(session, 'minDate_Asymp', max = input$maxDate_Asymp - 6)
      },
      'Weekly' = {
        data <- GetDateLimitedData(asymptomatic_C, input$maxDate_Asymp, input$minDate_Asymp, 'week')
        updateDateInput(session, 'minDate_Asymp', max = input$maxDate_Asymp - 34)
      },
      'Monthly' = {
        data <- GetDateLimitedData(asymptomatic_C, input$maxDate_Asymp, input$minDate_Asymp, 'month')
        updateDateInput(session, 'minDate_Asymp', max = input$maxDate_Asymp %m-% months(5))
      },
      'Yearly' = {
        updateDateInput(session, 'minDate_Asymp', value = min(asymptomatic_C$Date))
        shinyjs::disable('maxDate_Asymp')
      }
    )
  })
  
  # Update the start date input based on the selected view
  output$minDate_Asymp <- renderUI({
    req(input$idCasesDateType)
    
    switch (
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateData(asymptomatic_C, 'day')
        dateInput('minDate_Asymp', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month')
      },
      'Weekly' = {
        data <- GetDateData(asymptomatic_C, 'week')
        dateInput('minDate_Asymp', 'Start Date', value = min(data$Date), min = min(data$Date), max = max(data$Date), format = 'mm/dd/yyyy', startview = 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(asymptomatic_C, 'month')
        min_date <- as.Date(min(floor_date(data$Date, 'month')))
        max_date <- as.Date(max(ceiling_date(data$Date, 'month'))) - 1
        CustomDateInput('minDate_Asymp', 'Start Date', minview = 'year', 'decades', min_date, min_date, max_date, 'M, yyyy', 'year')
      },
      'Yearly' = {
        shinyjs::disable('minDate_Asymp')
      }
    )
  })
  # Update the end date input based on the selected view
  output$maxDate_Asymp <- renderUI({
    req(input$idCasesDateType)
    
    switch (
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateData(asymptomatic_C, 'day')
        dateInput('maxDate_Asymp', 'End Date', max(data$Date), min(data$Date), max(data$Date), 'mm/dd/yyyy', 'month')
      },
      'Weekly' = {
        data <- GetDateData(asymptomatic_C, 'week')
        dateInput('maxDate_Asymp', 'End Date', max(data$Date), min(data$Date), max(data$Date), 'mm/dd/yyyy', 'month', daysofweekdisabled = c(1, 2, 3, 4, 5, 6))
      },
      'Monthly' = {
        data <- GetDateData(asymptomatic_C, 'month')
        min_date <- as.Date(min(floor_date(data$Date, 'month')))
        max_date <- as.Date(max(ceiling_date(data$Date, 'month'))) - 1
        CustomDateInput('maxDate_Asymp', 'End Date', minview = 'year', 'decades', max_date, min_date, max_date, 'M, yyyy', 'year')
      },
      'Yearly' = {
        shinyjs::disable('maxDate_Asymp')
      }
    )
  })
  
  # Render the plot for the data using the selected inputs
  output$plotlyAsymptomatic_C <- renderPlotly({
    req(input$minDate_Asymp, input$maxDate_Asymp, input$idCasesDateType)
    
    # Switch to determine view for graph
    switch(
      input$idCasesDateType,
      'Daily' = {
        data <- GetDateLimitedData(asymptomatic_C, input$minDate_Asymp, input$maxDate_Asymp, 'day')
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Cases)
        
        plot <- data %>%
          MakePlotlyLine(data$Date, data$Cases, myColors$green) %>%
          SetTitle(titleStrings$asympD_C, second_line) %>%
          FormatX_Axis('Received Date') %>%
          layout(hovermode = 'x')
      },
      'Weekly' = {
        data <- GetDateLimitedData(asymptomatic_C, input$minDate_Asymp, input$maxDate_Asymp, 'week')
        second_line <- MakeTitleSecondLine(data$Date, '%B %d, %Y', data$Cases)
        
        plot <- data %>%
          MakePlotlyLine(data$Date, data$Cases, myColors$green) %>%
          SetTitle(titleStrings$asympW_C, second_line) %>%
          FormatX_Axis('Received Week') %>%
          layout(hovermode = 'x')
      },
      'Monthly' = {
        data <- GetDateLimitedData(asymptomatic_C, input$minDate_Asymp, input$maxDate_Asymp, 'month')
        
        second_line <- MakeTitleSecondLine(data$Date, '%B, %Y', data$Cases)
        
        # Create the plot
        plot <- MakePlotlyBar(data, data$Date, data$Cases, myColors$green) %>%
          SetTitle(titleStrings$asympM_C, second_line) %>%
          FormatX_Axis('Received Month') %>%
          layout(xaxis = list(range = c(min(data$Date) - 20, max(data$Date) + 20), hoverformat = '%B, %Y', dtick = 'M1', tickformat = '%b\n%Y'))
      },
      'Yearly' = {
        data <- GetDateData(asymptomatic_C, 'year')
        
        second_line <- MakeTitleSecondLine(data$Date, '%Y', data$Cases)
        
        # Create the plot
        plot <- MakePlotlyBar(data, data$Date, data$Cases, myColors$green) %>%
          SetTitle(titleStrings$asympY_C, second_line) %>%
          FormatX_Axis('Received Year') %>%
          layout(xaxis = list(hoverformat = '%Y', dtick = 'M12', tickformat = '%Y'))
      }
    )
    plot <- plot %>% FormatY_Axis('Cases')
  })
  
  # Render the footnote text for the plot
  output$textAsymp_C <- renderText({
    req(input$minDate_Asymp, input$maxDate_Asymp, input$idCasesDateType)
    
    switch (
      input$idCasesDateType,
      'Daily'   = {
        data <- GetDateLimitedData(asymptomatic_C, input$minDate_Asymp, input$maxDate_Asymp, 'day')
        min_date <- format(min(floor_date(data$Date, 'day')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'day')) - 1, '%B %d, %Y')
      },
      'Weekly'  = {
        data <- GetDateLimitedData(asymptomatic_C, input$minDate_Asymp, input$maxDate_Asymp, 'week')
        min_date <- format(min(floor_date(data$Date, 'week')), '%B %d, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'week')) - 7, '%B %d, %Y')
      },
      'Monthly' = {
        data <- GetDateLimitedData(asymptomatic_C, input$minDate_Asymp, input$maxDate_Asymp, 'month')
        min_date <- format(min(floor_date(data$Date, 'month')), '%B, %Y')
        max_date <- format(max(ceiling_date(data$Date, 'month')) - 1, '%B, %Y')
      },
      'Yearly'  = {
        data <- GetDateLimitedData(asymptomatic_C, input$minDate_Asymp, input$maxDate_Asymp, 'year')
        min_date <- format(min(floor_date(data$Date, 'year')), '%Y')
        max_date <- format(max(ceiling_date(data$Date, 'year')) - 1, '%Y')
      }
    )
    
    paste('<br><b>Note: This graph does not reflect the most recent cases due to case investigation and data processing. Asymptomatic cases reported and processed represented in graph between ', min_date, ' and ', max_date, ' (n=', format(sum(data$Cases), big.mark = ','), '). Asymptomatic cases reported and processed as of ', format(max(cases_C$Date), '%B %d, %Y'),' (n=', format(sum(asymptomatic_C$Cases), big.mark = ','), ')', '.</b><br><br>', sep = '')
  })
  
  # Age Group ------------------------------------------------------------------
  output$plotlyAgeGroup_C <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(cases_C$Cases), sum(ageGroup_C$Cases), titleStrings$ageGroup_C)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(ageGroup_C$Cases), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue)
    
    # Create the chart based on user input
    switch (input$idAgeGroup_C,
      'Bar Graph' = {
        data <- group_by(ageGroup_C, Age.Group) %>% summarise(Cases = sum(Cases))
        
        plot <- MakePlotlyBar(data, data$Age.Group, data$Cases, colors) %>%
          FormatX_Axis('Age Group', 'category ascending') %>%
          FormatY_Axis('Cases')
      },
      'Pie Chart' = {
        data <- group_by(ageGroup_C, Age.Group) %>% summarise(Cases = sum(Cases))
        
        plot <- MakePlotlyPie(data, data$Age.Group, data$Cases, 'Age Group', 'Cases', colors) %>%
          layout(legend = list(x = .9, y = .5))
      },
      'Line Graph' = {
        data <- ageGroup_C %>% pivot_wider(names_from = Age.Group, values_from = Cases)
        
        first_line <- CheckTitleWhereKnown(sum(cases_C$Cases), sum(ageGroup_C$Cases), titleStrings$ageGroupD_C)

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
  
  output$textAgeGroup_C <- renderText({
    percentages <- GetPercent(ageGroup_C, ageGroup_C$Age.Group, ageGroup_C$Cases, dataValidation$ageGroup)
    
    paste('<br><b>Note: Ages were calculated using laboratory reported or case reported date of birth. Missing data (n=', format(sum(cases_C$Cases) - sum(ageGroup_C$Cases), big.mark = ','), '). The percent per age group is: 0-17 = ', percentages[1], '; 18-44 = ', percentages[2], '; 45-64 = ', percentages[3], '; 65-74 = ', percentages[4], '; and 75+ = ', percentages[5], '.</b><br><br>', sep = '')
  })
  
  # Gender ---------------------------------------------------------------------
  output$plotlyGender_C <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(cases_C$Cases), sum(gender_C$Cases), titleStrings$gender_C)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(gender_C$Cases), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$red, myColors$blue)
    
    # Create the chart based on user input
    switch (
      input$idGender_C,
      'Bar Graph' = {
        data <- group_by(gender_C, Gender) %>% summarise(Cases = sum(Cases))
        
        plot <- MakePlotlyBar(data, data$Gender, data$Cases, colors) %>%
          FormatX_Axis('Gender', 'category ascending') %>%
          FormatY_Axis('Cases')
      },
      'Pie Chart' = {
        data <- group_by(gender_C, Gender) %>% summarise(Cases = sum(Cases))
        
        plot <- MakePlotlyPie(data, data$Gender, data$Cases, 'Gender', 'Cases', colors) %>%
          layout(legend = list(x = .9, y = .5))
      },
      'Line Graph' = {
        data <- gender_C %>% pivot_wider(names_from = Gender, values_from = Cases)
        
        first_line <- CheckTitleWhereKnown(sum(cases_C$Cases), sum(gender_C$Cases), titleStrings$genderD_C)
        
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
  
  output$textGender_C <- renderText({
    paste('<br><b>Note: Gender is self-reported field. Missing or Unknown when laboratory reporting did not provide this information and case has not been reached yet (n=', format(sum(cases_C$Cases) - sum(gender_C$Cases), big.mark = ','), ').</b><br><br>', sep = '')
  })
  
  # Race -----------------------------------------------------------------------
  output$plotlyRace_C <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(cases_C$Cases), sum(race_C$Cases), titleStrings$race_C)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(race_C$Cases), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue)
    
    # Create the chart based on user input
    switch (
      input$idRace_C,
      'Bar Graph' = {
        data <- group_by(race_C, Race) %>% summarise(Cases = sum(Cases))
        data$Race[data$Race == 'Asian/Native Hawaiian/Other Pacific Islander'] = 'Asian/\nNative Hawaiian/\nOther Pacific Islander'
        data$Race[data$Race == 'Native American/Alaska Native'] = 'Native American/\nAlaska Native'
        
        plot <- MakePlotlyBar(data, data$Race, data$Cases, colors) %>%
          FormatX_Axis('Race', 'total descending') %>%
          FormatY_Axis('Cases')
      },
      'Pie Chart' = {
        data <- group_by(race_C, Race) %>% summarise(Cases = sum(Cases))
        data$Race[data$Race == 'Asian/Native Hawaiian/Other Pacific Islander'] = 'Asian/\nNative Hawaiian/\nOther Pacific Islander'
        data$Race[data$Race == 'Native American/Alaska Native'] = 'Native American/\nAlaska Native'
        
        plot <- MakePlotlyPie(data, data$Race, data$Cases, 'Race', 'Cases', colors) %>%
          layout(legend = list(x = .9, y = .5))
      },
      'Line Graph' = {
        data <- race_C %>% pivot_wider(names_from = Race, values_from = Cases) %>%
          rename(Asian = `Asian/Native Hawaiian/Other Pacific Islander`, Native = `Native American/Alaska Native`)
        
        first_line <- CheckTitleWhereKnown(sum(cases_C$Cases), sum(race_C$Cases), titleStrings$raceD_C)
        
        names <- c('Asian/\nNative Hawaiian/\nOther Pacific Islander', 'Black', 'Native American/\nAlaska Native', 'Other', 'White')
        
        plot <- data %>%
          # Create the graph with just the x-axis, no data on the graph
          plot_ly(x = ~ Date, hovertemplate = paste('<b>%{y}</b>')) %>%
          # Add trace for Asian
          add_trace(
            y = ~Asian, legendgroup = names[1], name = names[1],
            type = 'scatter', mode = 'lines', line = list(color = colors[1]), hoverinfo = 'text',
            hovertext = paste('<b>', names[1], '</b>:', format(data$Asian, big.mark = ','))) %>%
          # Add trace for Black
          add_trace(
            y = ~Black, legendgroup = names[2], name = names[2],
            type = 'scatter', mode = 'lines', line = list(color = colors[2]), hoverinfo = 'text',
            hovertext = paste('<b>', names[2], '</b>:', format(data$Black, big.mark = ','))) %>%
          # Add trace for Native
          add_trace(
            y = ~Native, legendgroup = names[3], name = names[3],
            type = 'scatter', mode = 'lines', line = list(color = colors[3]), hoverinfo = 'text',
            hovertext = paste('<b>', names[3], '</b>:', format(data$Native, big.mark = ','))) %>%
          # Add trace for Other
          add_trace(
            y = ~Other, legendgroup = names[4], name = names[4],
            type = 'scatter', mode = 'lines', line = list(color = colors[4]), hoverinfo = 'text',
            hovertext = paste('<b>', names[4], '</b>:', format(data$Other, big.mark = ','))) %>%
          # Add trace for White
          add_trace(
            y = ~White, legendgroup = names[5], name = names[5],
            type = 'scatter', mode = 'lines', line = list(color = colors[5]), hoverinfo = 'text',
            hovertext = paste('<b>', names[5], '</b>:', format(data$White, big.mark = ',')))
        
        
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
  
  output$textRace_C <- renderText({
    percentages <- GetPercent(race_C, race_C$Race, race_C$Cases, dataValidation$race)
    
    paste('<br><b>Note: Race is largely self-reported data and are identified through case investigation. Data are incomplete due to delays in reporting, data entry, unknown or undetermined risk factors and persons lost to follow up (n=', format(sum(cases_C$Cases) - sum(race_C$Cases), big.mark = ','), '). The percent per race is: White = ', percentages[1], '; Black = ', percentages[2], '; Native American/Alaska Native = ', percentages[3], '; Asian/Native Hawaiian/Other Pacific Islander = ', percentages[4], '; and Other = ', percentages[5], '.</b><br><br>', sep = '')
  })
  
  # Ethnicity ------------------------------------------------------------------
  output$plotlyEthnicity_C <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(cases_C$Cases), sum(ethnicity_C$Cases), titleStrings$ethnicity_C)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(ethnicity_C$Cases), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple)
    
    # Create the chart based on user input
    switch (
      input$idEthnicity_C,
      'Bar Graph' = {
        data <- group_by(ethnicity_C, Ethnicity) %>% summarise(Cases = sum(Cases))
        
        plot <- MakePlotlyBar(data, data$Ethnicity, data$Cases, colors) %>%
          FormatX_Axis('Ethnicity', 'category ascending') %>%
          FormatY_Axis('Cases')
      },
      'Pie Chart' = {
        data <- group_by(ethnicity_C, Ethnicity) %>% summarise(Cases = sum(Cases))
        
        plot <- MakePlotlyPie(data, data$Ethnicity, data$Cases, 'Ethnicity', 'Cases', colors) %>%
          layout(legend = list(x = .9, y = .5))
      },
      'Line Graph' = {
        data <- ethnicity_C %>% pivot_wider(names_from = Ethnicity, values_from = Cases)
        
        first_line <- CheckTitleWhereKnown(sum(cases_C$Cases), sum(ethnicity_C$Cases), titleStrings$ethnicityD_C)
        
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
  
  output$textEthnicity_C <- renderText({
    paste('<br><b>Note: Ethnicity is largely self-reported data and are identified through case investigation. Data are incomplete due to delays in reporting, data entry, unknown, or undetermined risk factors and persons lost to follow-up (n=', format(sum(cases_C$Cases) - sum(ethnicity_C$Cases), big.mark = ','), ').</b><br><br>', sep = '')
  })
  
  # Top Zip Codes --------------------------------------------------------------
  output$plotlyTopZipCodes_C <- renderPlotly({
    req(input$idTopZipCodes_C)
    
    # Create the strings for the title
    data <- topZipCodes_C %>% top_n(input$idTopZipCodes_C, Cases)
    
    first_line <- paste(titleStrings$topZip_C, ' (Top ', input$idTopZipCodes_C, ')', sep = '')
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(data$Cases), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue, myColors$yellow, myColors$lblue, myColors$dgreen,
                myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue, myColors$yellow, myColors$lblue, myColors$dgreen,
                myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue, myColors$yellow, myColors$lblue, myColors$dgreen,
                myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue, myColors$yellow, myColors$lblue, myColors$dgreen)
    
    plot <- plot_ly(
      data,
      x = ~Zip.Code,
      y = ~Cases,
      type = 'bar',
      text = ~format(Cases, big.mark = ','),
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
  
  output$textTipZipCodes_C <- renderText({
    paste('<br><b>Note: Data are incomplete due to ongoing case investigation. ', str_to_title(as.english(input$idTopZipCodes_C)), ' most reported zip codes represented in graph (n=', format(sum(top_n(topZipCodes_C, input$idTopZipCodes_C, Cases)$Cases), big.mark = ','), ') representing ', sprintf('%0.1f%%', sum(top_n(topZipCodes_C, input$idTopZipCodes_C, Cases)$Cases) / sum(cases_C$Cases) * 100), ' of cases.</b><br><br>', sep = '')
  })
  
  # Zip Codes by Date ----------------------------------------------------------
  output$plotlyZipCodes_C <- renderPlotly({
    req(input$idZipCodes_C)
    
    # Filter the data to the town/city selected by the user
    data <- filter(zip_daily_C, Town.City == input$idZipCodes_C)
    data <- data[order(data$Date, decreasing = FALSE), ]
    
    # Create string for the title
    first_line <- 'Confirmed Cases of COVID-19'
    second_line <- paste(input$idZipCodes_C, ', NY - As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(data$Cases), big.mark = ','), ')', sep = '')
    
    plot <- MakePlotlyLine(data, data$Date, data$Cases, myColors$blue)
    
    # Create the chart
    plot <- plot %>%
      SetTitle(first_line, second_line) %>% 
      FormatX_Axis(label = 'Received Date', 'trace') %>%
      FormatY_Axis('Cases') %>%
      config(plot, displayModeBar = FALSE) %>%
      layout(margin = list(l = 10, r = 10, b = 10, t = 100, pad = 10), hovermode = 'x')
  })
  
  output$textZipCodes_C <- renderText({
    req(input$idZipCodes_C)
    
    # Filter the data to the town/city selected by the user
    data <- filter(zip_daily_C, Town.City == input$idZipCodes_C)
    
    paste('<br><b>Note: This graph does not reflect the most recent cases due to case investigation and data processing. The data in the chart represents the cases in ', input$idZipCodes_C, ', NY (n=', format(sum(data$Cases), big.mark = ','), ') as of ', format(max(cases_C$Date), '%B %d, %Y'), '. The reported cases in ', input$idZipCodes_C, ' represent ', sprintf('%0.2f%%', sum(data$Cases) / sum(cases_C$Cases) * 100), ' of all cases reported.</b><br><br>', sep = '')
  })
  
  # Vaccination ----------------------------------------------------------------
  output$vaccination_C_Plotly <- renderPlotly({
    # Create the strings for the title
    first_line <- CheckTitleWhereKnown(sum(cases_C$Cases), sum(vaccination_C$Cases), titleStrings$vaccination_C)
    second_line <- paste(OC_string, 'As of ', format(max(cases_C$Date), '%B %d, %Y'), ' (n=', format(sum(vaccination_C$Cases), big.mark = ','), ')', sep = '')
    
    colors <- c(myColors$green, myColors$purple, myColors$orange, myColors$red, myColors$blue)
    
    # Create the chart based on user input
    switch (
      input$vaccination_C_ID,
      'Bar Graph' = {
        data <- group_by(vaccination_C, Vaccinated) %>% summarise(Cases = sum(Cases))
        
        plot <- MakePlotlyBar(data, data$Vaccinated, data$Cases, colors) %>%
          FormatX_Axis('Age Group', 'total descending') %>%
          FormatY_Axis('Cases')
      },
      'Pie Chart' = {
        data <- group_by(vaccination_C, Vaccinated) %>% summarise(Cases = sum(Cases))
        
        plot <- MakePlotlyPie(data, data$Vaccinated, data$Cases, 'Age Group', 'Cases', colors) %>%
          layout(legend = list(x = .9, y = .5))
      },
      'Line Graph' = {
        data <- vaccination_C %>% pivot_wider(names_from = Vaccinated, values_from = Cases) %>%
          rename(Partial = Partially)
        
        first_line <- CheckTitleWhereKnown(sum(cases_C$Cases), sum(vaccination_C$Cases), titleStrings$ageGroupD_C)
        
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
  
  output$vaccination_C_Text <- renderText({
    percentages <- GetPercent(vaccination_C, vaccination_C$Vaccinated, vaccination_C$Cases, dataValidation$vaccination)
    
    paste('<br><b>Note: This graph does not reflect the most recent cases due to case investigation and data processing. Missing data (n=', format(sum(cases_C$Cases) - sum(vaccination_C$Cases), big.mark = ','), '). The percent per vaccination status is: None = ', percentages[1], '; Partially = ', percentages[2], '; Fully = ', percentages[3], '; Boosted = ', percentages[4], '; and Second Booster = ', percentages[5], '.</b><br><br>', sep = '')
  })
  
  # Deaths ---------------------------------------------------------------------
  
}

# Run the application 
shinyApp(ui = ui, server = server)
