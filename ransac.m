im = imread('./image.jpg');

arry = [72 36 0];
arrz = [0 36 72 108 144];

ximg = [1.914500e+03 1.690500e+03 1.474500e+03 1.270500e+03 1.070500e+03 8.825000e+02...
    1.926500e+03 1.706500e+03 1.494500e+03 1.290500e+03 1.098500e+03 9.145000e+02...
    1.934500e+03 1.722500e+03 1.514500e+03 1.318500e+03 1.130500e+03 9.465000e+02...
    1.898500e+03 1.670500e+03 1.450500e+03 1.242500e+03 1.046500e+03 8.505000e+02...
    1.850500e+03 1.610500e+03 1.374500e+03 1.154500e+03 9.385000e+02 7.345000e+02];
yimg = [5.145000e+02 5.185000e+02 5.305000e+02 5.305000e+02 5.345000e+02 5.385000e+02...
    7.425000e+02 7.425000e+02 7.425000e+02 7.465000e+02 7.425000e+02 7.425000e+02...
    9.625000e+02 9.585000e+02 9.465000e+02 9.425000e+02 9.385000e+02 9.345000e+02...
    1.082500e+03 1.066500e+03 1.058500e+03 1.050500e+03 1.038500e+03 1.030500e+03...
    1.222500e+03 1.206500e+03 1.190500e+03 1.178500e+03 1.166500e+03 1.154500e+03];

X = [0:3:15 0:3:15 0:3:15 0:3:15 0:3:15];
Y = [6*transpose(ones(6, 1))  3*transpose(ones(6, 1)) transpose(zeros(18, 1))];
Z = [transpose(zeros(18, 1)) 3*transpose(ones(6, 1)) 6*transpose(ones(6, 1))];

XI = [ximg;yimg;transpose(ones(30,1))];
XW = [X;Y;Z;transpose(ones(30,1))];

iter = 250;
theta = 1;
max = 0;

for i = 1 : iter
    r = [randi([1 18], 1, 3) randi([19 30], 1, 3)];
    xi = XI(:,r);
    xw = XW(:,r);
    x = xi(1,:);
    y = xi(2,:);
    z = xi(3,:);
    n = size(xw,2); 
    A = zeros(2*n,12);
    for i = 1 : n 
        A(2*i-1:2*i, :) = [-z(i)*xw(:,i)' zeros(1,4) x(i)*xw(:,i)';
                            zeros(1,4) -z(i)*xw(:,i)' y(i)*xw(:,i)'];
    end
    for i = 1 : 3
        A(i, :) = A(i, :)/norm(A(i, :));
        [u,s,v] = svd(A);
        P = reshape(v(:, 12), [4, 3])';
    end
    proj = P * XW;
    proj_x = rdivide(proj(1, :),proj(3, :));
    proj_y = rdivide(proj(2, :),proj(3, :));
    diffx = proj_x - ximg;
    diffy = proj_y - yimg;
    error_x = (abs(diffx));
    error_y = (abs(diffy));
    error = error_x + error_y;
    t = error < theta;
    num = sum(t);
    if (num > max)
    max = num;
    solution = P;
end 
end
solution
proj = P*XW;
proj(1, :) = proj(1, :)./proj(3, :);
proj(2, :) = proj(2, :)./proj(3, :);
imshow(im);
hold on;
plot(proj(1,:), proj(2,:), 'g*');
plot(ximg,yimg,'ro');
[Q, W] = qr(inv(P(1:3, 1:3)));
R = inv(Q)
K = inv(W);
K = K/K(3,3)
C = - (inv(R) * inv(K) * P(:, 4))

