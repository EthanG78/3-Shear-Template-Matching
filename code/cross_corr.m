function corrImg = cross_corr(img1, img2, display_result)
%CROSS_CORR Perform the frequency domain cross-correlation of two images.
%   corrImg = cross_corr(img1, img2, display_result) computes the 
%   cross-correlation between the provided images, img1 and img2, in 
%   the frequency domain using matrix multiplication. The matrix result, 
%   converted back to the spatial domain is returned. The display_result
%   boolean parameter tells the function to display the resulting
%   spatial domain cross correlation result.
    
    % Pad the smaller image to the size of the larger image
    [img1_M, img1_N] = size(img1);
    [img2_M, img2_N] = size(img2);

    if (img1_M > img2_M && img1_N > img2_N)
        img2_padded = zeros([img1_M, img1_N]);
        img2_padded(1:img2_M, 1:img2_N) = img2(:,:);
        img2 = img2_padded;
    else
        img1_padded = zeros([img2_M, img2_N]);
        img1_padded(1:img1_M, 1:img1_N) = img1(:,:);
        img1 = img1_padded;
    end

    % Represent the images in the frequency domain.
    F_1 = fft2(fftshift(img1));
    F_2 = fft2(fftshift(img2));
    
    % Perform the normalized frequency domain cross-correlation
    G = F_1 .* conj(F_2);
    G = G ./ abs(G);
    
    % Bring the cross-correlation result into the spatial domain.
    corrImg = ifft2(fftshift(G));

    % Optionally display result
    if (display_result)
        figure();
        imagesc((abs((corrImg))));
        colormap(gray);
    end
end