main_image = ReadImage("scanned_doc.png");
main_image=RGB2Gray(main_image);

struc_element = CreateStructureElement('square',2);

// Dilated Image
dilate_image=DilateImage(main_image,struc_element);
path="./"
WriteImage(dilate_image, path+"dilated.png");


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
binary_image=[];


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

for i = 1 : (row_no-1),
	line = main_image((end_coordinate(i):start_coordinate(i+1)), : );
	line_number = msprintf("line %d.png", i); 
	WriteImage(line, path + line_number);
end


