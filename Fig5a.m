v = [[0.5351, 0.8111, -0.6096]; 
     [0.8455, 0.0000,  0.7422]; 
     [0.5351,-0.8111, -0.6096]];
x0 = 1e-3 * [0.7; 1.0; 0.5];
q0 = v\x0;

M = [1 1 1]; K = 1e6*[0.0733 1.1006 3.9658];
zeta = 0.01;
A = q0 / sqrt(1-zeta^2);
phi = atan(sqrt(1-zeta^2) / zeta);
wn = sqrt(K ./ M);
wd = wn * sqrt(1 - zeta^2);

ts = 0:1e-3:2;
q = zeros(3, size(ts, 2));
for i = 1:3
    scaler = A(i) * exp(-zeta*wn(i)*ts);
    temp = scaler .* sin(wd(i)*ts + phi);
    q(i, :) = temp;
end

for i = 1:3
    subplot(3, 1, i);
    plot(ts, q(i, :));
    temp = "q" + i;
    title(temp);
    axis([0 1 -inf inf]);
end




