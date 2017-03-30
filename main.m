%% Programm by Guillaume ERHARD, based on the work of Andrew Ng for his
%  machine learning coursera class
% 
%  ------------
%  This project is a continuation of an exercide from the coursera course
%  of Andrew Ng on machine learning I took last summer. 

%  In this programm I will test the impact of the numbers of hidden layer 
%  from a Neural Network and measure the impact on his performance. And
%  also the effect of long training sessions.

 
%  Don't forget you can skip the long calculation and look directly on the 
%  result that can be seen with the visualisation.m programm or on the 
%  github repository.
%  ------------



%% Initialization
clear ; close all; clc



%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset. 
%  You will be working with a dataset that contains handwritten digits.
%

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

load('ex4data1.mat');
m = size(X, 1);

% Randomly select 100 data points to display
sel = randperm(size(X, 1));
sel = sel(1:100);

displayData(X(sel, :));

fprintf('Program paused. Press enter to continue.\n');






%% Setup the parameters you will use for this exercise

input_layer_size  = 400;  % 20x20 Input Images of Digits
min_hidden_layer_size = 20;   
max_hidden_layer_size = 20;
num_labels = 10;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)
num_iter = 5000;                          
                          




%% Try boucle 
options = optimset('MaxIter', 1); % sinon multiple coup

for hidden_layer_size = min_hidden_layer_size:5:max_hidden_layer_size


%  You should also try different values of lambda if you want
lambda = 0.6; 

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

tic;
Prediction = zeros(num_iter,1);
for i = 1:num_iter
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

initial_nn_params = nn_params;

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
             
pred = predict(Theta1, Theta2, X);
Prediction(i) = mean(double(pred == y)) * 100;
fprintf('\nSize : %f \nTraining Set Accuracy: %f',hidden_layer_size,Prediction(i));

toc;
end
filename = ['theta_size_' num2str(hidden_layer_size) '_5000i' '.mat'];
save(filename,'nn_params');
filename = ['pred_size_' num2str(hidden_layer_size) '_5000i' '.mat'];
save(filename,'Prediction');


end

input_layer_size  = 400;  % 20x20 Input Images of Digits
min_hidden_layer_size = 25;   
max_hidden_layer_size = 25;
num_labels = 10;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)
num_iter = 200;                          
                          
%% Try boucle 

for a=1:10



% If you don't want to see the effect after each iteration modify here
options = optimset('MaxIter', 1); 

for hidden_layer_size = min_hidden_layer_size:5:max_hidden_layer_size


%  You should also try different values of lambda
lambda = 0.6; 

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

tic;
Prediction = zeros(num_iter,1);
for i = 1:num_iter
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

initial_nn_params = nn_params;

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
             
pred = predict(Theta1, Theta2, X);
Prediction(i) = mean(double(pred == y)) * 100;
fprintf('\nSize : %f \nTraining Set Accuracy: %f',hidden_layer_size,Prediction(i));

toc;
end
filename = ['theta_size_' num2str(hidden_layer_size) '_200i_v_' num2str(a) '.mat'];
save(filename,'nn_params');
filename = ['pred_size_' num2str(hidden_layer_size) '_200i_v_' num2str(a) '.mat'];
save(filename,'Prediction');


end

end