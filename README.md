# Table of Contents 

- Background 
- Objective 
- Tools and Packages 
- Data Collection & Processing 
- Results




## Background 
I spent some time in a Data Specialist role for the [Ontario Birth Study](http://ontariobirthstudy.com/), and during this time we outlined a need for an informative dashboard of OBS progress while I constructed the new website. 


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
| HTML iFrame          | For embedding dashboards into web pages               |


## Results
![image](https://user-images.githubusercontent.com/91495866/165196945-5d481002-9883-425e-875d-60c6ed55404f.png)

The image above is from the dashboard on the home page, which can be accessed [here](http://ontariobirthstudy.com/)


![image](https://user-images.githubusercontent.com/91495866/165197109-87ff9d2f-2bf7-4274-b72f-91bd9152998c.png)
The image above is from the more detailed researcher dashboard, which goes into granular detail regarding the details of the [study](http://ontariobirthstudy.com/researchers/). 

Benefits include:
- Focusing on & broadcasting KPIs to relevant stakeholders. 
- Fully customizable depending on business or stakeholder interests. 
- Data consolidation 
