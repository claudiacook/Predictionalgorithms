% learning of a perceptron with step function
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

function theta = perceptron_neuronN(X,Y,theta_init,niter,learningRate)

for j=1:niter %to loop through niter iterations 
    for i=1:684 % for number of training points for 1 iteration
        a= (X(i,1)*theta_init(1,1))+(X(i,2)*theta_init(1,2))+(X(i,3)*theta_init(1,3))...
           +(X(i,4)*theta_init(1,4)) +(X(i,5)*theta_init(1,5))+(X(i,6)*theta_init(1,6))...
            +(X(i,7)*theta_init(1,7))+(X(i,8)*theta_init(1,8))+(X(i,9)*theta_init(1,9))...
            +(X(i,10)*theta_init(1,10)); %calculate neuron potential
        if a >= 0 %if neuron potential is greater than or equal to 0, assign class 1
            t(i,1)=1;
        else %if neuron potential is less than 0, assign class -1
            t(i,1)=0;
        end
        if t(i,1)~= Y(i,1) %if predicted class doesn't equal true class, update weights
            %first delta theta for each theta, and then update each theta 
            delta_theta(1,1)= learningRate*(Y(i,1)-t(i,1))*X(i,1);
            delta_theta(1,2)= learningRate*(Y(i,1)-t(i,1))*X(i,2);
            delta_theta(1,3)= learningRate*(Y(i,1)-t(i,1))*X(i,3);
            delta_theta(1,4)= learningRate*(Y(i,1)-t(i,1))*X(i,4);
            delta_theta(1,5)= learningRate*(Y(i,1)-t(i,1))*X(i,5);
            delta_theta(1,6)= learningRate*(Y(i,1)-t(i,1))*X(i,6);
            delta_theta(1,7)= learningRate*(Y(i,1)-t(i,1))*X(i,7);
            delta_theta(1,8)= learningRate*(Y(i,1)-t(i,1))*X(i,8);
            delta_theta(1,9)= learningRate*(Y(i,1)-t(i,1))*X(i,9);
            delta_theta(1,10)= learningRate*(Y(i,1)-t(i,1))*X(i,10);
            
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

    end
    %after one iteration has passed, save each last theta vector into a new
    %one
    theta(j,1:10)= theta_init;
end

%after all iterations have occured, keep most recent theta as the output,
%this is the converged theta 
theta= theta(niter,1:10);
end

