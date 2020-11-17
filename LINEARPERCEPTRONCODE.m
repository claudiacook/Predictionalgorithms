% BENG420 Homework #2
% learning a perceptron
%
% qwei

close all
clear all
clear all
close

%% -------------------------- DATA --------------------------
filename = 'risk_factors_cervical_cancer.csv';
delimiterIn = ',';
headerlinesIn = 1;
A = importdata(filename,delimiterIn,headerlinesIn);


X = str2double(A.textdata);
% The only data of interest are columns 2-11; these are data on life
% choices.
data = X(:,2:11);

% class labels correspond to attribute 36
T = readtable('risk_factors_cervical_cancer.csv');
classlabels = (T(:,36));

% 684 used as training, 174 as validation

geneexpTrain = data(1:684,:);
Classtrain = table2array(classlabels(1:684,1));

geneexpTest = data(685:858,:);
Classtest = table2array(classlabels(685:858,1));
 
% This is just renaming the values

x_train = geneexpTrain;
y_train = Classtrain;

x_val = geneexpTest;
truevalues = Classtest;



 %% ------------- missing values -------------------
 
 % isnan is a returns a binary matrix, with ones where the missing values
 % where. "missingvaluesTRAIN" contains the sum of all missing value for
 % each column, and then the percentage is calculated.
 
a=isnan(x_train);
missingvaluesTRAIN = sum(a);
percentTRAIN = (missingvaluesTRAIN/684)*100;

%same for the validation set

b=isnan(x_val);
missingvaluesVAL = sum(b);
percentVAL = (missingvaluesVAL/174)*100;

%nanmean will perform the mean of each column ignornig missing values
 y = nanmean(x_train);

%now we replace missing values with the average for the training set

 for j = 1:10
 for i = 1:684
    if x_train(isnan(x_train(i,j)))
        x_train(i,j)=y(j);
    end
 end
 end
 
 %same for validation set

 z = nanmean(x_val);

 for j = 1:10
 for i = 1:174
    if x_val(isnan(x_val(i,j)))
        x_val(i,j)=z(j);
    end
 end
 end
 
 
% randomly initialize the weigth vector
theta0 = rand(1, 10);
 
% cant plot 10 attributes i think
%  % plot the data points
% figure; hold on
% plot(X1(1,:),X1(2,:),'b.');
% plot(X2(1,:),X2(2,:),'r.');
% title('perceptron');
% use the same learning rate for both neurons
learningRate = 1;

% max number of iterations
niter = 500;
X = x_train;
Y = y_train;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOU: call perceptron neuron learning to learn the weights
thetaP = perceptron_neuronN(X,Y,theta0,niter,learningRate);

% YOU: use the learned weights to predict labels of all the training data
error_count=0;

%using the converged theta value, the labels are predicted and the error
%count specified if the predicted class does not equal the true one
for i=1:684
    a= (X(i,1)*thetaP(1,1))+(X(i,2)*thetaP(1,2))+(X(i,3)*thetaP(1,3))...
        +(X(i,4)*thetaP(1,4)) +(X(i,5)*thetaP(1,5))+(X(i,6)*thetaP(1,6))...
            +(X(i,7)*thetaP(1,7))+(X(i,8)*thetaP(1,8))+(X(i,9)*thetaP(1,9))...
            +(X(i,10)*thetaP(1,10));
    if a >= 0
        t(i,1)=1;
    else 
        t(i,1)=0;
    end
    
     if t(i,1)~= Y(i,1)
         error_count= error_count+1;
         
     end 
end 

% YOU: print the training accuracy
%training accuracy given by 1 minus the error percentage 
training_accuracy= 100*(1-(error_count/length(X)));
fprintf('Training Accuracy of Perceptron Neuron: %.2f', training_accuracy);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOU: call logistic neuron learning to learn the weights
thetaL = logistic_neuronN(X,Y,theta0,niter,learningRate);

% YOU: use the learned weights to predict labels of all the training data
training_accuracy= 0;
error_count=0;
%using the converged learned weights given by thetaL, this goes through
%each point to predict the class and calculate the amount of incorrect
%classifications
 for i=1:200
%         a= (X(i,1)*thetaL(1,1))+(X(i,2)*thetaL(1,2))+(X(i,3)*thetaL(1,3));
%         t(i,1)=round(sig(a));
a= (X(i,1)*thetaL(1,1))+(X(i,2)*thetaL(1,2))+(X(i,3)*thetaL(1,3))...
        +(X(i,4)*thetaL(1,4)) +(X(i,5)*thetaL(1,5))+(X(i,6)*thetaL(1,6))...
            +(X(i,7)*thetaL(1,7))+(X(i,8)*thetaL(1,8))+(X(i,9)*thetaL(1,9))...
            +(X(i,10)*thetaL(1,10));
        
        if t(i,1)~= Y(i,1)
         error_count= error_count+1;
         
        end 
 end 

% YOU: print the training accuracy
training_accuracy= 100*(1-(error_count/length(X)));
fprintf('\nTraining Accuracy of Logistic Neuron: %.2f', training_accuracy);
