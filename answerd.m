x = linspace(-5,5,200)'

meanfunc = [];
hyp.mean = [];
%meanfunc = {@meanSum, {@meanLinear, @meanConst}}; hyp.mean = [0.5; 1];
covfunc = {@covProd, {@covPeriodic, @covSEiso}}; 
hyp.cov = [-0.5 0 0 2 0];
likfunc = @likGauss;
hyp.lik = 0;

n = 200;
%x = gpml_randn(0.3, n, 1);
K = feval(covfunc{:}, hyp.cov, x);
%mu = feval(meanfunc{:}, hyp.mean, x);
r = randn(1,1)
y = chol(K+(1e-6*eye(200)))'*gpml_randn(r, n, 1);
%+ mu + exp(hyp.lik)*gpml_randn(0.2, n, 1);

likfunc = @likGauss;
hyp2 = minimize(hyp, @gp, -100, @infGaussLik, [], covfunc, likfunc, x, y);
z = linspace(-5,5,200)'
[mu s2] = gp(hyp2, @infGaussLik, [], covfunc, likfunc, x, y, z);

nlml = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
f = [mu+2*sqrt(s2); flipdim(mu-2*sqrt(s2),1)];
fill([z; flipdim(z,1)], f, [7 7 7]/8)
%fill([xs; flipdim(xs,1)], f, [7 7 7]/8)
hold on;    
plot(z, mu); 
plot(x, y, '+')


plot(x, y, '+')