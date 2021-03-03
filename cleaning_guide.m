%How to clean things :) 
t_Wiz = readtable('tweets.csv');
Wiz_tweets = t_Wiz.TweetContent;
clean_Wiz_tweets = eraseURLs(Wiz_tweets);
clean_Wiz_tweets = erasePunctuation(clean_Wiz_tweets);
clean_Wiz_tweets = regexprep(clean_Wiz_tweets, '[^A-Za-z\'']', ' ');
clean_Wiz_tweets = lower(clean_Wiz_tweets);
clean_Wiz_tweets = strtrim(clean_Wiz_tweets);

%How to make a CLEAN bag
document = tokenizedDocument(clean_Wiz_tweets);
document = removeStopWords(document);
bag = bagOfWords(document);
bag = removeInfrequentWords(bag, 2);
[bag, docsRemoved] = removeEmptyDocuments(bag);


%figure = wordcloud(bag) <-- Word Cloud command but don't do this unless
%you want to break your computer LOL
