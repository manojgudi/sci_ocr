//main_image = ReadImage("scanned_doc.png");
//main_image=RGB2Gray(main_image);

//struc_element = CreateStructureElement('square',2);

// Dilated Image
//dilate_image=DilateImage(main_image,struc_element);
//path="./"
//WriteImage(dilate_image, path+"dilated.png");

////
//erode_image = ErodeImage(main_image,struc_element);
//WriteImage(erode_image, path+"eroded.png");
////

// Binary Image, Writing this to a file is redundant since Image Viewers cannot read binary image
//threshold = CalculateOtsuThreshold(main_image);
//binary_image = SegmentByThreshold(main_image, threshold);
//binary_image = DilateImage(binary_image, struc_element);


// Creates inverted binary image from a grayscale image
function [bin_img] = gray2inv_bin(gray_img)
	
	
	inv_img =  uint8( 255 * ones(size(gray_img, 1), size(gray_img, 2))) - gray_img;
	bin_img = SegmentByThreshold(inv_img, CalculateOtsuThreshold(inv_img));
	
endfunction
