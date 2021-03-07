%How to clean things :) 
t_Wiz_unclean = readtable('wizkhalifa.csv');
toDelete = (t_Wiz_unclean.("TweetType") == "Retweet");
t_Wiz_unclean(toDelete,:) = [];
t_Wiz_unclean.TweetType = [];

%[m,n] = size(t_Wiz);
% for ii = 1:m
%     if t_Wiz.TweetType(ii) == "Retweet"
%         tableControl.removeRow(ii);
%     end
% end

t_Wiz = t_Wiz_unclean;
    
%Preprocessing tweets
Wiz_tweets = t_Wiz.TweetContent;
clean_Wiz_tweets = eraseURLs(Wiz_tweets);
clean_Wiz_tweets = lower(clean_Wiz_tweets);
clean_Wiz_tweets = strtrim(clean_Wiz_tweets);

%How to make a CLEAN bag
document = tokenizedDocument(clean_Wiz_tweets);
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
%bag = removeWords(bag,["wizkhalifa"]);

mostFreq = topkwords(bag, 20);

wc = wordcloud(bag); %Word Cloud command but don't do this unless
%you want to break your computer LOL
numTopics = 8;
Wiz_topics8 = fitlda(bag,numTopics);

%Perplexity Graph
% figure
% plot(numTopicsRange, validationPerplexity, '+-')
% xlabel("Number of Topics")
% ylabel("Perplexity")


% figure;
% for topicIdx = 1:numTopics
%     subplot(ceil(sqrt(numTopics)), ceil(sqrt(numTopics)), topicIdx)
%     wordcloud(Wiz_topics8,topicIdx);
%     title("Topic:" + topicIdx)
% end
    
%Histogram of 20 most frequent words
figure;
histogram("Categories", cellstr(wc.WordData(1:20)), "BinCounts", wc.SizeData(1:20),...
    "Orientation", "horizontal", "DisplayOrder", "ascend");
title("Wiz's most frequent words")
xlabel("Count")






%%%%%%%%%%%%%%%%%%%%%%%
function_clean_and_read
%function clean_and_read(celebrity)

% Removes retweets and keeps original content
everything_tweets = readtable('wizkhalifa.csv');
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
topics_in_bag = fitlda(bag,numTopics,'Verbose',0);

figure;
histogram("Categories", cellstr(wc.WordData(1:20)), "BinCounts", wc.SizeData(1:20),...
    "Orientation", "horizontal", "DisplayOrder", "ascend");
title("The most frequent words")
xlabel("Count")








%%%%%%Perplexity Graph%%%%%%%%%
% figure
% plot(numTopicsRange, validationPerplexity, '+-')
% xlabel("Number of Topics")
% ylabel("Perplexity")




