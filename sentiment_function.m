%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sentiment thingy

% negative words file = 'negative-words.txt'
% positive words file = 'positive-words.txt'

emb = fastTextWordEmbedding;

data = readLexicon;
idx = data.Label == "Positive";
head(data(idx,:))

idx = data.Label == "Negative";
head(data(idx,:))

idx = ~isVocabularyWord(emb,data.Word);
data(idx,:) = [];

numWords = size(data,1);
cvp = cvpartition(numWords,'HoldOut',0.1);
dataTrain = data(training(cvp),:);
dataTest = data(test(cvp),:);

wordsTrain = dataTrain.Word;
XTrain = word2vec(emb,wordsTrain);
YTrain = dataTrain.Label;

mdl = fitcsvm(XTrain,YTrain);

wordsTest = dataTest.Word;
XTest = word2vec(emb,wordsTest);
YTest = dataTest.Label;

[YPred,scores] = predict(mdl,XTest);

figure
confusionchart(YTest,YPred);

function data = readLexicon

%reading positive words
fidPositive = fopen('positive-words.txt');
C = textscan(fidPositive, '%s', 'CommentStyle', ';');
wordsPositive = string(C{1});

%reading negative words
fidNegative = fopen('negative-words.txt');
C = textscan(fidNegative, '%s', 'CommentStyle', ';');
wordsNegative = string(C{1});

%table of labeled words
words = [wordsPositive;wordsNegative];
labels = categorical(nan(numel(words),1));
labels(1:numel(wordsPositive)) = "Positive";
labels(numel(wordsPositive)+1:end) = "Negative";

data = table(words,labels,'VariableNames',{'Word','Label'});




end


