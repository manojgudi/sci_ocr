exec hitormiss.sci

// Thin Image by 8 sequence elements b1-b8 predefined here
function [output_img] = ThinImageSequence(image) //Image is grayscale (from SkeletonizeImage)
	image = gray2inv_bin(image);
	
	function [out_mat] = ThinMat(element_struct,ip_mat) // ip_mat is binary matrix
		out_mat = ip_mat -  hitormiss(element_struct,ip_mat);
	endfunction

	// list of sequence elements
	list_seq = list()
	b = CreateStructureElement('square',3)

	// Sequence elements
	for i = 1:8
		list_seq(i) = b
	end

	list_seq(1).Data = [%F %F %F; %T %T %F; %F, %F %F]
	list_seq(2).Data = [%F %T %F; %F %T %F; %F, %F %F]
	list_seq(3).Data = [%F %F %F; %F %T %T; %F, %F %F]
	list_seq(4).Data = [%F %F %F; %F %T %F; %F, %T %F]
	list_seq(5).Data = [%T %F %F; %F %T %F; %F, %F %F]
	list_seq(6).Data = [%F %F %T; %F %T %F; %F, %F %F]
	list_seq(7).Data = [%F %F %F; %F %T %F; %F, %F %T]
	list_seq(8).Data = [%F %F %F; %T %T %F; %T, %F %F]
	
	// A Thin by B sequence (b1,b2..b8)
	
	output_img = ThinMat(list_seq(1).Data,image);
	for i = 2 : 8
		output_img = ThinMat(list_seq(i).Data,output_img);
	end

endfunction

function [op_img] = PruneImage(input_img) // Image is Grayscale Skeleton
	
	//input_img = RGB2Gray(input_img);

	// Thin Image
	x1 = ThinImageSequence(input_img);
	
	// x2 = Hull Convex of hitormiss(x1,bi) bi = {b1, b2, b3.. b8}

	// list of sequence elements
	list_seq = list()
	b = CreateStructureElement('square',3)

	// Sequence elements
	for i = 1:8
		list_seq(i) = b
	end

	list_seq(1).Data = [%F %F %F; %T %T %F; %F, %F %F]
	list_seq(2).Data = [%F %T %F; %F %T %F; %F, %F %F]
	list_seq(3).Data = [%F %F %F; %F %T %T; %F, %F %F]
	list_seq(4).Data = [%F %F %F; %F %T %F; %F, %T %F]
	list_seq(5).Data = [%T %F %F; %F %T %F; %F, %F %F]
	list_seq(6).Data = [%F %F %T; %F %T %F; %F, %F %F]
	list_seq(7).Data = [%F %F %F; %F %T %F; %F, %F %T]
	list_seq(8).Data = [%F %F %F; %T %T %F; %T, %F %F]
	
	x2 = hitormiss(list_seq(i).Data,x1);
	for i = 2:8
		x2 = (x2 | hitormiss(list_seq(i).Data,x1));
	end
	
	// x3 = x2 dilated with H (3x3 structural element) 
	H = CreateStructureElement('square',3);
	x3 =( DilateImage(x2, H) - gray2inv_bin(input_img));

	// x4 = x1 U x3
	x4 = x1 | x3;
	op_img = x4 ;
endfunction
