library(pacman)
p_load(pacman, RODBC, tidyverse, gsubfn, REDCapR)


# Access ------------------------------------------------------------------

myconnection <- odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};
                                  DBQ=T:/Research Database.accdb") # edited due to privacy

# Enrolment Log
enrolment <- sqlFetch(myconnection, "OBS Enrolment Log") %>%
  tibble()

enrolment$OBSEnrolmentID = gsubfn("-", "", enrolment$OBSEnrolmentID) %>%
  as.double()

# Followup Log
followup <- sqlFetch(myconnection, "OBSFollowupLog") %>%
  tibble()

followup$OBSEnrolmentID = gsubfn("-", "", followup$OBSEnrolmentID) %>%
  as.double()


close(myconnection)

dashdata <- tibble(OBSEnrolmentID = enrolment$OBSEnrolmentID) # create new data frame for actual analysis 

# Demographics ------------------------------------------------------------------

age = redcap_read_oneshot(redcap_uri = "api_url_goes_here", 
                          token = "token", 
                          records = array(dashdata$OBSEnrolmentID),
                          fields_collapsed = "obs_id, base_dem_age_at_consent")$data %>%
  tibble() %>%
  filter(redcap_event_name == "baseline_assessmen_arm_1") %>%
  select(obs_id, base_dem_age_at_consent) %>%
  rename(OBSEnrolmentID = obs_id,
         age = base_dem_age_at_consent)

dashdata <- left_join(dashdata, age)

remove(age)

# Samples and Questionnaires -----------------------------------------------------------------


followup_scan <- function(var, to = dashdata, from = followup) {
  shortened <- from %>% 
    select(OBSEnrolmentID, all_of(var))
  
  new_dat <- shortened %>%
    filter(shortened[[2]] == as.integer(1))
  
  dashdata <- left_join(to, new_dat)
  
  returnValue(dashdata)
}

items <- c("OBSBlood1", "OBSBlood2", "OBSBlood3", "OBSBlood4", "OBSInfantSpotCard", 
           "DHQ(1)Completed", "LSQ(1)Returned", "LSQ(2)Returned", "LSQ(3)Returned", 
           "OBSSwab1", "OBSSwab2")


for (item in items) {
  dashdata <- followup_scan(item)
}

new_names <- c("OBSEnrolmentID", "Age", "Blood1", "Blood2", "Blood3", "Blood4", "BSc", 
               "DHQ", "LSQ1", "LSQ2", "LSQ3", "Swab1", "Swab2")


names(dashdata) <- new_names


write_csv(dashdata, "data/dashdata.csv")

