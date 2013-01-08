main_image = ReadImage("scanned_doc.png");
main_image=RGB2Gray(main_image);

struc_element = CreateStructureElement('square',2);

// Dilated Image
dilate_image=DilateImage(main_image,struc_element);
path="./"
WriteImage(dilate_image, path+"dilated.png");

////
erode_image = ErodeImage(main_image,struc_element);
WriteImage(erode_image, path+"eroded.png");
////

// Binary Image, Writing this to a file is redundant since Image Viewers cannot read binary image
threshold = CalculateOtsuThreshold(main_image);
binary_image = SegmentByThreshold(main_image, threshold);
binary_image = DilateImage(binary_image, struc_element);


// SUMMATIONS
[row_no,col_no] = size(dilate_image)
// Rowsum of Binary Image
row_sum = zeros(row_no,1);
for m = 1:row_no,
	row_sum(m) = sum(binary_image(m,:));
end

/////////plot2d(row_sum);

// Remove from RAM
//binary_image=[];


// Line Extraction
N = 1;
K = 1;
J = 1;
for i = 1:(row_no-1),
	if (row_sum(i) == row_sum(i+1)) then
		N=N+1;
		if N == 5  then  // Minimum 5 pixels should be equal
			printf ("start co-ordinates %d \t" ,i-4);
			
			// Storing it in array
			start_coordinate(K) = (i-4);
			K = K + 1;			

		end
	else
		if N > 5 then // Can be anything N > 1
			printf("end co-ordinate %d \n", (i-1));
			
			// Storing it in array
			end_coordinate(J) = (i-1);
			J = J+1;
		end
		N = 1;
	end
end



[row_no, col_no] = size(end_coordinate); // Since end_coordinate has size lower than start_coordinate

// Dictionary
dic = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'];


for i = 1 : (row_no-1),
	line = main_image((end_coordinate(i):start_coordinate(i+1)), : );
	line_number = msprintf("line %d.png", i); 
	WriteImage(line, path + line_number);
end

a_char = ReadImage("./training/a.png");
a_char=RGB2Gray(a_char);

sample_line = ReadImage("./other_line.png");
[ rows_no, cols_no] = size(sample_line)
[ a_char_rows, a_char_cols] = size(a_char)

a_char = resize_matrix(a_char, rows_no, a_char_cols);

// Convolution

sum_temp = zeros((cols_no - a_char_cols),1); 
for i = 1 : (cols_no-a_char_cols),
	for j = i : (a_char_cols + i-1),
		for k = 1 : rows_no,
			temp(k,j) = a_char(k, (j-(i-1))) & sample_line(k ,j);
		end
		
	end
	
	if (sum(temp) > 203) & (sum(temp) <= 213) then
		sum_temp(i) = sum(temp);
	end
end

plot2d2(sum_temp);


[r,c] = size(sum_temp);N=1;
for i = 1 : r,
	if sum_temp(i,c) ~= 0 then
		N=N+1;
	end
end

printf("no of non zero %d", N );

sum_temp=[];
temp=[];
sample_line=[];
a_char=[];

// Deskewing => Hough Transform => SIP toolbox
// Resizing char_image to mancha
// how to calculate convol_vector




