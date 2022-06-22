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
    "ageGroupD_C" = "Confirmed Cases of COVID-19 by Age Group by Date Received",
    "ageGroupW_C" = "Confirmed Cases of COVID-19 by Age Group by Week Received",
    "ageGroupM_C" = "Confirmed Cases of COVID-19 by Age Group by Month Received",
    "ageGroupY_C" = "Confirmed Cases of COVID-19 by Age Group by Year Received",
    
    "avgAge_C"  = "Average Age of Confirmed Cases of COVID-19",
    "avgAgeD_C" = "Average Age of Confirmed Cases of COVID-19 by Date Received",
    "avgAgeW_C" = "Average Age of Confirmed Cases of COVID-19 by Week Received",
    "avgAgeM_C" = "Average Age of Confirmed Cases of COVID-19 by Month Received",
    "avgAgeY_C" = "Average Age of Confirmed Cases of COVID-19 by Year Received",
    
    "gender_C"  = "Confirmed Cases of COVID-19 by Gender",
    "genderD_C" = "Confirmed Cases of COVID-19 by Gender by Date Received",
    "genderW_C" = "Confirmed Cases of COVID-19 by Gender by Week Received",
    "genderM_C" = "Confirmed Cases of COVID-19 by Gender by Month Received",
    "genderY_C" = "Confirmed Cases of COVID-19 by Gender by Year Received",
    
    "race_C"  = "Confirmed Cases of COVID-19 by Race",
    "raceD_C" = "Confirmed Cases of COVID-19 by Race by Date Received",
    "raceW_C" = "Confirmed Cases of COVID-19 by Race by Week Received",
    "raceM_C" = "Confirmed Cases of COVID-19 by Race by Month Received",
    "raceY_C" = "Confirmed Cases of COVID-19 by Race by Year Received",
    
    "ethnicity_C"     = "Confirmed Cases of COVID-19 by Ethnicity",
    "ethnicityD_C"    = "Confirmed Cases of COVID-19 by Ethnicity by Date Received",
    "ethnicityW_C"    = "Confirmed Cases of COVID-19 by Ethnicity by Week Received",
    "ethnicityM_C"    = "Confirmed Cases of COVID-19 by Ethnicity by Month Received",
    "ethnicityY_C"    = "Confirmed Cases of COVID-19 by Ethnicity by Year Received",
    
    "topZip_C"  = "Confirmed Cases of COVID-19 by Municipality",
    "topZipD_C" = "Confirmed Cases of COVID-19 by Municipality by Date Received",
    "topZipW_C" = "Confirmed Cases of COVID-19 by Municipality by Week Received",
    "topZipM_C" = "Confirmed Cases of COVID-19 by Municipality by Month Received",
    "topZipY_C" = "Confirmed Cases of COVID-19 by Municipality by Year Received",
    
    "vaccination_C"  = "Confirmed Cases of COVID-19 by Vaccination Status",
    "vaccinationD_C" = "Confirmed Cases of COVID-19 by Vaccination Status by Date Received",
    "vaccinationW_C" = "Confirmed Cases of COVID-19 by Vaccination Status by Week Received",
    "vaccinationM_C" = "Confirmed Cases of COVID-19 by Vaccination Status by Month Received",
    "vaccinationY_C" = "Confirmed Cases of COVID-19 by Vaccination Status by Year Received",
    
    "dod_D"     = "Confirmed and Probable COVID-19 Deaths by Date of Death",
    "gender_D"  = "Confirmed and Probable COVID-19 Deaths by Gender",
    "race_D"    = "Confirmed and Probable COVID-19 Deaths by Race",
    "ethn_D"    = "Confirmed and Probable COVID-19 Deaths by Ethnicity",
    "age_gr_D"  = "Confirmed and Probable COVID-19 Deaths by Age Group",
    "avg_age_D" = "Average Age of Confirmed and Probable COVID-19 Deaths",
    "vacc_D"    = "Confirmed and Probable COVID-19 Deaths by Vaccination Status",
    "top_zip_D" = "Confirmed and Probable COVID-19 Deaths by Top Municipalities"
  )
}

OC_string <- "Orange County, NY - "

view_types <- c("Daily", "Weekly", "Monthly", "Yearly")
plot_types <- c("Bar Graph", "Pie Chart", "Line Graph")
