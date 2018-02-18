cw1e = load('cw1e.mat');
x = cw1e.x;
y = cw1e.y;
xs1 = linspace(-3, 3, 121)';
xs2 = linspace(-3, 3, 121)';
xs = [xs1,xs2]
mesh(reshape(x(:,1),11,11),reshape(x(:,2),11,11),reshape(y,11,11));



meanfunc = [];
hyp.mean = []
covfunc = @covSEard;      
ell = 1.0; sf = 1.0; hyp.cov = log([ell ell sf]);
%covfunc = @covSum, {@covSEard, @covSEard}}
likfunc = @likGauss;
hyp.lik = 0
hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);


z_abs_max = 10;
z_res = 0.25;
n = (z_abs_max * 2 / z_res) + 1;
z_dim = -z_abs_max:z_res:z_abs_max;
[z1 z2] = meshgrid(z_dim, z_dim);
z = [reshape(z1, [], 1), reshape(z2, [], 1)];


[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, z);
nlml = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y);

%fill3([xs1; flipdim(xs1,1)], [xs2; flipdim(xs2,1)],f, [7 7 7]/8)
%mesh(reshape(xs1(:,1),11,11),reshape(xs2(:,2),11,11),reshape(f,11,11));

mesh(z1, z2, reshape(mu, n, n));

%hold on; 
%plot(xs, mu); 
%plot(x, y, '+')

