celebrity_list = ["@youtube", "@twitter", "@theellenshow", "@taylorswift13", "@srbachchan", ...
    "@shakira", "@sportscenter", "@realmadrid", "@realdonaldtrump", "@pink", ...
    "@oprah", "@nytimes", "@nasa", "@narendramodi", "@niallofficial", ...
    "@neymarjr", "@kingjames", "@liampayne", "@liltunechi", "@louis_tomlinson", ...
    "@kevinhart4real", "@katyperry", "@justinbieber", "@jtimberlake", "@brunomars", ...
    "@selenagomez", "@ladygaga", "@jlo", "@jimmyfallon", "@instagram", ...
    "@imvkohli", "@iamsrk", "@harry_styles", "@britneyspears", "@rihanna", ...
    "@espn", "@cristiano", "@mileycyrus", "@drake", "@wizkhalifa", ...
    "@cnn", "@cnnbrk", "@billgates", "@kimkardashian", "@arianagrande", ...
    "@akshaykumar", "@barackobama", "@beingsalmankhan", "@bbcbreaking", "@fcbarcelona", "", ""];

celebrity_list = reshape(celebrity_list, 13, 4);

disp("Hi! Welcome!")
disp("We've created this project so you can see the analyses of popular twitter accounts' tweets!");
disp("Here are the handles of the 50 celebrity twitters you have to choose from:")
fprintf('\n') 
disp(celebrity_list);


Question = "Which celebrity twitter account do you want more information on? \nPlease type in their FULL handle here: ";
celebrity_handle = input(Question, 's');
while celebrity_handle ~= celebrity_list(:)
    Question2 = "I'm sorry, that @ is not in our list. Which account would you like to look into?";
    celebrity_handle = input(Question2, 's');
end

celebrity = celebrity_handle(2:end);
celebrity_csv = strcat(celebrity, '.csv');


%%%%%%%%%%%%%%%%%%%%%%%
%function_clean_and_read
%function clean_and_read(celebrity)

% Removes retweets and keeps original content
everything_tweets = readtable(celebrity_csv);
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


%Making of the wordclous
mostFreq = topkwords(bag, 20);
wc = wordcloud(bag); 

numTopics = 8;
topics_in_bag = fitlda(bag,numTopics,'Verbose',0);

%Making of the histogram
figure;
his = histogram("Categories", cellstr(wc.WordData(1:20)), "BinCounts", wc.SizeData(1:20),...
    "Orientation", "vertical", "FaceColor", "#92ba70", "DisplayOrder", "ascend");
title("The most frequent words");
xlabel("Count");