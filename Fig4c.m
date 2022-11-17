clear;

M = diag([1., 1., 1.]);
D = diag([5.4162, 20.982, 39.928]);
K = 1e6 * diag([0.0733, 1.1006, 3.9658]);

syms w
Z = K - w^2*M + D*1i;
H = inv(Z);

C = [0.8455, 0., 0.7422];
f_w = [15, 370, 600];
f_A = [206, 204, 204];

ts = 0:0.01:2*pi;
q = zeros(3, size(ts, 2));
dq = zeros(3, size(ts, 2));
ddq = zeros(3, size(ts, 2));

for i = 1:3
    h = H(i, i);
    temp = zeros(1, size(ts, 2));
    dtemp = zeros(1, size(ts, 2));
    ddtemp = zeros(1, size(ts, 2));
    for j = 1:3
        h_complex = subs(h, w, f_w(j));
        mag = abs(h_complex);
        phase = angle(h_complex);
        temp = temp + mag * f_A(j) * sin(f_w(j)*ts + phase);
        dtemp = dtemp + mag * f_A(j) * f_w(j) * cos(f_w(j)*ts + phase);
        ddtemp = ddtemp - mag * f_A(j) * f_w(j)^2 * sin(f_w(j)*ts + phase);
    end
    q(i, :) = temp * C(i);
    dq(i, :) = dtemp * C(i);
    ddq(i, :) = ddtemp * C(i);
end

v = [[0.5351, 0.8111, -0.6096]; [0.8455, 0.0000,  0.7422]; [0.5351,-0.8111, -0.6096]];
x = v*q;
dx = v*dq;
ddx = v*ddq;

subplot(3, 1, 1);
plot(ts, x(2, :));
title('$$x_2(t)$$', 'interpreter', 'latex')
axis([0 2*pi -inf inf]);

subplot(3, 1, 2);
plot(ts, dx(2, :));
title('$$\dot{x}_2(t)$$', 'interpreter', 'latex')
axis([0 2*pi -inf inf]);

subplot(3, 1, 3);
plot(ts, ddx(2, :));
title('$$\ddot{x}_2(t)$$', 'interpreter', 'latex')
axis([0 2*pi -inf inf]);



