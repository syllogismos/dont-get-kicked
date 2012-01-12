function [Theta1 Theta2 o cost cutoff pr] = nntrain(hidden_layer_size,iterations,lambda)

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

initial_Theta1 = randInitializeWeights(input_layer_size,hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size,num_labels);
initial_nn_params = [initial_Theta1(:);initial_Theta2(:)];

options = optimset('MaxIter',iterations);

costFunction = @(p) nnCostFunction(p,...
			input_layer_size,hidden_layer_size,num_labels,...
			norminp,out,lambda);

[nn_params,cost] = fmincg(costFunction,initial_nn_params,options);
%plot(cost);
Theta1 = reshape(nn_params(1:hidden_layer_size*(input_layer_size+1)),...
			hidden_layer_size,(input_layer_size+1));

Theta2 = reshape(nn_params((1+(hidden_layer_size*(input_layer_size+1))):end),...
				num_labels,(hidden_layer_size+1));

o = nnpredict(Theta1,Theta2,norminp);
bb = (111:400)*0.001;
aa = bb;
for i=1:size(bb,2)
	aa(i) = precesionrecall(o>bb(i),out);
end
[pr,b] = max(aa);
cutoff = bb(b);
end
