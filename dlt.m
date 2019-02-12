im = imread('./IMG_5455.JPG');

x = [4.917905405405405e+03;4.868608108108108e+03;4.726878378378378e+03;...
    4.061364864864866e+03;4.030554054054055e+03;3.864175675675676e+03];
y = [5.581756756756758e+02;1.396229729729730e+03;2.456121621621622e+03;...
    5.150405405405404e+02;1.334608108108108e+03;2.382175675675676e+03];

X = [0,0,0,36,36,36];
Y = [72, 36, 0, 72, 36, 0];
Z = [0,0,36,0,0,36];
X_orig = [0];
Y_orig = [0];
Z_orig = [0];

XW_orig = [X_orig;Y_orig;Z_orig;transpose(ones(1,1))];
XI = [transpose(x);transpose(y);transpose(ones(6,1))];
XW = [X;Y;Z;transpose(ones(6,1))];
A = zeros(2*size(XW,2),12);
for i = 1 : size(XW,2)
    A(2*i-1:2*i, :) = [-transpose(XW(:,i)) zeros(1,4) XI(1,i)*transpose(XW(:,i));
                        zeros(1,4) -transpose(XW(:,i)) XI(2,i)*transpose(XW(:,i))];
end
 for i = 1 : 3
    [u,s,v] = svd(A);
    a = [4, 3];
    P = reshape(v(:, 12), a)';
 end
P
proj = P*XW_orig;
proj(1, :) = proj(1, :)./proj(3, :);
proj(2, :) = proj(2, :)./proj(3, :);
imshow(im);
hold on;
plot(proj(1,:), proj(2,:), 'g*');
[Q, W] = qr(inv(P(1:3, 1:3)));
R = inv(Q)
K = inv(W);
K = K/K(3,3)
C = - (inv(R) * inv(K) * P(:, 4))
