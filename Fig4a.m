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

for i = 1:3
    h = H(i, i);
    temp = zeros(1, size(ts, 2));
    for j = 1:3
        h_complex = subs(h, w, f_w(j));
        mag = abs(h_complex);
        phase = angle(h_complex);
        temp = temp + mag * f_A(j) * sin(f_w(j)*ts + phase);
    end

    q(i, :) = temp * C(i);
end

for i = 1:3
    subplot(3, 1, i);
    plot(ts, q(i, :));
    temp = "q" + i;
    axis([0, 2*pi, -inf, inf]);
    title(temp);
end
