A = [4.5955, 6.0548, 3.4000;
    6.0548, 9.8865, 6.0548;
    3.4000, 6.0548, 4.5955];
A = A .* 1e-6;
K = inv(A);
M = diag([0.76, 0.79, 0.76]);

[V, D] = eig(M\K);

for i = 1:size(M, 1)
    omega = sqrt(D(i, i));
    vector = V(:, i);
    fprintf("固有频率为：%.5f\n", omega);
    fprintf("对应振型向量为：\n");
    disp(vector);
end