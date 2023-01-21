function mse=getMSE(frameReference,frameUnderTest)
    s1=double(frameReference-frameUnderTest).^2;
    s = sum(sum(s1)); 
    sse = s(:,:,1)+s(:,:,2)+s(:,:,3);
    mse  = sse / double(size(frameReference,1)*size(frameReference,2)*size(frameReference,3));
    
    