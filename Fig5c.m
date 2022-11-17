v = [[0.5351, 0.8111, -0.6096]; 
     [0.8455, 0.0000,  0.7422]; 
     [0.5351,-0.8111, -0.6096]];
x0 = 1e-3 * [0.7; 1.0; 0.7];
q0 = v\x0;

M = [1 1 1]; K = 1e6*[0.0733 1.1006 3.9658];
zeta = 0.01;
A = q0 / sqrt(1-zeta^2);
phi = atan(sqrt(1-zeta^2) / zeta);
wn = sqrt(K ./ M);
wd = wn * sqrt(1 - zeta^2);

ts = 0:1e-3:0.5;
q = zeros(3, size(ts, 2));
Dq = zeros(3, size(ts, 2));
DDq = zeros(3, size(ts, 2));

syms t

for i = 1:3
    scaler = A(i) * exp(-zeta*wn(i)*t);
    fun = scaler * sin(wd(i)*t + phi);
    q(i, :) = subs(fun, t, ts);

    Dq_syms = diff(fun, t);
    Dq(i, :) = subs(Dq_syms, t, ts);

    DDq_syms = diff(fun, t, 2);
    DDq(i, :) = subs(DDq_syms, t, ts);
end

x = v*q;
Dx = v*Dq;
DDx = v*DDq;

subplot(311)
plot(ts, x(2, :))
title('$$x_2(t)$$', 'interpreter', 'latex')
subplot(312)
plot(ts, Dx(2, :))
title('$$\dot{x}_2(t)$$', 'interpreter', 'latex')
subplot(313)
plot(ts, DDx(2, :))
title('$$\ddot{x}_2(t)$$', 'interpreter', 'latex')


