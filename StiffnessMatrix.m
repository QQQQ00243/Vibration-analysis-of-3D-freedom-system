A = [4.5955, 6.0548, 3.4000;
    6.0548, 9.8865, 6.0548;
    3.4000, 6.0548, 4.5955];
A = A .* 1e-6;
K = inv(A);
disp(K);