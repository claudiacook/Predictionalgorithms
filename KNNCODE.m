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

%next is a visual representation of the ages of the participants in this
%study (most of them between 15 and 45)

figure(1)
plot (1:858,X(:,1), '.b')
title('ages of patients')
xlabel('  patient # ')
ylabel(' age')

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


% now, we have to get x_train and x_val and sort the missing values out.
%first, i will calculate the amount of missing values for each attribute

%a returns 1 in the positions where there is a NaN, and 0 where there a
%regular numbers
%missing values returns the number of missing values for each column

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
 
%% -------------------------- KNN ALGORITHM --------------------------
% I will calculate all distances simultaneously, using euclidean distance
% metric

% each column corresponds to the distance of a validation point to each of
% the 684 training points.
%therefore, each row corresponds to the distance of training point to all
%validation points

x = x_train;
y = x_val;
for i= 1:684
    for r= 1:174
        
      D(i,r)= sqrt(((x(i,1)-y(r,1)).^2)+((x(i,2)-y(r,2)).^2)+ ((x(i,3)-y(r,3)).^2)+... 
        ((x(i,4)-y(r,4)).^2)+ ((x(i,5)-y(r,5)).^2) + ((x(i,6)-y(r,6)).^2) + ...
        ((x(i,7)-y(r,7)).^2) + ((x(i,8)-y(r,8)).^2) + ((x(i,9)-y(r,9)).^2) + ((x(i,10)-y(r,10)).^2));
   
    end
end

%This next line will order each column, this is, for each validation point
%will order the distances to training points from smallest to biggest, and
%the indexes of these distances will we stored in variabe I

[orderedcolumns,I] = sort(D);  %smallest value of each column in the first row

%We are interested in the 90 nearest neighbors for each validation point. So this
%next iteration will sort through all 174 validation points, find what is the
%index of the 90 nearest training points, and find the class of each.

%j number of valdiation points = 174

for j = 1:174
for i = 1:90
 class(j,i) = [ y_train(I(i,j))];
end
end

% Now that we have the class of the 90 nearest neighbors, we will assign a
% class for each vaidation point depending on the k (1 to 90)

% we will perform the mode each time to identify the most repeated class.
% if the classes are tied, it will assign the lowest class by default (0 in
% this case)

for j = 1:174
    y_val=[];
    for k = 1:90
    knearest(j,k) = mode(class(j,1:k));
    end
end

%Now we will calculate the mismatch. For each k (1 to 90) we will compare
%the assigned class to the true class, storing a number of errors for each
%k.
%to calculate error percentage we divide the number of errors over the
%total number of validation points.

error = 0;
for k = 1 :90
    for j = 1:174
        if knearest(j,k) ~= truevalues(j,1)
        error = error + 1;
        end
    end
    errorpercentage(k) = (error/174);
    error = 0;
end


[bestk1,indexbestk1] = min(errorpercentage);

figure(2)

k = 1:90;
plot(k,errorpercentage,'-*m');

title('Error percentage for each k (174 validation points)')
xlabel('K')
ylabel('Error percentage')

% apparently the best k = 4, and the same amount of error for bigger k's.

figure(3)

plot(4,errorpercentage(1,4),'-*b');
 
errorfork4 = errorpercentage(1,4);

title('error percentage for k =  4 or bigger')
xlabel('K')
ylabel('Error percentage')