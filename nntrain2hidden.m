function [Theta1 Theta2 Theta3 o cost cutoff pr] = nntrain2hidden(hidden1,hidden2,iterations,lambda)

load('cleanbinary');%input matrix is stored in inp
load('trainingy'); % has the y matrix of the training isbadbuy in "out"
m = size(inp,1);
load('binaryclean');

out = X(:,2);

input_layer_size = 81;
num_labels = 1;

norminp = inp;
[norminp(:,44) mu44 sigma44] = featureNormalize(inp(:,44));
[norminp(:,65:72) mu6572 sigma6572] = featureNormalize(inp(:,65:72));
[norminp(:,79) mu79 sigma79] = featureNormalize(inp(:,79));
[norminp(:,81) mu81 sigma81] = featureNormalize(inp(:,81));

initial_Theta1 = randInitializeWeights(input_layer_size,hidden1);
initial_Theta2 = randInitializeWeights(hidden1,hidden2);
initial_Theta3 = randInitializeWeights(hidden2,num_labels);
initial_nn_params = [initial_Theta1(:);initial_Theta2(:);initial_Theta3(:)];

options = optimset('MaxIter',iterations);
printf('start');
costFunction = @(p) nn2CostFunction(p,...
			input_layer_size,hidden1,hidden2,num_labels,...
			norminp,out,lambda);

[nn_params,cost] = fmincg(costFunction,initial_nn_params,options);
%plot(cost);


Theta1 = reshape(nn_params(1:hidden1*(input_layer_size+1)),...
		hidden1,(input_layer_size + 1));


t = (hidden2*(hidden1+1)) + (hidden1*(input_layer_size+1));
Theta2 = reshape(nn_params((1+(hidden1*(input_layer_size +1))):t),...
			hidden2,(hidden1+1));

Theta3 = reshape(nn_params(t+1:end),num_labels,(hidden2+1));


o = predict2hidden(Theta1,Theta2,Theta3,norminp);
bb = (111:400)*0.001;
aa = bb;
for i=1:size(bb,2)
	aa(i) = precesionrecall(o>bb(i),out);
end
[pr,b] = max(aa);
cutoff = bb(b);
end

