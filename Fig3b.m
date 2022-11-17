clear;

A = [4.5955, 6.0548, 3.4000;
    6.0548, 9.8865, 6.0548;
    3.4000, 6.0548, 4.5955];
A = A .* 1e-6;
K = inv(A);
M = diag([0.76, 0.79, 0.76]);

syms w

H = inv(K - w^2*M);

H22 = H(2, 2);
W=0:1:2500;            
h22 = subs(H22, w, W);
mag = abs(h22);
phase = angle(h22);   
subplot(2,1,1)
semilogy(W, mag, 'Linewidth', 1.5)     
xlabel('Freq(rad/s)')
ylabel('Magnitude')

subplot(2,1,2)
plot(W, phase, 'Linewidth', 1.5)
axis([-inf, inf, -0.2, pi+0.2]);
xlabel('Freq(rad/s)')
ylabel('Phase(rad)')
set(gca,'YTick',0:pi/2:pi);
set(gca,'YTicklabel',{'0','π/2','π'})


