function r=U2r(U)
%r=U2r(U)
%converts a rotation matrix to a Rodrigues vector.
  dn=1+U(1,1)+U(2,2)+U(3,3);
  

  for i=1:3
    r(i)=0;
    for j=1:3
      for k=1:3
        r(i) = r(i) - epsilon(i,j,k)*U(k,j);
      end
    end
  
    r(i)=r(i)/dn;
    
  end

