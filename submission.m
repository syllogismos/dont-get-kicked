function [sub] = submission(T1,T2)

load('testbinary');
load('expandedtest');
load('musigma');


normti = ti;
[normti(:,44)] = normalize(ti(:,44),mu44,sigma44);
[normti(:,65:72)] = normalize(ti(:,65:72),mu6572,sigma6572);
[normti(:,79)] = normalize(ti(:,79), mu79, sigma79);
[normti(:,81)] = normalize(ti(:,81), mu81, sigma81);

x = nnpredict(T1,T2,normti);
sub = [test(:,1) x];
end
