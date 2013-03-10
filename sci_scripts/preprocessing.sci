// built on IPD 8.3-1
// Creates inverted binary image from a grayscale image
function [bin_img] = gray2inv_bin(gray_img)
	
	inv_img =  uint8( 255 * ones(size(gray_img, 1), size(gray_img, 2))) - gray_img;
	bin_img = SegmentByThreshold(inv_img, CalculateOtsuThreshold(inv_img));
	
endfunction

// Create inverted binary image from a RGB image (hypermatrix)
function [bin_img] = rgb2inv_bin(rgb_img)
	gray_img = RGB2Gray(rgb_img)
	bin_img = gray2inv_bin(gray_img)
endfunction
