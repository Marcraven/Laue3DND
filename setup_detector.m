function D=setup_detector
%% Detector parameters D is detector parameter
D(1).normal=[1 0 0]; %Vector normal to the detector plane (100 is backdiffraction -100 is forward diffraction)
D(1).tilt=[0 0 0]; %detector tilts on the x y and z axis guess [rad]
D(1).tilttol=repmat(deg2rad(2),1,3);
D(1).side=400; %side of a square deetector [mm]
D(1).hole=22; %diameter of the hole [mm]
D(1).pos=[-159.88 0 0]; %detector position with respect the rotation axis [mm]. Negative is backdiffraction.
D(1).lpostol=D(1).pos-1;
D(1).upostol=D(1).pos+1;
% D(1).lpostol(3)=[];
% D(1).upostol(3)=[];

D(2).normal=[-1 0 0]; %Vector normal to the detector plane (100 is backdiffraction -100 is forward diffraction)
D(2).tilt=[0 0 0]; %detector tilts on the x y and z axis guess [rad]
D(2).tilttol=repmat(deg2rad(2),1,3);
D(2).side=400; %side of a square deetector [mm]
D(2).hole=100; %diameter of the hole [mm]
D(2).pos=[159.02 0 1]; %detector position with respect the rotation axis [mm]. Positive is forward diffraction.
D(2).lpostol=D(2).pos-1;
D(2).upostol=D(2).pos+1;

