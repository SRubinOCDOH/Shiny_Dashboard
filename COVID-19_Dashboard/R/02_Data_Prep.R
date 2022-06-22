# Count cases for each unique value in column `Investigation Start Date`
cases_C <- dataCases %>%
  count(Date.Received, name = "Cases") %>%
  mutate(Date.Received = as.Date(Date.Received)) %>%
  tidyr::complete(Date.Received = seq.Date(min(Date.Received), max(Date.Received), by =  "day"), fill = list(Cases = 0)) %>%
  rename(Date = Date.Received)

# Count cases for each unique value in column `Symptom.Onset`
symptomatic_C <- dataCases %>%
  filter(!is.na(Symptom.Onset)) %>%
  count(Symptom.Onset, name = "Cases") %>%
  mutate(Symptom.Onset = as.Date(Symptom.Onset)) %>%
  tidyr::complete(Symptom.Onset = seq.Date(min(Symptom.Onset), max(Symptom.Onset), by =  "day"), fill = list(Cases = 0)) %>%
  rename(Date = Symptom.Onset)

# Count cases for each unique value in column `Date.Received`
# where symptom status is not empty: this indicates an
# asymptomatic case
asymptomatic_C <- dataCases %>% 
  filter(!is.na(Symptom.Status)) %>% 
  count(Date.Received, Symptom.Status, name = "Cases") %>%
  mutate(Date.Received = as.Date(Date.Received)) %>%
  tidyr::complete(Date.Received = seq.Date(min(Date.Received), max(Date.Received), by =  "day"), fill = list(Cases = 0)) %>%
  rename(Date = Date.Received) %>%
  subset(select = c("Date", "Cases"))

# Count the occurrences of each valid age group defined
# in data validation
ageGroup_C <- dataCases %>%
  rename(Date = Date.Received) %>%
  count(Date, Age.Group, name = "Cases") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Age.Group, fill = list(Cases = 0)) %>%
  filter(!is.na(Age.Group))

gender_C <- dataCases %>%
  rename(Date = Date.Received) %>%
  count(Date, Gender, name = "Cases") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Gender, fill = list(Cases = 0)) %>%
  filter(Gender %in% dataValidation$gender)

race_C <- dataCases %>%
  rename(Date = Date.Received) %>%
  count(Date, Race, name = "Cases") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Race, fill = list(Cases = 0)) %>%
  filter(Race %in% dataValidation$race)

ethnicity_C <- dataCases %>%
  rename(Date = Date.Received) %>%
  count(Date, Ethnicity, name = "Cases") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Ethnicity, fill = list(Cases = 0)) %>%
  filter(Ethnicity %in% dataValidation$ethnicity)

# Get and sort valid towns by cases
topZipCodes_C <- dataCases %>% count(Zip.Code, name = "Cases") %>%
  merge(dataValidation$zipCodes, by = 'Zip.Code') %>%
  select(1, 3, 2) %>%
  arrange(desc(Cases))

# Create a data table of cases by town by date with zip code
# and town/city attached to the data.
zip_daily_C <- dataCases %>%
  filter(Zip.Code %in% dataValidation$zipCodes$Zip.Code) %>%
  rename(Date = Date.Received) %>%
  count(Date, Zip.Code, name = "Cases") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Zip.Code, fill = list(Cases = 0)) %>%
  merge(dataValidation$zipCodes, by = 'Zip.Code') %>%
  arrange(Date, Town.City) %>%
  select(Date, Zip.Code, Town.City, Cases)

vaccination_C <- dataCases %>%
  filter(Vaccinated %in% dataValidation$vaccination) %>%
  rename(Date = Date.Received) %>%
  count(Date, Vaccinated, name = "Cases") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Vaccinated, fill = list(Cases = 0))

deaths_D <- dataDeaths %>%
  rename(Date = Date.of.Death) %>%
  count(Date, name = "Deaths") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), fill = list(Deaths = 0))
