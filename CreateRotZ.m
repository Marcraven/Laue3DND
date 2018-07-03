function [RotZ] = CreateRotZ(t)
RotZ=[cos(t) -sin(t) 0;sin(t) cos(t) 0;0 0 1]; %creates a rotation matrix of t radians around the Z axis (right handed)
    

