%binary clean has the clean version of training in binary format
%clean binary has the mX81 matrix stored in binary
%testbinary has the clean version of test in binary format
%expandedtest has the expanded version of test in binary format
X = load('binaryclean');
m = size(X,1)
out = X(:,2);

inp = binary(X(:,3),3); %auctionbinary
inp = [inp X(:,4)]; %vehage
inp = [inp binary(X(:,5),33)]; %makebinary
inp = [inp binary(X(:,6),2)]; %transmission binary
inp = [inp binary(X(:,7),4)]; %wheeltype binary
inp = [inp X(:,8)]; %vehodo
inp = [inp binary(X(:,9),4)]; %nationality binary
inp = [inp binary(X(:,10),12)]; %size binary
inp = [inp binary(X(:,11),4)]; %topthree american binary
inp = [inp X(:,12:19)]; % all the costs
inp = [inp binary(X(:,20),3)]; % primeunit
inp = [inp binary(X(:,21),3)]; %aucguart
inp = [inp X(:,22:end)]; % remaining variables

% cleanbinary has inp matrix

input_layer_size = 81;
hidden_layer_size = 20;
num_labels = 1;

norminp = inp;
[norminp(:,44) mu44 sigma44] = featureNormalize(inp(:,44));
[norminp(:,65:72) mu6572 sigma6572] = featureNormalize(inp(:,65:72));
[norminp(:,79) mu79 sigma79] = featureNormalize(inp(:,79));
[norminp(:,81) mu81 sigma81] = featureNormalize(inp(:,81));


initial_Theta1 = randInitializeWeights(input_layer_size,hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size,num_labels);
initial_nn_params = [initial_Theta1(:);initial_Theta2(:)];

checkNNGradients;
lambda = 3;
checkNNGradients(lambda);
debug_J = nnCostFunction(nn_params, input_layer_size,hidden_layer_size, ...
			num_labels, norminp, out,lambda);
options = optimset('MaxIter',50);
lambda = 1;
costFunction = @(p) nnCostFunction(p,...
				input_layer_size,hidden_layer_size,...
				num_labels, norminp,out,lambda);
[nn_params,cost] = fmincg(costFunction, initial_nn_params, options);

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));



o = nnpredict(Theta1,Theta2,norminp);
