exec preprocessing.sci

function [output_image] = hitormiss(structure, image) // structure and image are RGBImages
	b = rgb2inv_bin(structure);
	
	// Structuring elements
	b1 = CreateStructureElement('custom', b);
	b2 = b1;

	// Image elements
	img1 = rgb2inv_bin((image));
	img2 = ((1-img1));

	eroded_img1 = ErodeImage(img1,b1);
	eroded_img2 = ErodeImage(img2,b2);
	output_image = (eroded_img1)-(eroded_img2);
	
	//WriteImage(output_image, 'output_image.jpg')
endfunction

