function [RotY] = CreateRotY(t)
RotY=[cos(t) 0 sin(t);0 1 0;-sin(t) 0 cos(t)]; %creates a rotation matrix of t radians in the y axis
    

