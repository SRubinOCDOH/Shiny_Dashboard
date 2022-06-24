# Install and activate all necessary packages
GetDependencies <- function(...) {
  libs <- unlist(list(...))
  req <- unlist(lapply(libs, require, character.only = TRUE))
  need <- libs[req == FALSE]
  
  if (length(need) > 0) {
    install.packages(need)
    lapply(need, require, character.only = TRUE)
  }
}

# Make a plotly line graph
MakePlotlyLine <- function(df, x, y, colors = myColors$green) {
  p <- plot_ly(
    df,
    x = ~x,
    y = ~y,
    type = 'scatter',
    mode = 'lines',
    line = list(color = colors),
    showlegend = FALSE,
    hoverlabel = list(align = 'left', font = myFonts$tooltip),
    hovertemplate = paste(
      '<b>%{xaxis.title.text}</b>: %{x}',
      '<br><b>%{yaxis.title.text}</b>: %{y:,}',
      '<extra></extra>'
    )
  )
  
  p <- p %>% layout(margin = list(l = 10, r = 10, b = 5, t = 100, pad = 5)) %>%
    config(displayModeBar = FALSE)
}

# Make a plotly bar graph
MakePlotlyBar <- function(df, x, y, colors = myColors$green) {
  p <- plot_ly(
    df,
    x = ~x,
    y = ~y,
    type = 'bar',
    text = ~format(y, big.mark = ','),
    textposition = 'outside',
    textfont = list(color = '#000000'),
    marker = list(color = colors),
    showlegend = FALSE,
    hoverlabel = list(align = 'left', font = myFonts$tooltip),
    hovertemplate = paste(
      '<br><b>%{xaxis.title.text}</b>: %{x}',
      '<br><b>%{yaxis.title.text}</b>: %{y:,}',
      '<extra></extra>'
    )
  )
  
  p <- p %>% layout(margin = list(l = 10, r = 10, b = 5, t = 100, pad = 5)) %>%
    config(displayModeBar = FALSE)
}

MakePlotlyPie <- function(df, x, y, xLabel, yLabel, colors = c(myColors$green, myColors$yellow)) {
  p <- plot_ly(
    df,
    labels = ~x,
    values = ~y,
    type = 'pie',
    sort = FALSE,
    textinfo = 'label',
    insidetextfont = list(color = '#000000', size = 15),
    marker = list(colors = colors, line = list(color = '#FFFFFF', width = 2)),
    text = ~Count,
    hoverlabel = list(align = 'left', font = myFonts$tooltip),
    hovertemplate = paste(
      '<b>', xLabel, '</b>: %{label}<br>',
      '<b>', yLabel, '</b>: %{text}<br>',
      '<b>Percent</b>: %{percent:2.1f}',
      '<extra></extra>',
      sep = ''
    )
  )
  
  p <- p %>% layout(margin = list(l = 10, r = 10, b = 5, t = 100, pad = 5)) %>%
    config(displayModeBar = FALSE)
}

SetTitle <- function(p, firstString = 'First', secondString = 'Second') {
  # Set title
  p <- p %>%
    layout(title = list(
      text = str_glue('{firstString}\n{secondString}'),
      font = myFonts$title
    ))
}

MakeTitleSecondLine <- function(dates, date_format = '%B %d, %Y', cases = 0) {
  min_date <- format(min(dates), date_format)
  max_date <- format(max(dates), date_format)
  nmbr_cases <- format(as.numeric(sum(cases)), big.mark = ',')
  second_line <- paste(OC_string, min_date, ' to ', max_date, ' (n=', nmbr_cases, ')', sep = '')
  
  return(second_line)
}

CheckTitleWhereKnown <- function(grand_total, value_to_check, string_val) {
  if (value_to_check < grand_total) return(paste(string_val, 'Where Known'))
  else return(string_val)
}

FormatX_Axis <- function(p, label = 'x-axis', catOrder = 'trace') {
  # Set x-axis formatting
  p <- p %>%
    layout(xaxis = list(
      title = list(text = label, standoff = 20L),
      font = myFonts$axes,
      categoryorder = catOrder,
      fixedrange = TRUE))
}

FormatY_Axis <- function(p, label = 'y-axis') {
  p <- p %>%
    layout(yaxis = list(
      title = list(text = label, standoff = 20L),
      font = myFonts$axes,
      rangemode = 'tozero',
      fixedrange = TRUE))
}

CustomDateInput <- function(inputId, label, minview = "days", maxview = "decades", ...) {
  d <- shiny::dateInput(inputId, label, ...)
  d$children[[2L]]$attribs[["data-date-min-view-mode"]] <- minview
  d$children[[2L]]$attribs[["data-date-max-view-mode"]] <- maxview
  d
}

GetDateData <- function(df, date_type = 'day') {
  x <- df %>%
    group_by(Date = floor_date(Date, date_type)) %>%
    summarize(Count = sum(Count))
  
  return(x)
}

GetDateLimitedData <- function(df, from, to, date_type = 'day') {
  x <- df %>%
    group_by(Date = floor_date(Date, date_type)) %>%
    filter(as.Date(Date) >= as.Date(from) & as.Date(Date) <= as.Date(to)) %>%
    summarize(Count = sum(Count))
  
  return(x)
}

GetPercent <- function(df, values, count, validation) {
  # Create an empty list to store values and return
  x <- list()
  
  # Calculate percentage for the amount of values in the data validation
  for (i in 1:length(validation)) {
    x[i] <- sprintf('%0.2f%%', sum(df[which(values == validation[i]), 3]) / sum(count) * 100)
  }
  
  return(x)
}