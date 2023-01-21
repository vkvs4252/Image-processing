function ambe=getAMBE(frameReference,frameUnderTest)
    
%%%%%%%%%%%%%%%%%%%% AMBE %%%%%%%%%%%%%%%%%%%%%%%%%
                 % your original image (rbg2 gray used)
B = rgb2gray(frameUnderTest);;
B2 = rgb2gray(frameReference);
Z1 = mean2(B); 
Z2 = mean2(B2); 
ambe = Z1-Z2; % calculate AMBE

    