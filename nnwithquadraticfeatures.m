function [Theta1 Theta2 o cost cutoff pr] = nnwithquadraticfeatures(hidden_layer_size,iterations,lambda)


load('binaryclean');
out = X(:,2);
m = size(X,1);
load('cleanbinary');
num_labels = 1;

norminp = inp;
norminp(:,44) = inp(:,80);
norminp(:,80) = inp(:,44);
norminp = [norminp mapFeature(inp(:,65),inp(:,66)) mapFeature(inp(:,67),inp(:,68)) mapFeature(inp(:,69),inp(:,70)) mapFeature(inp(:,71),inp(:,72)) mapFeature(inp(:,79),inp(:,81))];

[norminp(:,65:72) mu6572 sigma6572] = featureNormalize(norminp(:,65:72));
[norminp(:,79:end) muend sigmaend] = featureNormalize(norminp(:,79:end));

input_layer_size = size(norminp,2);

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



