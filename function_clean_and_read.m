%%%%%%%%%%%%%%%%%%%%%%%
function_clean_and_read
%function clean_and_read(celebrity)

% Removes retweets and keeps original content
everything_tweets = readtable('tweets.csv');
toDelete = (everything_tweets.TweetType == "Retweet");
everything_tweets(toDelete,:) = [];
everything_tweets.TweetType = [];

original_tweets = everything_tweets;

%Pre-processing tweets
original_tweets = original_tweets.TweetContent;
clean_tweets = eraseURLs(original_tweets);
clean_tweets = lower(clean_tweets);
clean_tweets = strtrim(clean_tweets);


%How to make a CLEAN bag
document = tokenizedDocument(clean_tweets);
document = removeStopWords(document);
document = joinWords(document);
at_accounts = contains (document, "@");
at_delete = (at_accounts == true);
document(at_delete, :) = [];
document = tokenizedDocument(document);
document = regexprep(document, '[^A-Za-z\'']', '');
bag = bagOfWords(document);
bag = removeInfrequentWords(bag, 2);
[bag, docsRemoved] = removeEmptyDocuments(bag);


mostFreq = topkwords(bag, 20);

wc = wordcloud(bag); 

numTopics = 8;
topics_in_bag = fitlda(bag,numTopics);

figure;
histogram("Categories", cellstr(wc.WordData(1:20)), "BinCounts", wc.SizeData(1:20),...
    "Orientation", "horizontal", "DisplayOrder", "ascend");
title("The most frequent words")
xlabel("Count")