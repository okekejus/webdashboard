# Table of Contents 

- Background 
- Objective 
- Tools and Packages 
- Data Collection & Processing
- Data Visualization 
- Results




## Background 
I spent some time in a Data Specialist role for the Ontario Birth Study[http://ontariobirthstudy.com/], and during this time we outlined a need for an informative dashboard of OBS progress while I constructed the new website. 


## Objective 
- Consolidate relevant data (total completed questionnaires, average participant age, samples collected and more) 
- Improve OBS efficiency using BI applications 
- Brodcast relevant KPIs to obs stakeholders (participants, researchers) and people with a general interest in the study
- Embed dashboard on OBS website
- Automate process 


## Tools and Packages 
This project was done entirely using R: 

- shiny: Interactive web applications
- shinydashboard: Dashboard layouts for shiny 
- tidyverse: Data manipulation & visualization 
- RODBC: ODBC connectivity between R and SQL databases
- gsubfn: String expressions
- REDCapR: API for interaction between REDCap and R 

## Data Collection & Processing 

|Method                |Notes                                                  |
|----------------------|-------------------------------------------------------|
|redcap_read_oneshot() |Gathering clinical data for each patient               |
|followup_scan()       |Function for data transformation for dashboard purposes|




I was tasked with displaying the OBS' progress in an exciting manner to visitors of our website. I was able to do this using R (Shiny). Two versions of the dashboard exist, a simplified version for anyone who visits the [home page](http://ontariobirthstudy.com/) and another for [prospective researchers](http://ontariobirthstudy.com/researchers/) interested in OBS Data and Specimens. 
