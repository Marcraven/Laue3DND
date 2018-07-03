function result=epsilon(i,j,k)

    result=0;

    if ( (i==1 && j==2 && k==3) || (i==2 && j==3 && k==1) || (i==3 && j==1 && k==2) ) 
        result= 1;
    end

    if ( (i==1 && j==3 && k==2) || (i==3 && j==2 && k==1) || (i==2 && j==1 && k==3) ) 
        result=-1;
    end

    