function [mu sigma] = covariance(X)


[m,n] = size(X);
mu = mean(X);

mumat = ones(m,n);
for i=1:n
	mumat(:,i) =mu(i)*mumat(:,i);
end

d = X-mumat;

sigma = (1/m)*d'*d;
end

