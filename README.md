# DRIP0950-Project

![](GroupProject.gif)

This code uses the Text Analytics toolbox to provide several outputs from select profiles in a public data set of the 50 most followed Twitter accounts and 3200 tweets from each account. That data set is available here (1).  We used the Text Analytics toolbox to determine the most frequently used words (excluding common words such as ‘the, a, and, it’ etc.) and display those words in both a word cloud and a histogram. 

Additionally, we used sentiment analysis by training a sentiment lexicon (2) in order to return two word clouds displaying predicted positive and negatively correlated words from any of the selected Twitter profiles. 

The script ‘analysis_program.m’ will display an initial welcome message with a list of the 50 available Twitter profiles to choose from. Upon inputting the desired handle, a figure containing a word cloud and histogram for the most frequently used words, and word clouds for positive and negatively correlated words will be displayed. The script can be run for any of the 50 profiles available in the dataset and listed in the script. 


(1) https://drive.google.com/drive/folders/11w4geFB6p17hFlWseBpHJQbhARINvTOc

(2) https://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html
