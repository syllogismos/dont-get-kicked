function [J grad] = nn2CostFunction(nn_params,...
					input_layer_size,...
					hidden_layer_1,...
					hidden_layer_2,...
					num_labels,...
					X,y,lambda)
Theta1 = reshape(nn_params(1:hidden_layer_1*(input_layer_size+1)),...
		hidden_layer_1,(input_layer_size + 1));


t = (hidden_layer_2*(hidden_layer_1+1)) + (hidden_layer_1*(input_layer_size+1));
Theta2 = reshape(nn_params((1+(hidden_layer_1*(input_layer_size +1))):t),...
			hidden_layer_2,(hidden_layer_1+1));

Theta3 = reshape(nn_params(t+1:end),num_labels,(hidden_layer_2+1));

m = size(X,1);

X = [ones(m,1) X];
ymat = zeros(m,num_labels);
%for i = 1:m
%	ymat(i,y(i)) = 1;
%end
minusymat = 1-ymat;

z2 = X*Theta1';
a2 = sigmoid(z2);
a2 = [ones(m,1) a2];
%size(a2)
%size(Theta2)

z3 = a2*Theta2';
a3 = sigmoid(z3);
a3 = [ones(m,1) a3];

z4 = a3*Theta3';
a4 = sigmoid(z4);
logout = log(a4);
minuslog = log(1-a4);

delta4 = a4 - ymat;
delta3 = (delta4*Theta3).*(a3.*(1-a3));
del3 = delta3(:,2:end);
%size(delta3)
delta2 = (del3*Theta2).*(a2.*(1-a2));%(a2'.*(1-a2'));


ones1 = ones(size(Theta1,1),((size(Theta1,2))-1));
ones1 = [zeros(size(ones1,1),1) ones1];
%regTheta1 = lambda*Theta1;

ones2 =  ones(size(Theta2,1),((size(Theta2,2))-1));
ones2 = [zeros(size(ones2,1),1) ones2];
%regTheta2 = lambda*Theta2;

ones3 =  ones(size(Theta3,1),((size(Theta3,2))-1));
ones3 = [zeros(size(ones3,1),1) ones3];
%regTheta2 = lambda*Theta2;

Theta1_grad = ((delta2(:,2:end)'*X) + (lambda*(Theta1.*ones1)))/m;
Theta2_grad = ((delta3(:,2:end)'*a2) + (lambda*(Theta2.*ones2)))/m;
Theta3_grad = ((delta4'*a3) + (lambda*(Theta3.*ones3)))/m;

J = (-1)*(1/m)*(sum(sum(logout.*ymat+minuslog.*minusymat)));

t1 = sum(Theta1.^2);t1 = sum(t1)-t1(1);
t2 = sum(Theta2.^2);t2 = sum(t2)-t2(1);
t3 = sum(Theta3.^2);t3 = sum(t3)-t3(1);
J = J+(lambda/(2*m))*(t1+t2+t3);


grad = [Theta1_grad(:);Theta2_grad(:);Theta3_grad(:)];

end
