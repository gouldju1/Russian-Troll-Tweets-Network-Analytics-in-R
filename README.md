### Russian Troll Tweets Network Analytics in R

### Description

This is code I wrote for my Master's-level Network Analytics class. The objective was to use the Russian Troll Tweet data from <https://github.com/fivethirtyeight/russian-troll-tweets/>, and derive information using networks. To complete this project, I collaborated with the following students in my MS program: Rachel Spreng, Ian Darling, and Austin Krus.

We answered 2 questions with networks:

1. How do Left- and Right-leaning troll accounts mention news sources in their tweets? Do Left-leaning accounts motivate their base through sharing Left-biased news, or by attacking Right-biased news sources?

2. How do Left- and Right-leaning troll accounts mention US Senators and US government officials in their tweets? Do Left-leaning accounts motivate their base through praising Democrats, or by attacking Republicans?


### Required Packages

The following packages are required to use the K-Means Clustering code: `RCurl`, `sqldf`, `igraph`, `dplyr`.
 
### Interpreting the Results

1. News Sources
	+ Left-leaning troll accounts mention Left-leaning news sources more often than Right-leaning sources. One implication we can draw from this is that the Left-leaning troll accounts "troll" voters more by praising their ideology, instead of bashing the opposite side's beliefs.
	+ Right-leaning troll accounts mention Left-leaning news sources the same as Right-leaning sources. One implication we can draw from this is that the Rightt-leaning troll accounts "troll" voters by equally praising their ideology and bashing the opposite side's beliefs.

2. US Senators and Government Officials 
	+ Left-leaning troll accounts, unlike with the news sources, mention Democratic Senators/government officials more often than Right-leaning sources. One implication we can draw from this is that the Left-leaning troll accounts "troll" voters more by praising officials who carry out their agenda, instead of bashing the opposite side's beliefs.
	+ Right-leaning troll accounts, similar to their approach with the news sources, mention Republican Senators/government officials more often than Right-leaning sources. One implication we can draw from this is that the Left-leaning troll accounts "troll" voters more by praising officials who carry out their agenda, instead of bashing the opposite side's beliefs.