function p = getanamolyprob(X,mu,sigma)


de = sqrt(det(sigma));
[m,n] = size(X);
c = 1/(((2*pi)^(n/2))*de);

mut = ones(m,n);
for i=1:n
	mut(:,i) = mu(i)*mut(:,i);
end

in = inv(sigma);
power = -(1/2)*sum(((X-mut)*in).*(X-mut),2);
p = c*(e.^power);
end
