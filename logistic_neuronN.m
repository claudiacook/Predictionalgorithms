% learning a logistic neuron with sigmoid function
%
% X - features
% Y - labels
% theta_init - initial values of weights
% niter - number of iterations
% learningRate - learning rate
%
% theta - return the learned weights
%
% qwei

%% FOR PROJECT

function theta = logistic_neuron(X,Y,theta_init,niter,learningRate)
for j=1:niter %to loop through niter iterations
    for i=1:200 %for number of training points for 1 iteration
        %a= (X(i,1)*theta_init(1,1))+(X(i,2)*theta_init(1,2))+(X(i,3)*theta_init(1,3)); %calculate neuron potential 
          a= (X(i,1)*theta_init(1,1))+(X(i,2)*theta_init(1,2))+(X(i,3)*theta_init(1,3))...
           +(X(i,4)*theta_init(1,4)) +(X(i,5)*theta_init(1,5))+(X(i,6)*theta_init(1,6))...
            +(X(i,7)*theta_init(1,7))+(X(i,8)*theta_init(1,8))+(X(i,9)*theta_init(1,9))...
            +(X(i,10)*theta_init(1,10)); %calculate neuron potential
        
        t(i,1)=round(sig(a)); %the predicted class is given by the sigmoid function output, which needed
        %to be rounded to given an output of 1 or -1 
        
        %calculate delta thetas for each iterations and update thetas 
%           delta_theta(1,1)= learningRate*(Y(i,1)-t(i,1))*X(i,1)*(dsig(a));
%           delta_theta(1,2)= learningRate*(Y(i,1)-t(i,1))*X(i,2)*(dsig(a));
%           delta_theta(1,3)= learningRate*(Y(i,1)-t(i,1))*X(i,3)*(dsig(a));
            delta_theta(1,1)= learningRate*(Y(i,1)-t(i,1))*X(i,1)*(dsig(a));
            delta_theta(1,2)= learningRate*(Y(i,1)-t(i,1))*X(i,2)*(dsig(a));
            delta_theta(1,3)= learningRate*(Y(i,1)-t(i,1))*X(i,3)*(dsig(a));
            delta_theta(1,4)= learningRate*(Y(i,1)-t(i,1))*X(i,4)*(dsig(a));
            delta_theta(1,5)= learningRate*(Y(i,1)-t(i,1))*X(i,5)*(dsig(a));
            delta_theta(1,6)= learningRate*(Y(i,1)-t(i,1))*X(i,6)*(dsig(a));
            delta_theta(1,7)= learningRate*(Y(i,1)-t(i,1))*X(i,7)*(dsig(a));
            delta_theta(1,8)= learningRate*(Y(i,1)-t(i,1))*X(i,8)*(dsig(a));
            delta_theta(1,9)= learningRate*(Y(i,1)-t(i,1))*X(i,9)*(dsig(a));
            delta_theta(1,10)= learningRate*(Y(i,1)-t(i,1))*X(i,10)*(dsig(a));
        
%           theta_init(1,1)= theta_init(1,1)+delta_theta(1,1);
%           theta_init(1,2)= theta_init(1,2)+delta_theta(1,2);
%           theta_init(1,3)= theta_init(1,3)+delta_theta(1,3);
            theta_init(1,1)= theta_init(1,1)+delta_theta(1,1);
            theta_init(1,2)= theta_init(1,2)+delta_theta(1,2);
            theta_init(1,3)= theta_init(1,3)+delta_theta(1,3);
            theta_init(1,4)= theta_init(1,4)+delta_theta(1,4);
            theta_init(1,5)= theta_init(1,5)+delta_theta(1,5);
            theta_init(1,6)= theta_init(1,6)+delta_theta(1,3);
            theta_init(1,7)= theta_init(1,7)+delta_theta(1,7);
            theta_init(1,8)= theta_init(1,8)+delta_theta(1,8);
            theta_init(1,9)= theta_init(1,9)+delta_theta(1,9);
            theta_init(1,10)= theta_init(1,10)+delta_theta(1,10);
        
        
    
    end
    %after one iteration has passed, save each last theta vector into a new
    %one
    theta(j,1:10)= theta_init;
end 
%after all iterations have occured, keep most recent theta as the output,
%this is the converged theta 
theta= theta(niter,1:10);
end