function [RotX] = CreateRotX(t)
RotX=[1 0 0; 0 cos(t) -sin(t); 0 sin(t) cos(t)]; %creates a rotation matrix of t radians around the X axis (right handed)
    

