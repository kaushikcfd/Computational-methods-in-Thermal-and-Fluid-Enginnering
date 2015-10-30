clear all;
dt = 0.01;
dx = 0.01;
d = 0.0005*dt/(dx*dx);
x = 0:dx:2;
y = 0:dx:1;
z = 0:dx:1;
[ust1, ust2, ust3, u1, u2, u3, u4, u5, t] = adi(dx,dt);