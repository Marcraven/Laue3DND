function B=formB(unitcell)

a=unitcell(1); b=unitcell(2); c=unitcell(3);
alpha=unitcell(4)*pi/180; beta=unitcell(5)*pi/180; gamma=unitcell(6)*pi/180;

v = 2*a*b*c*sqrt(sin((alpha+beta+gamma)/2)*sin((-alpha+beta+gamma)/2)* ...
                         sin((alpha-beta+gamma)/2)*sin((alpha+beta-gamma)/2));

astar = (b*c*sin(alpha))/v;
bstar = (a*c*sin(beta))/v;
cstar = (a*b*sin(gamma))/v;

alphastar = acos( (cos(beta)*cos(gamma)-cos(alpha))/(sin(beta)*sin(gamma))  );
betastar  = acos( (cos(alpha)*cos(gamma)-cos(beta))/(sin(alpha)*sin(gamma)) );
gammastar = acos( (cos(alpha)*cos(beta)-cos(gamma))/(sin(alpha)*sin(beta))  );

B(1,1) = astar;
B(1,2) = bstar*cos(gammastar);
B(1,3) = cstar*cos(betastar);
B(2,1) = 0;
B(2,2) = bstar*sin(gammastar);
B(2,3) = -cstar*sin(betastar)*cos(alphastar);
B(3,1) = 0;
B(3,2) = 0;
B(3,3) = 1./c;
