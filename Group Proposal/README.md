# **Group Proposal**

## Interested

**Why are you interested in this field/domain?**

 - Because in recent years, the epidemic has caused a significant impact on the US as a natural biological disaster. So we want to analyze the effects of other natural disasters, incredibly natural environmental disasters, on the United States. We mainly want to explore the comprehensiveness and relevance of catastrophe to make more in-depth predictions and judgments.

**What other examples of the data-driven project have you found related to this domain (share at least 3)?**

 - [This article][1] is about how to predict earthquakes, one of the disasters we will analyze this quarter, better.
- _Rubinstein, J., Ellsworth, W., Chen, K., & Uchida, N. (2012). Fixed recurrence and slip models better predict earthquake behavior than the time- and slip-predictable models: 1. Repeating earthquakes. Journal of Geophysical Research: Solid Earth, 117(B2), N/a._



 - [This article][2] is about the information gap in Natural disasters and its potential harm. Also, our team’s analysis target is to find out the harm of the information gap.
- _Hong, L., Fu, C., Wu, J., & Frias-Martinez, V. (2018). Information Needs and Communication Gaps between Citizens and Local Governments Online during Natural Disasters. Information Systems Frontiers, 20(5), 1027-1039._




- [This article][3] discusses the social media data aid in disaster response and damage assessment. In our analysis, we want to find out whether the data that citizens gained from social media is correct and comprehensive. Therefore, this article  helps us have a background of the relationship between social media and disasters.
 - _Kryvasheyeu, Y., Chen, H., Obradovich, N., Moro, E., Van Hentenryck, P., Fowler, J., & Cebrian, M. (2016). Rapid assessment of disaster damage using social media activity. Science Advances, 2(3), E1500779._

[1]: https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2011JB008724

[2]: https://alliance-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=TN_cdi_webofscience_primary_000444026300010CitationCount&context=PC&vid=UW&lang=en_US&search_scope=all&adaptor=primo_central_multiple_fe&tab=default_tab&query=any,contains,Information%20Needs%20and%20Communication%20Gaps%20between%20Citizens%20and&offset=0

[3]: https://www.science.org/doi/10.1126/sciadv.1500779


**What data-driven questions do you hope to answer about this domain (share at least 3)?**
1. What is the correlation between disasters (for example, which two disasters occurred in close time)
2. The number of casualties and property losses caused by the disaster (region, time)
3. Different disasters usually occur in which country

## Finding Data

**Where did you download the data (e.g., a web URL)?**
1. https://www.kaggle.com/noaa/hurricane-database

2. https://www.kaggle.com/usgs/earthquake-database

3. https://www.kaggle.com/sobhanmoosavi/us-weather-events

**How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?**
  - The dates are collected by researchers to analyze the appearance of earthquakes and weather events. Both databases of hurricanes (NOAA) and earthquakes (US geology survey) are made by officials. However, the database about US weather events is made by the individual (Sobhan Moosavi). All of the record special conditions that happen in a limited time period, which help researchers to examine the frequency, duration, and intensity of events.

### **Hurricanes and Typhoons, 1851-2014**

**How many observations (rows) are in your data?**
 - In “atlantic.csv”, **49105** observations. In “pacific.csv”, **26137** observations.

**How many features (columns) are in the data?**

 - In “atlantic.csv”, **22** features. In “pacific.csv”, **22** features.

**What questions (from above) can be answered using the data in this dataset?**

 - These two databases record data on hurricanes and typhoons that have occurred in the Atlantic and Pacific Oceans, respectively, between 1851 and 2014. They can be used as data on hurricanes and typhoons to compare with other databases to draw conclusions on whether they are accurate and comprehensive. At the same time, graphs of hurricanes and typhoons for each year or decade can be drawn from these two databases for analysis and summary. These data can even be used to predict possible future hurricanes and typhoons and compare them with the real situation to better predict future cyclones.




### **Significant Earthquakes, 1965-2016**
**How many observations (rows) are in your data?**

 - In “database.csv”, **23412** observations.

**How many features (columns) are in the data?**

 - In “database.csv”, **21** features.

**What questions (from above) can be answered using the data in this dataset?**

 - This dataset includes records of the date, time, location, depth, magnitude, and source of earthquakes of magnitude 5.5 or greater reported since 1965.It can be used as a comparison of data on earthquakes with other databases to draw conclusions about whether they are accurate and comprehensive.At the same time, a graph of earthquakes that have occurred every year or every decade can be drawn from this database for analysis and summary.These details can even be used to predict possible future earthquakes by comparing them with the real situation.

### **US Weather Events (2016 - 2020)**

**How many observations (rows) are in your data?**
 - In “WeatherEvents_Jan2016-Dec2020.csv”, **1048878** observations. This data set is too large for the Excel grids. Some unloaded data was lost after opening.

**How many features (columns) are in the data?**

 - In “WeatherEvents_Jan2016-Dec2020.csv”, **13** features.

**What questions (from above) can be answered using the data in this dataset?**

 - This is a nationwide dataset of weather events in the United States, covering 49 U.S. states. Examples of weather events are rain, snow, storms, and freezing conditions. Some events in this dataset are extreme events (e.g., storms) and some can be considered routine events (e.g., rain and snow). These data were collected from January 2016 to December 2020. The data can be compared to other databases as a more complete dataset in this year's range (2016.1-2020.12) to draw conclusions about whether it is accurate and comprehensive. Also, graphs of extreme events that have occurred each year can be drawn from this database for analysis and summary.
