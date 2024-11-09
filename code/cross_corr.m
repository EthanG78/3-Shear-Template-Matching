function corrImg = cross_corr(img1, img2)
%CROSS_CORR Perform the frequency domain cross-correlation of two images.
%   corrImg = cross_corr(img1, img2) computes the cross-correlation between
%   the provided images, img1 and img2, in the frequency domain using
%   matrix multiplication. The matrix result, converted back to the spatial
%   domain is returned.

    % Pad the images to 2 times the size of the larger image.
    img1_size = size(img1);
    img2_size = size(img2);
    
    pad_size = 2 * img1_size - 1;
    if (img2_size > img1_size)
        pad_size = 2 * img2_size - 1;
    end
    
    half_size1 = floor(img1_size / 2);
    half_size2 = floor(img2_size / 2);

    img1_pad = zeros(pad_size);
    img2_pad = zeros(pad_size);

    half_pad_size = floor(pad_size / 2);

    % Correction indexing factor for if images are even or odd sizes.
    correction1 = [0 0];
    correction2 = [0 0];
    if (mod(img1_size(1), 2) == 0)
        correction1(1) = 1;
    end

    if (mod(img1_size(2), 2) == 0)
        correction1(2) = 1;
    end
    
    if (mod(img2_size(1), 2) == 0)
        correction2(1) = 1;
    end
    
    if (mod(img2_size(2), 2) == 0)
        correction2(2) = 1;
    end

    img1_pad(half_pad_size(1)-half_size1(1):half_pad_size(1)+half_size1(1)-correction1(1),half_pad_size(2)-half_size1(2):half_pad_size(2)+half_size1(2)-correction1(2)) = img1;
    img2_pad(half_pad_size(1)-half_size2(1):half_pad_size(1)+half_size2(1)-correction2(1),half_pad_size(2)-half_size2(2):half_pad_size(2)+half_size2(2)-correction2(2)) = img2;

    % Represent the two images in FFT format
    img1_pad = fftshift(img1_pad);
    img2_pad = fftshift(img2_pad);

    % Images in the frequency domain
    I1 = fft2(img1_pad);
    I2 = fft2(img2_pad);

    % Cross-correlation in the frequency domain is 
    % I1 multiplied by the complex conjugate of I2.
    C = I1 .* conj(I2);

    % Result in the spatial domain
    corrImg = ifft2(C);

    % Revert to non-FFT format
    corrImg = fftshift(corrImg);
end