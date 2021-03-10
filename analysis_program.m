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
%array of all of the celebrity csv available 
%had to add in 2 empty names so that the list could be reshaped into 13x4

celebrity_list = reshape(celebrity_list, 13, 4);%reshapes array into 13x4

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

celebrity = celebrity_handle(2:end);%gets rid of the @ so it can be looked up
celebrity_csv = strcat(celebrity, '.csv');%finds the right csv by adding 
%"csv" to the looked up name 

disp("Here is a wordcloud and histogram of the words used most frequently on their account!")

%%%%%%%%%%%%%%%%%%%%%%%

% Removes retweets and keeps original content
everything_tweets = readtable(celebrity_csv,'PreserveVariableNames',true);
%reads in the table of all tweets
toDelete = (everything_tweets.("Tweet Type") == "Retweet");%sets a variable 
%for all of the rows with retweet in the column type
everything_tweets(toDelete,:) = [];%deletes the rows that are retweets
everything_tweets.("Tweet Type") = [];%deletes the column for tweet type 
%since it is no longer needed
original_tweets = everything_tweets;

%Pre-processing tweets
original_tweets = original_tweets.("Tweet Content");%pulls out words from the content column
clean_tweets = eraseURLs(original_tweets);%removes urls
clean_tweets = lower(clean_tweets);%converts everything to lower
clean_tweets = strtrim(clean_tweets);%removes extra spaces


%How to make a CLEAN bag
document = tokenizedDocument(clean_tweets);%detects tokens (in this case
%words) and creates an array with the distinct works
document = removeStopWords(document);%removes articles and other words that
%don't have much meaning for our analysis
document = joinWords(document);%converts all tokens into strings
at_accounts = contains (document, "@");%checks if a word has an @
at_delete = (at_accounts == true);%sets a variable for all words with an @
document(at_delete, :) = [];%deletes all words with an @
document = tokenizedDocument(document);%redefine document as most clean version
document = regexprep(document, '[^A-Za-z\'']', '');%includes only letters
bag = bagOfWords(document);%records the number of times a word is used
bag = removeInfrequentWords(bag, 2);%removes a word if it has been used fewer than 2x
[bag, docsRemoved] = removeEmptyDocuments(bag);%creates an array of all of the words


%Making of the wordclous
mostFreq = topkwords(bag, 20);
wc = wordcloud(bag, 'HighlightColor', '#64A6ED', 'Color', '#ED64C4');

%Making of the histogram
figure;
his = histogram("Categories", cellstr(wc.WordData(1:20)), "BinCounts", wc.SizeData(1:20),...
    "Orientation", "vertical", "FaceColor", "#ED64C4", "DisplayOrder", "ascend");
title(strcat(celebrity + "'s most frequent words"));
xlabel("Count");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







