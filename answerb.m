 cw1a = load('cw1a.mat');
xs = linspace(-3, 3, 61)';  
x = cw1a.x;
y = cw1a.y;
meanfunc = [];
%covfunc = @covSEiso;
covfunc = @covPeriodic
likfunc = @likGauss;
hyp = struct('mean', [], 'cov', [0 0 0], 'lik', 0);
hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
% hyp2.lik
% sd = exp(hyp2.lik);
% err = ones(75,1)*sd*2   
% errorbar(y,err)

[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);
f = [mu+2*sqrt(s2); 
flipdim(mu-2*sqrt(s2),1)];
fill([xs; flipdim(xs,1)], f, [7 7 7]/8)
hold on; 
plot(xs, mu); 
plot(x, y, '+')
