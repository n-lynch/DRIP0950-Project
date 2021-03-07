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
disp(celebrity_csv);