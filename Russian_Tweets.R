#Required Packages
library(RCurl)
library(sqldf)
library(igraph)
library(dplyr)

#Turn off Scientific Notation for User ID
options(scipen = 999)

#Load the Data from Github
startOfURL = "https://raw.githubusercontent.com/fivethirtyeight/russian-troll-tweets/master/"
csvNames = c("IRAhandle_tweets_1.csv", "IRAhandle_tweets_2.csv", "IRAhandle_tweets_3.csv", "IRAhandle_tweets_4.csv", "IRAhandle_tweets_5.csv", "IRAhandle_tweets_6.csv", "IRAhandle_tweets_7.csv", "IRAhandle_tweets_8.csv", "IRAhandle_tweets_9.csv", "IRAhandle_tweets_10.csv", "IRAhandle_tweets_11.csv", "IRAhandle_tweets_12.csv", "IRAhandle_tweets_13.csv")
handle1 = read.csv(text = getURL(paste(startOfURL, csvNames[1], sep = "")))
handle2 = read.csv(text = getURL(paste(startOfURL, csvNames[2], sep = "")))
handle3 = read.csv(text = getURL(paste(startOfURL, csvNames[3], sep = "")))
handle4 = read.csv(text = getURL(paste(startOfURL, csvNames[4], sep = "")))
handle5 = read.csv(text = getURL(paste(startOfURL, csvNames[5], sep = "")))
handle6 = read.csv(text = getURL(paste(startOfURL, csvNames[6], sep = "")))
handle7 = read.csv(text = getURL(paste(startOfURL, csvNames[7], sep = "")))
handle8 = read.csv(text = getURL(paste(startOfURL, csvNames[8], sep = "")))
handle9 = read.csv(text = getURL(paste(startOfURL, csvNames[9], sep = "")))
handle10 = read.csv(text = getURL(paste(startOfURL, csvNames[10], sep = "")))
handle11 = read.csv(text = getURL(paste(startOfURL, csvNames[11], sep = "")))
handle12 = read.csv(text = getURL(paste(startOfURL, csvNames[12], sep = "")))
handle13 = read.csv(text = getURL(paste(startOfURL, csvNames[13], sep = "")))

#Combine the DFs into 1
tweets = rbind(handle1, handle2, handle3, handle4, handle5, handle6, handle7, handle8, handle9, handle10, handle11, handle12, handle13)

#Get Tweets in English
tweetsEng = sqldf("SELECT * FROM tweets WHERE language = 'English'")

#English Tweets which Mention Other Users
tweetsEngMention = sqldf("SELECT * FROM tweets WHERE content LIKE '@'")

#DF for Network Graph
tweetsEngMentionNEW = sqldf("SELECT author, content, region, account_type FROM tweetsEngMention")
tweetsEngMentionNEW$mentionedCount = ""
tweetsEngMentionNEW$mentioned1 = ""
tweetsEngMentionNEW$mentioned2 = ""
tweetsEngMentionNEW$mentioned3 = ""
tweetsEngMentionNEW$mentioned4 = ""
tweetsEngMentionNEW$mentioned5 = ""
tweetsEngMentionNEW$mentioned6 = ""
tweetsEngMentionNEW$mentioned7 = ""
tweetsEngMentionNEW$mentioned8 = ""
tweetsEngMentionNEW$mentioned9 = ""
for (x in 1:nrow(tweetsEngMentionNEW)) {
  theString = as.character(tweetsEngMentionNEW$content[x])
  theString1 = unlist(strsplit(theString, " "))
  regex = "(^|[^@\\w])@(\\w{1,15})\\b"
  idx = grep(regex, theString1, perl = T)
  if (length(theString1[idx]) == 1) {
    tweetsEngMentionNEW$mentioned1[x] = theString1[idx][1]
    tweetsEngMentionNEW$mentioned2[x] = NA
    tweetsEngMentionNEW$mentioned3[x] = NA
    tweetsEngMentionNEW$mentioned4[x] = NA
    tweetsEngMentionNEW$mentioned5[x] = NA
    tweetsEngMentionNEW$mentioned6[x] = NA
    tweetsEngMentionNEW$mentioned7[x] = NA
    tweetsEngMentionNEW$mentioned8[x] = NA
    tweetsEngMentionNEW$mentioned9[x] = NA
  }
  else if (length(theString1[idx]) == 2) {
    tweetsEngMentionNEW$mentioned1[x] = theString1[idx][1]
    tweetsEngMentionNEW$mentioned2[x] = theString1[idx][2]
    tweetsEngMentionNEW$mentioned3[x] = NA
    tweetsEngMentionNEW$mentioned4[x] = NA
    tweetsEngMentionNEW$mentioned5[x] = NA
    tweetsEngMentionNEW$mentioned6[x] = NA
    tweetsEngMentionNEW$mentioned7[x] = NA
    tweetsEngMentionNEW$mentioned8[x] = NA
    tweetsEngMentionNEW$mentioned9[x] = NA
  }
  else if (length(theString1[idx]) == 3) {
    tweetsEngMentionNEW$mentioned1[x] = theString1[idx][1]
    tweetsEngMentionNEW$mentioned2[x] = theString1[idx][2]
    tweetsEngMentionNEW$mentioned3[x] = theString1[idx][3]
    tweetsEngMentionNEW$mentioned4[x] = NA
    tweetsEngMentionNEW$mentioned5[x] = NA
    tweetsEngMentionNEW$mentioned6[x] = NA
    tweetsEngMentionNEW$mentioned7[x] = NA
    tweetsEngMentionNEW$mentioned8[x] = NA
    tweetsEngMentionNEW$mentioned9[x] = NA
  }
  else if (length(theString1[idx]) == 4) {
    tweetsEngMentionNEW$mentioned1[x] = theString1[idx][1]
    tweetsEngMentionNEW$mentioned2[x] = theString1[idx][2]
    tweetsEngMentionNEW$mentioned3[x] = theString1[idx][3]
    tweetsEngMentionNEW$mentioned4[x] = theString1[idx][4]
    tweetsEngMentionNEW$mentioned5[x] = NA
    tweetsEngMentionNEW$mentioned6[x] = NA
    tweetsEngMentionNEW$mentioned7[x] = NA
    tweetsEngMentionNEW$mentioned8[x] = NA
    tweetsEngMentionNEW$mentioned9[x] = NA
  }
  else if (length(theString1[idx]) == 5) {
    tweetsEngMentionNEW$mentioned1[x] = theString1[idx][1]
    tweetsEngMentionNEW$mentioned2[x] = theString1[idx][2]
    tweetsEngMentionNEW$mentioned3[x] = theString1[idx][3]
    tweetsEngMentionNEW$mentioned4[x] = theString1[idx][4]
    tweetsEngMentionNEW$mentioned5[x] = theString1[idx][5]
    tweetsEngMentionNEW$mentioned6[x] = NA
    tweetsEngMentionNEW$mentioned7[x] = NA
    tweetsEngMentionNEW$mentioned8[x] = NA
    tweetsEngMentionNEW$mentioned9[x] = NA
  }
  else if (length(theString1[idx]) == 6) {
    tweetsEngMentionNEW$mentioned1[x] = theString1[idx][1]
    tweetsEngMentionNEW$mentioned2[x] = theString1[idx][2]
    tweetsEngMentionNEW$mentioned3[x] = theString1[idx][3]
    tweetsEngMentionNEW$mentioned4[x] = theString1[idx][4]
    tweetsEngMentionNEW$mentioned5[x] = theString1[idx][5]
    tweetsEngMentionNEW$mentioned6[x] = theString1[idx][6]
    tweetsEngMentionNEW$mentioned7[x] = NA
    tweetsEngMentionNEW$mentioned8[x] = NA
    tweetsEngMentionNEW$mentioned9[x] = NA
  }
  else if (length(theString1[idx]) == 7) {
    tweetsEngMentionNEW$mentioned1[x] = theString1[idx][1]
    tweetsEngMentionNEW$mentioned2[x] = theString1[idx][2]
    tweetsEngMentionNEW$mentioned3[x] = theString1[idx][3]
    tweetsEngMentionNEW$mentioned4[x] = theString1[idx][4]
    tweetsEngMentionNEW$mentioned5[x] = theString1[idx][5]
    tweetsEngMentionNEW$mentioned6[x] = theString1[idx][6]
    tweetsEngMentionNEW$mentioned7[x] = theString1[idx][7]
    tweetsEngMentionNEW$mentioned8[x] = NA
    tweetsEngMentionNEW$mentioned9[x] = NA
  }
  else if (length(theString1[idx]) == 8) {
    tweetsEngMentionNEW$mentioned1[x] = theString1[idx][1]
    tweetsEngMentionNEW$mentioned2[x] = theString1[idx][2]
    tweetsEngMentionNEW$mentioned3[x] = theString1[idx][3]
    tweetsEngMentionNEW$mentioned4[x] = theString1[idx][4]
    tweetsEngMentionNEW$mentioned5[x] = theString1[idx][5]
    tweetsEngMentionNEW$mentioned6[x] = theString1[idx][6]
    tweetsEngMentionNEW$mentioned7[x] = theString1[idx][7]
    tweetsEngMentionNEW$mentioned8[x] = theString1[idx][8]
    tweetsEngMentionNEW$mentioned9[x] = NA
  }
  else if (length(theString1[idx]) == 9) {
    tweetsEngMentionNEW$mentioned1[x] = theString1[idx][1]
    tweetsEngMentionNEW$mentioned2[x] = theString1[idx][2]
    tweetsEngMentionNEW$mentioned3[x] = theString1[idx][3]
    tweetsEngMentionNEW$mentioned4[x] = theString1[idx][4]
    tweetsEngMentionNEW$mentioned5[x] = theString1[idx][5]
    tweetsEngMentionNEW$mentioned6[x] = theString1[idx][6]
    tweetsEngMentionNEW$mentioned7[x] = theString1[idx][7]
    tweetsEngMentionNEW$mentioned8[x] = theString1[idx][8]
    tweetsEngMentionNEW$mentioned9[x] = theString1[idx][9]
  }
  else {
    tweetsEngMentionNEW$mentioned1[x] = NA
    tweetsEngMentionNEW$mentioned2[x] = NA
    tweetsEngMentionNEW$mentioned3[x] = NA
    tweetsEngMentionNEW$mentioned4[x] = NA
    tweetsEngMentionNEW$mentioned5[x] = NA
    tweetsEngMentionNEW$mentioned6[x] = NA
    tweetsEngMentionNEW$mentioned7[x] = NA
    tweetsEngMentionNEW$mentioned8[x] = NA
    tweetsEngMentionNEW$mentioned9[x] = NA
  }
  tweetsEngMentionNEW$mentionedCount[x] = length(theString1[idx])
}

#Export DataFrame with Mention Data
write.csv(tweetsEngMentionNEW, "C:\\Users\\gould\\Documents\\1-USE DOCS\\MS Business Analytics\\3-Fall 2018\\ITM881\\HW\\HW2\\tweetsEngMentionNEW.csv")

#Remove Tweet Column
tweetsEngMentionNEW$content = NULL

#Remove Punctuation
tweetsEngMentionNEW$mentioned1 = gsub('[[:punct:] ]+', '', tweetsEngMentionNEW$mentioned1)
tweetsEngMentionNEW$mentioned2 = gsub('[[:punct:] ]+', '', tweetsEngMentionNEW$mentioned2)
tweetsEngMentionNEW$mentioned3 = gsub('[[:punct:] ]+', '', tweetsEngMentionNEW$mentioned3)
tweetsEngMentionNEW$mentioned4 = gsub('[[:punct:] ]+', '', tweetsEngMentionNEW$mentioned4)
tweetsEngMentionNEW$mentioned5 = gsub('[[:punct:] ]+', '', tweetsEngMentionNEW$mentioned5)
tweetsEngMentionNEW$mentioned6 = gsub('[[:punct:] ]+', '', tweetsEngMentionNEW$mentioned6)
tweetsEngMentionNEW$mentioned7 = gsub('[[:punct:] ]+', '', tweetsEngMentionNEW$mentioned7)
tweetsEngMentionNEW$mentioned8 = gsub('[[:punct:] ]+', '', tweetsEngMentionNEW$mentioned8)
tweetsEngMentionNEW$mentioned9 = gsub('[[:punct:] ]+', '', tweetsEngMentionNEW$mentioned9)

#Remove 0 Mentions
tweetsEngMentionNEW$mentionedCount = as.numeric(tweetsEngMentionNEW$mentionedCount)
tweetsEngMentionNEW = sqldf("SELECT * FROM tweetsEngMentionNEW WHERE mentionedCount > 0")

#Keep Distinct Rows
tweetsEngMentionNEW = sqldf("SELECT DISTINCT * FROM tweetsEngMentionNEW")

#Melt the Data
men1 = sqldf("SELECT author, region, account_type, mentioned1 AS mentioned FROM tweetsEngMentionNEW")
men2 = sqldf("SELECT author, region, account_type, mentioned2 AS mentioned FROM tweetsEngMentionNEW")
men3 = sqldf("SELECT author, region, account_type, mentioned3 AS mentioned FROM tweetsEngMentionNEW")
men4 = sqldf("SELECT author, region, account_type, mentioned4 AS mentioned FROM tweetsEngMentionNEW")
men5 = sqldf("SELECT author, region, account_type, mentioned5 AS mentioned FROM tweetsEngMentionNEW")
men6 = sqldf("SELECT author, region, account_type, mentioned6 AS mentioned FROM tweetsEngMentionNEW")
men7 = sqldf("SELECT author, region, account_type, mentioned7 AS mentioned FROM tweetsEngMentionNEW")
men8 = sqldf("SELECT author, region, account_type, mentioned8 AS mentioned FROM tweetsEngMentionNEW")
men9 = sqldf("SELECT author, region, account_type, mentioned9 AS mentioned FROM tweetsEngMentionNEW")

menAll = rbind(men1, men2, men3, men4, men5, men6, men7, men8, men9)
menAll = menAll[!(is.na(menAll$mentioned) | menAll$mentioned==""), ]
menAll = sqldf("SELECT DISTINCT * FROM menAll")

#Export Melted Data
write.csv(menAll, "C:\\Users\\gould\\Documents\\1-USE DOCS\\MS Business Analytics\\3-Fall 2018\\ITM881\\HW\\HW2\\menAll.csv")

#In the Event of R Crash, Upload menAll
menAll = read.csv("C:\\Users\\gould\\Documents\\1-USE DOCS\\MS Business Analytics\\3-Fall 2018\\ITM881\\HW\\HW2\\menAll.csv", header = T, sep = ",")
menAll$X = NULL

#Generate Stratified Sample of Users
menAll = sqldf("SELECT * FROM menAll WHERE mentioned NOT LIKE '%<U+%'")
menAll = sqldf("SELECT DISTINCT * FROM menAll")
menAll$region = as.factor(menAll$region)
menAll$account_type = as.factor(menAll$account_type)
menAll$author = as.factor(menAll$author)
menAllIsolated = sqldf("SELECT account_type, mentioned FROM menAll")
menAllIsolated = sqldf("SELECT DISTINCT * FROM menAllIsolated WHERE account_type IN ('Right', 'Left')")

#Find the Associations with R and D
newsRep = sqldf("SELECT * FROM menAllIsolated WHERE LOWER(mentioned) LIKE LOWER('FoxNews') OR LOWER(mentioned) LIKE LOWER('Forbes') OR LOWER(mentioned) LIKE LOWER('nypost') OR LOWER(mentioned) LIKE LOWER('BreitbartNews') OR LOWER(mentioned) LIKE LOWER('InfoWars') OR LOWER(mentioned) LIKE LOWER('RealClearNews') OR LOWER(mentioned) LIKE LOWER('Drudge') OR LOWER(mentioned) LIKE LOWER('RedState')")
newsDem = sqldf("SELECT * FROM menAllIsolated WHERE LOWER(mentioned) LIKE LOWER('voxdotcom') OR LOWER(mentioned) LIKE LOWER('BuzzFeed') OR LOWER(mentioned) LIKE LOWER('CBSNews') OR LOWER(mentioned) LIKE LOWER('NBCNews') OR LOWER(mentioned) LIKE LOWER('thehill') OR LOWER(mentioned) LIKE LOWER('abcnews') OR LOWER(mentioned) LIKE LOWER('politico') OR LOWER(mentioned) LIKE LOWER('nytimes')")
pplRep = sqldf("SELECT * FROM menAllIsolated WHERE LOWER(mentioned) LIKE LOWER('SenShelby') OR  LOWER(mentioned) LIKE LOWER('lisamurkowski') OR  LOWER(mentioned) LIKE LOWER('SenDanSullivan') OR  LOWER(mentioned) LIKE LOWER('SenJonKyl') OR  LOWER(mentioned) LIKE LOWER('JeffFlake') OR  LOWER(mentioned) LIKE LOWER('SenTomCotton') OR  LOWER(mentioned) LIKE LOWER('JohnBoozman') OR  LOWER(mentioned) LIKE LOWER('SenCoryGardner') OR  LOWER(mentioned) LIKE LOWER('marcorubio') OR  LOWER(mentioned) LIKE LOWER('SenDavidPerdue') OR  LOWER(mentioned) LIKE LOWER('SenatorIsakson') OR  LOWER(mentioned) LIKE LOWER('MikeCrapo') OR  LOWER(mentioned) LIKE LOWER('SenatorRisch') OR  LOWER(mentioned) LIKE LOWER('SenToddYoung') OR  LOWER(mentioned) LIKE LOWER('ChuckGrassley') OR  LOWER(mentioned) LIKE LOWER('joniernst') OR  LOWER(mentioned) LIKE LOWER('SenPatRoberts') OR  LOWER(mentioned) LIKE LOWER('JerryMoran') OR  LOWER(mentioned) LIKE LOWER('SenateMajLdr') OR  LOWER(mentioned) LIKE LOWER('RandPaul') OR  LOWER(mentioned) LIKE LOWER('BillCassidy') OR  LOWER(mentioned) LIKE LOWER('SenJohnKennedy') OR  LOWER(mentioned) LIKE LOWER('SenatorCollins') OR  LOWER(mentioned) LIKE LOWER('SenatorWicker') OR  LOWER(mentioned) LIKE LOWER('RoyBlunt') OR  LOWER(mentioned) LIKE LOWER('SteveDaines') OR  LOWER(mentioned) LIKE LOWER('SenatorFischer') OR  LOWER(mentioned) LIKE LOWER('BenSasse') OR  LOWER(mentioned) LIKE LOWER('SenDeanHeller') OR  LOWER(mentioned) LIKE LOWER('SenatorBurr') OR  LOWER(mentioned) LIKE LOWER('SenThomTillis') OR  LOWER(mentioned) LIKE LOWER('SenJohnHoeven') OR  LOWER(mentioned) LIKE LOWER('SenRobPortman') OR  LOWER(mentioned) LIKE LOWER('SenatorLankford') OR  LOWER(mentioned) LIKE LOWER('SenToomey') OR  LOWER(mentioned) LIKE LOWER('GrahamBlog') OR  LOWER(mentioned) LIKE LOWER('SenatorTimScott') OR  LOWER(mentioned) LIKE LOWER('SenatorRounds') OR  LOWER(mentioned) LIKE LOWER('SenJohnThune') OR  LOWER(mentioned) LIKE LOWER('SenAlexander') OR  LOWER(mentioned) LIKE LOWER('BobCorker') OR  LOWER(mentioned) LIKE LOWER('JohnCornyn') OR  LOWER(mentioned) LIKE LOWER('SenTedCruz') OR  LOWER(mentioned) LIKE LOWER('SenOrrinHatch') OR  LOWER(mentioned) LIKE LOWER('SenMikeLee') OR  LOWER(mentioned) LIKE LOWER('SenCapito') OR LOWER(mentioned) LIKE LOWER('SenRonJohnson') OR  LOWER(mentioned) LIKE LOWER('SenatorEnzi') OR  LOWER(mentioned) LIKE LOWER('SenJohnBarrasso') OR  LOWER(mentioned) = LOWER('POTUS') OR  LOWER(mentioned) = LOWER('FLOTUS') OR  LOWER(mentioned) LIKE LOWER('realDonaldTrump') OR  LOWER(mentioned) = LOWER('VP')")
pplDem = sqldf("SELECT * FROM menAllIsolated WHERE LOWER(mentioned) LIKE LOWER('SenDougJones') OR  LOWER(mentioned) LIKE LOWER('SenFeinstein') OR  LOWER(mentioned) LIKE LOWER('SenKamalaHarris') OR  LOWER(mentioned) LIKE LOWER('SenBennetCO') OR LOWER(mentioned) LIKE LOWER('ChrisMurphyCT') OR LOWER(mentioned) LIKE LOWER('SenBlumenthal') OR LOWER(mentioned) LIKE LOWER('SenatorCarper') OR LOWER(mentioned) LIKE LOWER('ChrisCoons') OR LOWER(mentioned) LIKE LOWER('SenBillNelson') OR LOWER(mentioned) LIKE LOWER('brianschatz') OR LOWER(mentioned) LIKE LOWER('maziehirono') OR LOWER(mentioned) LIKE LOWER('SenDuckworth') OR LOWER(mentioned) LIKE LOWER('SenatorDurbin') OR LOWER(mentioned) LIKE LOWER('SenDonnelly') OR LOWER(mentioned) LIKE LOWER('SenAngusKing') OR LOWER(mentioned) LIKE LOWER('ChrisVanHollen') OR LOWER(mentioned) LIKE LOWER('SenatorCardin') OR LOWER(mentioned) LIKE LOWER('senmarkey') OR LOWER(mentioned) LIKE LOWER('SenWarren') OR LOWER(mentioned) LIKE LOWER('SenGaryPeters') OR LOWER(mentioned) LIKE LOWER('SenStabenow') OR LOWER(mentioned) LIKE LOWER('amyklobuchar') OR LOWER(mentioned) LIKE LOWER('SenTinaSmith') OR LOWER(mentioned) LIKE LOWER('clairecmc') OR LOWER(mentioned) LIKE LOWER('SenatorTester') OR LOWER(mentioned) LIKE LOWER('SenCortezMasto') OR LOWER(mentioned) LIKE LOWER('SenatorShaheen') OR LOWER(mentioned) LIKE LOWER('SenatorHassan') OR LOWER(mentioned) LIKE LOWER('CoryBooker') OR LOWER(mentioned) LIKE LOWER('SenatorMenendez') OR LOWER(mentioned) LIKE LOWER('MartinHeinrich') OR LOWER(mentioned) LIKE LOWER('SenatorTomUdall') OR LOWER(mentioned) LIKE LOWER('SenSchumer') OR LOWER(mentioned) LIKE LOWER('SenGillibrand') OR LOWER(mentioned) LIKE LOWER('SenatorHeitkamp') OR LOWER(mentioned) LIKE LOWER('SenSherrodBrown') OR LOWER(mentioned) LIKE LOWER('RonWyden') OR LOWER(mentioned) LIKE LOWER('SenJeffMerkley') OR LOWER(mentioned) LIKE LOWER('SenBobCasey') OR LOWER(mentioned) LIKE LOWER('SenJackReed') OR LOWER(mentioned) LIKE LOWER('SenWhitehouse') OR LOWER(mentioned) LIKE LOWER('SenatorLeahy') OR LOWER(mentioned) LIKE LOWER('SenatorSanders') OR LOWER(mentioned) LIKE LOWER('timkaine') OR LOWER(mentioned) LIKE LOWER('MarkWarner') OR LOWER(mentioned) LIKE LOWER('PattyMurray') OR LOWER(mentioned) LIKE LOWER('SenatorCantwell') OR LOWER(mentioned) LIKE LOWER('Sen_JoeManchin') OR LOWER(mentioned) LIKE LOWER('SenatorBaldwin') OR LOWER(mentioned) LIKE LOWER('BarackObama') OR LOWER(mentioned) LIKE LOWER('JoeBiden') OR LOWER(mentioned) LIKE LOWER('MichelleObama') OR LOWER(mentioned) LIKE LOWER('HillaryClinton')")

newsRep$Party = "R"
newsDem$Party = "D"
pplRep$Party = "R"
pplDem$Party = "D"

news = rbind(newsRep, newsDem)
people = rbind(pplRep, pplDem)

news = sqldf("SELECT DISTINCT account_type, LOWER(mentioned), Party FROM news")
people = sqldf("SELECT DISTINCT account_type, LOWER(mentioned), Party FROM people")

newsLeft = sqldf("SELECT * FROM news WHERE account_type = 'Left'")
newsRight = sqldf("SELECT * FROM news WHERE account_type = 'Right'")
peopleLeft = sqldf("SELECT * FROM people WHERE account_type = 'Left'")
peopleRight = sqldf("SELECT * FROM people WHERE account_type = 'Right'")

#Network Graph - newsLeft
nL = graph.data.frame(newsLeft, directed = T)
V(nL)$color = ifelse(newsLeft$Party == "R", "red", "lightblue")
plot(nL, vertex.label.color = "black", main = "News Sources Mentioned by Left-Leaning Trolls")

#Network Graph - newsRight
nR = graph.data.frame(newsRight, directed = T)
V(nR)$color = ifelse(newsRight$Party == "R", "red", "lightblue")
plot(nR, vertex.label.color = "black", main = "News Sources Mentioned by Right-Leaning Trolls")

#Network Graph - peopleLeft
pL = graph.data.frame(peopleLeft, directed = T)
V(pL)$color = ifelse(peopleLeft$Party == "R", "red", "lightblue")
plot(pL, vertex.label.color = "black", vertex.label.cex = 0.75, vertex.label.degree = -pi/2,
     edge.arrow.size = 0.3, edge.arrow.width = 0.4, edge.color = "black", margin = 0, main = "US Senators Mentioned by Left-Leaning Trolls")

#Network Graph - peopleRight
pR = graph.data.frame(peopleRight, directed = T)
V(pR)$color = ifelse(peopleRight$Party == "R", "red", "lightblue")
plot(pR, vertex.label.color = "black", vertex.label.cex = 0.7, vertex.label.degree = -pi/2,
     edge.arrow.size = 0.3, edge.arrow.width = 0.4, edge.color = "black", margin = 0, main = "US Senators Mentioned by Right-Leaning Trolls")

#Get Counts
countNewsRight = sqldf("SELECT Party, COUNT(PARTY) FROM newsRight GROUP BY Party")
countNewsLeft = sqldf("SELECT Party, COUNT(PARTY) FROM newsLeft GROUP BY Party")

countPeopleRight = sqldf("SELECT Party, COUNT(PARTY) FROM peopleRight GROUP BY Party")
countPeopleLeft = sqldf("SELECT Party, COUNT(PARTY) FROM peopleLeft GROUP BY Party")
