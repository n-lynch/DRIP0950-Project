%How to clean things :) 
t_Wiz_unclean = readtable('tweets.csv');
toDelete = (t_Wiz_unclean.TweetType == "Retweet");
t_Wiz_unclean(toDelete,:) = [];
t_Wiz_unclean.TweetType = [];

%[m,n] = size(t_Wiz);
% for ii = 1:m
%     if t_Wiz.TweetType(ii) == "Retweet"
%         tableControl.removeRow(ii);
%     end
% end
t_Wiz = t_Wiz_unclean;
    
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
bag = removeWords(bag,["wizkhalifa"]);

mostFreq = topkwords(bag, 20);

wc = wordcloud(bag); %Word Cloud command but don't do this unless
%you want to break your computer LOL
numTopics = 8;
Wiz_topics8 = fitlda(bag,numTopics);
% figure;
% for topicIdx = 1:numTopics
%     subplot(ceil(sqrt(numTopics)), ceil(sqrt(numTopics)), topicIdx)
%     wordcloud(Wiz_topics8,topicIdx);
%     title("Topic:" + topicIdx)
% end
    

% figure;
% histogram("Categories", cellstr(wc.document(1:20)), "BinCounts", wc.SizeData(1:20),...
%     "Orientation", "horizontal", "DisplayOrder", "ascend");
% title("Wiz's most frequent words")
% xlabel("Count")
