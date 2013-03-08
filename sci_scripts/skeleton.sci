stacksize max
exec preprocessing.sci

// Functions used inside MAT   
//// sub_matrix = [p9, p2, p3; p8, p1, p4; p7, p6, p5]

//// Calculate N Value of submatrix with p1 = (i,k)
function [condition] = calc_nval(submatrix,i,j)
	
	condition = %F;
	sum_submatrix = sum(submatrix)-submatrix(i,j)
	if (sum_submatrix >= 2) & (sum_submatrix <= 6) then
		condition = %T;
	end

endfunction

//// Calculate T Value of submatrix, t_val = 0-1 transitions starting p2,p3..p9,p2 where p1 is center pixel of submatrix
function [condition] = calc_tval(sub_matrix,i,j) // i,j are center pixel p1 coordinates of submatrix
	condition = %F;
	value=[]; t_val=0;
	value(1) = sub_matrix(i-1,j+1) - sub_matrix(i-1,j) // p3-p2
	value(2) = sub_matrix(i,j+1) - sub_matrix(i-1,j+1) // p4-p3
	value(3) = sub_matrix(i+1,j+1) - sub_matrix(i,j+1) // p5-p4
	value(4) = sub_matrix(i+1,j) - sub_matrix(i+1,j+1) // p6-p5
	value(5) = sub_matrix(i+1,j-1) - sub_matrix(i+1,j) // p7-p6
	value(6) = sub_matrix(i,j-1) - sub_matrix(i+1,j-1) // p8-p7
	value(7) = sub_matrix(i-1,j-1) - sub_matrix(i,j-1) // p9-p8
	value(8) = sub_matrix(i-1,j) - sub_matrix(i-1,j-1) // p2-p9

	for i = 1:7
		if value(i)== 1 then
			t_val = t_val+1;
		end
	end

	if t_val == 1 then
		condition = %T
	end
endfunction

// Function to calculate and check Products p2*p4*p6  and p4*p6*p8  and p1=>(i,j)
function [condition] = product_check(submatrix, i, j, step)
	condition = %F;
	if step == 1 then
		if (submatrix(i-1,j)*submatrix(i,j+1)*submatrix(i+1,j) == 0) & (submatrix(i,j+1)*submatrix(i+1,j)*submatrix(i,j-1) == 0) then
			condition = %T
		end
	else // For step 2 p2*p4*p8  p2*p6*p8
		if (submatrix(i-1,j)*submatrix(i,j+1)*submatrix(i,j-1) == 0) & (submatrix(i-1,j)*submatrix(i+1,j)*submatrix(i,j-1) == 0) then
			condition = %T
		end
	end	
endfunction

// Skeletonization using Medial Axis Transformation

function [dirty_pix] = step(char_image,step_no)// Char_img is grayscale
//	char_image = gray2inv_bin(char_image); // Inverted binary image
	[rows, cols] = size(char_image);
	dirty_pix=list() // List containing points to be deleted

	for i = 2:(rows-1)
		for j = 2:(cols-1)
			if char_image(i,j) <> 0 then
				submatrix = char_image(i-1:i+1,j-1:j+1);
				if (calc_nval(submatrix,2,2) & calc_tval(submatrix,2,2) & product_check(submatrix,2,2,step_no)) then
					dirty_pix($+1) = [i,j];
				end
			end
		end
	end
endfunction

function [char_image] = delete_dirty_pix(char_image,dirty_pix) // char_image should be Grayscale
	for i = 1:size(dirty_pix)
		coordinate = dirty_pix(i);	
		char_image(coordinate(1),coordinate(2)) = 0; // Delete those pixels
	end
endfunction

char_image = ReadImage("a.png");
gray_char_image = RGB2Gray(char_image);
gray_char_image = gray2inv_bin(gray_char_image);

i=0;
dirty_pix_1 = list(1) // Intialize with garbage
while (size(dirty_pix_1) <> 0)
	dirty_pix_1=step(gray_char_image,1)// Perform step1
	gray_char_image=delete_dirty_pix(gray_char_image, dirty_pix_1)
	printf("sum1 %i\n",sum(gray_char_image));

	dirty_pix_2=step(gray_char_image,2)// Perform step1
	gray_char_image=delete_dirty_pix(gray_char_image, dirty_pix_2)
	
	i=i+1;	
	printf("loop no %i",i);
	printf("sum2 %i\n",sum(gray_char_image));
end

// Converting the image in to grayscale so that it could be written
[rows,cols] = size(gray_char_image);
white_img = zeros(rows,cols) + 255
for i = 1:rows
	for j = 1:cols
		temp(i,j) = uint8(white_img(i,j) * ~(gray_char_image(i,j)));
	end
end
WriteImage(temp, 'skeleton.jpg')
