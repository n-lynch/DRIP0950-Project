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

%Welcome message, shows 50 celebrity handles
disp("Hi! Welcome!")
disp("We've created this project so you can see the analyses of popular twitter accounts' tweets!");
disp("The dataset we're using includes over 3200 tweets of every twitter account it has to offer!");
disp("Here are the handles of the 50 celebrity twitters you have to choose from:")
fprintf('\n') 
disp(celebrity_list);

%Asks user for input, if not on the list it will ask you again
Question = "Which celebrity twitter account do you want more information on? \nPlease type in their FULL handle here including the '@' symbol: ";
celebrity_handle = input(Question, 's');
while celebrity_handle ~= celebrity_list(:)
    Question2 = "I'm sorry, that @ is not in our list. Which account would you like to look into? ";
    celebrity_handle = input(Question2, 's');
end

celebrity = celebrity_handle(2:end);
celebrity_csv = strcat(celebrity, '.csv');

disp("Here is a wordcloud and histogram of the words used most frequently on their account!")

%%%%%%%%%%%%%%%%%%%%%%%

% Removes retweets and keeps original content
everything_tweets = readtable(celebrity_csv,'PreserveVariableNames',true);
toDelete = (everything_tweets.("Tweet Type") == "Retweet");
everything_tweets(toDelete,:) = [];
everything_tweets.("Tweet Type") = [];
original_tweets = everything_tweets;

%Pre-processing tweets
original_tweets = original_tweets.("Tweet Content");
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
wc = wordcloud(bag, 'HighlightColor', '#64A6ED', 'Color', '#ED64C4');

numTopics = 8;
topics_in_bag = fitlda(bag,numTopics,'Verbose',0);

%Making of the histogram
figure;
his = histogram("Categories", cellstr(wc.WordData(1:20)), "BinCounts", wc.SizeData(1:20),...
    "Orientation", "vertical", "FaceColor", "#ED64C4", "DisplayOrder", "ascend");
title("The most frequent words");
xlabel("Count");









