# Function call to install and activate all necessary packages
GetDependencies(
  "writexl",
  "tidyxl",
  "openxlsx",
  "plotly",
  "shiny",
  "htmltools",
  "tidyverse",
  "readxl",
  "lubridate",
  "english",
  "shinyWidgets"
)

dataCases <- {
  read_xlsx(
    "data/Cleaned Cases and Deaths.xlsx",
    sheet = "Confirmed Cases",
    .name_repair = "universal",
    col_types = c(
      "date",    # Date Received
      "text",    # Age Group
      "text",    # Gender
      "text",    # Zip Code
      "text",    # Race
      "text",    # Ethnicity
      "text",    # Vaccinated
      "date",    # Symptom Onset
      "text"    # Symptom Status
    )
  )
}

dataDeaths <- {
  read_xlsx(
    "data/Cleaned Cases and Deaths.xlsx",
    sheet = "Deaths",
    .name_repair = "universal",
    col_types = c(
      "text",    # Gender
      "numeric", # Zip Code
      "date",    # Date of Death
      "text",    # Age Group
      "text",    # Race
      "text",    # Ethnicity
      "text"    # Vaccinated
    )
  )
}

myFonts <- {
  list(
    title = list(family = "Calibri Light (Headings)", size = 16, color = "black"),
    axes = list(family = "Calibri Light (Body)", size = 11, color = "black"),
    tooltip = list(family = "Calibri Light (Body)", size = 13, color = "black")
  )
}

myColors <- {
  list(
    "green"  = '#9ACD4C',
    "purple" = '#9941B1',
    "orange" = '#FAA93A',
    "red"    = '#D35940',
    "blue"   = '#63A0CC',
    "yellow" = '#FFC000',
    "lblue"  = '#82FFFF',
    "dgreen" = '#5E8425'
  )
}

dataValidation <- {
  list(
    gender = list("Male", "Female"),
    ageGroup = list("0-17", "18-44", "45-64", "65-74", "75+"),
    race = list("Asian/Native Hawaiian/Other Pacific Islander", "Black", "Native American/Alaska Native", "Other", "White"),
    ethnicity = list("Hispanic", "Non-Hispanic"),
    vaccination = list("None", "Partially", "Fully", "Boosted", "Second Booster"),
    zipCodes = read_xlsx("data/Zip Codes and Towns.xlsx", col_types = c("numeric", "text"), .name_repair = "universal")
  )
}

titleStrings <- {
  list(
    "casesD_C" = "Confirmed Cases of COVID-19 by Date Received",
    "casesW_C" = "Confirmed Cases of COVID-19 by Week Received",
    "casesM_C" = "Confirmed Cases of COVID-19 by Month Received",
    "casesY_C" = "Confirmed Cases of COVID-19 by Year Received",
    
    "sympD_C" = "Confirmed Cases of COVID-19 by Symptom Onset Date",
    "sympW_C" = "Confirmed Cases of COVID-19 by Symptom Onset Week",
    "sympM_C" = "Confirmed Cases of COVID-19 by Symptom Onset Month",
    "sympY_C" = "Confirmed Cases of COVID-19 by Symptom Onset Year",
    
    "asympD_C" = "Asymptomatic Cases of COVID-19 by Date Received",
    "asympW_C" = "Asymptomatic Cases of COVID-19 by Week Received",
    "asympM_C" = "Asymptomatic Cases of COVID-19 by Month Received",
    "asympY_C" = "Asymptomatic Cases of COVID-19 by Year Received",
    
    "ageGroup_C"  = "Confirmed Cases of COVID-19 by Age Group",
    
    "avgAge_C"  = "Average Age of Confirmed Cases of COVID-19",
    
    "gender_C"  = "Confirmed Cases of COVID-19 by Gender",
    
    "race_C"  = "Confirmed Cases of COVID-19 by Race",
    
    "ethnicity_C"     = "Confirmed Cases of COVID-19 by Ethnicity",
    
    "topZip_C"  = "Confirmed Cases of COVID-19 by Municipality",
    
    "vaccination_C"  = "Confirmed Cases of COVID-19 by Vaccination Status",
    
    "deathsD_D" = "Confirmed and Probable COVID-19 Deaths by Date of Death",
    "deathsW_D" = "Confirmed and Probable COVID-19 Deaths by Week of Death",
    "deathsM_D" = "Confirmed and Probable COVID-19 Deaths by Month of Death",
    "deathsY_D" = "Confirmed and Probable COVID-19 Deaths by Year of Death",
    
    "ageGroup_D"  = "Confirmed and Probable COVID-19 Deaths by Age Group",
    
    "avg_age_D" = "Average Age of Confirmed and Probable COVID-19 Deaths",
    
    "gender_D"  = "Confirmed and Probable COVID-19 Deaths by Gender",
    
    "race_D"    = "Confirmed and Probable COVID-19 Deaths by Race",
    
    "ethnicity_D"    = "Confirmed and Probable COVID-19 Deaths by Ethnicity",
    
    "topZip_D" = "Confirmed and Probable COVID-19 Deaths by Top Municipalities",
    
    "vaccination_D"    = "Confirmed and Probable COVID-19 Deaths by Vaccination Status"
  )
}

OC_string <- "Orange County, NY - "

view_types <- c("Daily", "Weekly", "Monthly", "Yearly")
plot_types <- c("Bar Graph", "Pie Chart", "Line Graph")
