/// Author: Manoj Gudi, March 2013
/// manoj.p.gudi@gmail.com                               
/// Released under General Public License V3

exec mat_functions.sci

function [grayscale_skeleton_image] = SkeletonizeImage(rgbimage)
	
	gray_char_image = RGB2Gray(rgbimage);
	gray_char_image = gray2inv_bin(gray_char_image);

	// dirty_pix_* are pixels which are flagged for deletion after completion of their respective steps

	dirty_pix_1 = list(1) // Intialize with garbage
	
	// Perform Step1 and Step2 until there are no dirty_pix which can be deleted
	while (size(dirty_pix_1) <> 0)
		dirty_pix_1=step(gray_char_image,1)// Perform step1
		gray_char_image=delete_dirty_pix(gray_char_image, dirty_pix_1)

		dirty_pix_2=step(gray_char_image,2)// Perform step2
		gray_char_image=delete_dirty_pix(gray_char_image, dirty_pix_2)
	
	end

	// Converting the binary image in to grayscale
	[rows,cols] = size(gray_char_image);
	white_img = zeros(rows,cols) + 255
	for i = 1:rows
		for j = 1:cols
			grayscale_skeleton_image(i,j) = uint8(white_img(i,j) * ~(gray_char_image(i,j)));
		end
	end
endfunction
