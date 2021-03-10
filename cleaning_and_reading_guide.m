%We used this one script to practice downloading data and cleaning it for
%a single account before trying to generalize it for all of the accounts

%How to download the table and remove unwanted columns 
t_Wiz_unclean = readtable('wizkhalifa.csv');%reads the raw data table
toDelete = (t_Wiz_unclean.("TweetType") == "Retweet");%find the column 
%"tweetType" and then finds the rows for this column where the tweet type
%is a retweet and then sets it to the variable toDelete
t_Wiz_unclean(toDelete,:) = []; %removes all of the rows that are retweets
t_Wiz_unclean.TweetType = []; %removes the entire column of tweet type since
%that distinction is no longer necessary

t_Wiz = t_Wiz_unclean; %new table made from the changes of the original table
    
%Preprocessing tweets
Wiz_tweets = t_Wiz.TweetContent; %pulls the specific column of information
%that we wanted to work with
clean_Wiz_tweets = eraseURLs(Wiz_tweets);%removes URLS
clean_Wiz_tweets = lower(clean_Wiz_tweets); %converts all letters to lowercase
clean_Wiz_tweets = strtrim(clean_Wiz_tweets); %removes leading and trailing spaces

%How to make a CLEAN bag
document = tokenizedDocument(clean_Wiz_tweets); %detects tokens (in this case
%words) and creates an array with the distinct works
document = removeStopWords(document); %removes articles and other words that
%don't have much meaning for our analysis
document = joinWords(document); %converts all tokens into strings
at_accounts = contains (document, "@"); %checks if a word conatins @
at_delete = (at_accounts == true); %variabe for all words with @
document(at_delete, :) = [];%deletes all words with ats
document = tokenizedDocument(document); %redefining document
document = regexprep(document, '[^A-Za-z\'']', ''); %makes sure to only include letters
bag = bagOfWords(document); %records the number of times a word is used
bag = removeInfrequentWords(bag, 2); %removes all words that occur less than 2 times
[bag, docsRemoved] = removeEmptyDocuments(bag);%creates an array of all of the words
%bag = removeWords(bag,["wizkhalifa"]);

mostFreq = topkwords(bag, 20);%finds the top 20 most used words

subplot(1,2,1);
figure
wordcloud(bag, 'HighlightColor', 'r', 'Color', 'g'); %Word Cloud command
title("Word Cloud")

    
%Histogram of 20 most frequent words
subplot(1,2,2);
figure;
histogram("Categories", cellstr(wc.WordData(1:20)), "BinCounts", wc.SizeData(1:20),...
    "Orientation", "horizontal", "DisplayOrder", "ascend");
title("Wiz's most frequent words")
xlabel("Count")





%%%%%%Perplexity Graph%%%%%%%%%
%we ended up not implimenting this section
% figure
% plot(numTopicsRange, validationPerplexity, '+-')
% xlabel("Number of Topics")
% ylabel("Perplexity")

%Perplexity Graph
% figure
% plot(numTopicsRange, validationPerplexity, '+-')
% xlabel("Number of Topics")
% ylabel("Perplexity")

%numTopics = 8;
%Wiz_topics8 = fitlda(bag,numTopics);

% figure;
% for topicIdx = 1:numTopics
%     subplot(ceil(sqrt(numTopics)), ceil(sqrt(numTopics)), topicIdx)
%     wordcloud(Wiz_topics8,topicIdx);
%     title("Topic:" + topicIdx)
% end



