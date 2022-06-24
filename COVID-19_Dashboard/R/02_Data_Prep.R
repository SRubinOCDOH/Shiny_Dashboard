# Count Count for each unique value in column `Investigation Start Date`
cases_C <- dataCases %>%
  count(Date.Received, name = "Count") %>%
  mutate(Date.Received = as.Date(Date.Received)) %>%
  tidyr::complete(Date.Received = seq.Date(min(Date.Received), max(Date.Received), by =  "day"), fill = list(Count = 0)) %>%
  rename(Date = Date.Received)

# Count Count for each unique value in column `Symptom.Onset`
symptomatic_C <- dataCases %>%
  filter(!is.na(Symptom.Onset)) %>%
  count(Symptom.Onset, name = "Count") %>%
  mutate(Symptom.Onset = as.Date(Symptom.Onset)) %>%
  tidyr::complete(Symptom.Onset = seq.Date(min(Symptom.Onset), max(Symptom.Onset), by =  "day"), fill = list(Count = 0)) %>%
  rename(Date = Symptom.Onset)

# Count Count for each unique value in column `Date.Received`
# where symptom status is not empty: this indicates an
# asymptomatic case
asymptomatic_C <- dataCases %>% 
  filter(!is.na(Symptom.Status)) %>% 
  count(Date.Received, Symptom.Status, name = "Count") %>%
  mutate(Date.Received = as.Date(Date.Received)) %>%
  tidyr::complete(Date.Received = seq.Date(min(Date.Received), max(Date.Received), by =  "day"), fill = list(Count = 0)) %>%
  rename(Date = Date.Received) %>%
  subset(select = c("Date", "Count"))

ageGroup_C <- dataCases %>%
  rename(Date = Date.Received) %>%
  count(Date, Age.Group, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Age.Group, fill = list(Count = 0)) %>%
  filter(!is.na(Age.Group))

gender_C <- dataCases %>%
  rename(Date = Date.Received) %>%
  count(Date, Gender, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Gender, fill = list(Count = 0)) %>%
  filter(Gender %in% dataValidation$gender)

race_C <- dataCases %>%
  rename(Date = Date.Received) %>%
  count(Date, Race, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Race, fill = list(Count = 0)) %>%
  filter(Race %in% dataValidation$race)

ethnicity_C <- dataCases %>%
  rename(Date = Date.Received) %>%
  count(Date, Ethnicity, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Ethnicity, fill = list(Count = 0)) %>%
  filter(Ethnicity %in% dataValidation$ethnicity)

# Get and sort valid towns by Count
topZipCodes_C <- dataCases %>%
  count(Zip.Code, name = "Count") %>%
  merge(dataValidation$zipCodes, by = 'Zip.Code') %>%
  select(1, 3, 2) %>%
  arrange(desc(Count)) %>%
  mutate(Zip.Code = as.character(Zip.Code))

# Create a data table of Count by town by date with zip code
# and town/city attached to the data.
zip_daily_C <- dataCases %>%
  filter(Zip.Code %in% dataValidation$zipCodes$Zip.Code) %>%
  rename(Date = Date.Received) %>%
  count(Date, Zip.Code, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Zip.Code, fill = list(Count = 0)) %>%
  merge(dataValidation$zipCodes, by = 'Zip.Code') %>%
  arrange(Date, Town.City) %>%
  select(Date, Zip.Code, Town.City, Count)

vaccination_C <- dataCases %>%
  filter(Vaccinated %in% dataValidation$vaccination) %>%
  rename(Date = Date.Received) %>%
  count(Date, Vaccinated, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Vaccinated, fill = list(Count = 0))

deaths_D <- dataDeaths %>%
  rename(Date = Date.of.Death) %>%
  count(Date, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), fill = list(Count = 0))

ageGroup_D <- dataDeaths %>%
  rename(Date = Date.of.Death) %>%
  count(Date, Age.Group, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Age.Group, fill = list(Count = 0)) %>%
  filter(!is.na(Age.Group))

gender_D <- dataDeaths %>%
  rename(Date = Date.of.Death) %>%
  count(Date, Gender, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Gender, fill = list(Count = 0)) %>%
  filter(Gender %in% dataValidation$gender)

race_D <- dataDeaths %>%
  rename(Date = Date.of.Death) %>%
  count(Date, Race, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Race, fill = list(Count = 0)) %>%
  filter(Race %in% dataValidation$race)

ethnicity_D <- dataDeaths %>%
  rename(Date = Date.of.Death) %>%
  count(Date, Ethnicity, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Ethnicity, fill = list(Count = 0)) %>%
  filter(Ethnicity %in% dataValidation$ethnicity)

# Get and sort valid towns by Count
topZipCodes_D <- dataDeaths %>%
  count(Zip.Code, name = "Count") %>%
  merge(dataValidation$zipCodes, by = 'Zip.Code') %>%
  select(1, 3, 2) %>%
  arrange(desc(Count)) %>%
  mutate(Zip.Code = as.character(Zip.Code))

# Create a data table of Count by town by date with zip code
# and town/city attached to the data.
zip_daily_D <- dataDeaths %>%
  filter(Zip.Code %in% dataValidation$zipCodes$Zip.Code) %>%
  rename(Date = Date.of.Death) %>%
  count(Date, Zip.Code, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Zip.Code, fill = list(Count = 0)) %>%
  merge(dataValidation$zipCodes, by = 'Zip.Code') %>%
  arrange(Date, Town.City) %>%
  select(Date, Zip.Code, Town.City, Count)

vaccination_D <- dataDeaths %>%
  filter(Vaccinated %in% dataValidation$vaccination) %>%
  rename(Date = Date.of.Death) %>%
  count(Date, Vaccinated, name = "Count") %>%
  mutate(Date = as.Date(Date)) %>%
  tidyr::complete(Date = seq.Date(min(Date), max(Date), by =  "day"), Vaccinated, fill = list(Count = 0)) %>%
  filter(Date >= as.Date(as.character(20210101), format = '%Y%m%d'))
