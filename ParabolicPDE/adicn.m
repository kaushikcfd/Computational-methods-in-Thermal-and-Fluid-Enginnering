function [ust1, ust2, ust3, u1, u2, u3, u4, u5, t] = adicn(dx,dt)
t = 0;
u1 = zeros(10000,1);
u2 = zeros(10000,1);
u3 = zeros(10000,1);
u4 = zeros(10000,1);
u5 = zeros(10000,1);
x = 0:dx:2;
y = 0:dx:1;
z = 0:dx:1;
ust1 = zeros(size(y,2),size(z,2));
ust2 = zeros(size(x,2),size(z,2));
ust3 = zeros(size(x,2),size(y,2));
d = 0.0005*dt/(dx*dx);
u = 300*ones(size(x,2),size(y,2),size(z,2));
for i=1:size(y,2)
    for j=1:size(z,2)
        u(1,i,j) = 100;
        u(size(x,2),i,j) = 500;
    end
end
for i=1:size(x,2)
    for j=1:size(z,2)
        u(i,1,j) = 300;
        u(i,size(y,2),j) = 600;
    end
end
for i=1:size(x,2)
    for j=1:size(y,2)
        u(i,j,1) = 500;
        u(i,j,size(z,2)) = 2000;
    end
end
u_prev = u;
u = zeros(size(x,2),size(y,2),size(z,2));
err = 2;
while(err>1)
    t = t + 1;
    u1(t,1) = u_prev(1 + 0.5/dx, 1 + 0.25/dx, 1 + 0.25/dx);
    u2(t,1) = u_prev(1 + 1.0/dx, 1 + 0.5/dx, 1 + 0.5/dx);
    u3(t,1) = u_prev(1 + 1.5/dx, 1 + 0.75/dx, 1 + 0.75/dx);
    u4(t,1) = u_prev(1 + 0.5/dx, 1 + 0.5/dx, 1 + 0.5/dx);
    u5(t,1) = u_prev(1 + 1.0/dx, 1 + 0.75/dx, 1 + 0.75/dx);
    for i=1:size(y,2)
        for j=1:size(z,2)
            u(1,i,j) = 100;
            u(size(x,2),i,j) = 500;
        end
    end
    for i=1:size(x,2)
        for j=1:size(z,2)
            u(i,1,j) = 300;
            u(i,size(y,2),j) = 600;
        end
    end
    for i=1:size(x,2)
        for j=1:size(y,2)
            u(i,j,1) = 500;
            u(i,j,size(z,2)) = 2000;
        end
    end
    for i = 2:size(x,2)-1
        for j = 2:size(y,2)-1
            for k = 2:size(z,2)-1
                u(i,j,k) = u_prev(i,j,k) + (d/3)*(u_prev(i+1,j,k) + u_prev(i-1,j,k) + u_prev(i,j+1,k) + u_prev(i,j-1,k) + u_prev(i,j,k+1) + u_prev(i,j,k-1) - 6*u_prev(i,j,k));
                u_prev(i,j,k) = u(i,j,k) + (d/3)*(u(i+1,j,k) + u(i-1,j,k) + u(i,j+1,k) + u(i,j-1,k) + u(i,j,k+1) + u(i,j,k-1) - 6*u(i,j,k));
                u(i,j,k) = u_prev(i,j,k) + (d/3)*(u_prev(i+1,j,k) + u_prev(i-1,j,k) + u_prev(i,j+1,k) + u_prev(i,j-1,k) + u_prev(i,j,k+1) + u_prev(i,j,k-1) - 6*u_prev(i,j,k));
            end
        end
    end
   err = max(max(max(abs(u - u_prev))));
   disp(err);
   u_prev = u;
end
for i=1:size(y,2)
    for j=1:size(z,2)
        ust1(i,j) = u(1 + 1.0/dx, i ,j);
    end
end

for i=1:size(x,2)
    for j=1:size(z,2)
        ust2(i,j) = u(i, 1 + 0.5/dx, j);
    end
end
for i=1:size(x,2)
    for j=1:size(y,2)
        ust3(i,j) = u(i, j, 1 + 1.0/dx);
    end
end
end