main_image = ReadImage("scanned_doc.png");
main_image=RGB2Gray(main_image);

struc_element = CreateStructureElement('square',2);

//open_image=OpenImage(main_image,struc_element);
//close_image=CloseImage(main_image,struc_element);
dilate_image=DilateImage(main_image,struc_element);
//erode_image=ErodeImage(main_image,struc_element);

path="/home/vm/scripts/sci_ocr/sci_scripts/"

//WriteImage(open_image, path+"opened.png");
//WriteImage(close_image, path+"closed.png");
WriteImage(dilate_image, path+"dilated.png");
//WriteImage(erode_image, path+"eroded.png");


//thresholding(mm, 100)
threshold = CalculateOtsuThreshold(main_image);
binary_image = SegmentByThreshold(main_image, threshold);
binary_image = DilateImage(binary_image, struc_element);
//WriteImage(binary_image, path+"binary.png");
//ShowImage(binary_image, "yo");


// SUMMATIONS
[row_no,col_no] = size(dilate_image)
// Rowsum
row_sum = zeros(row_no,1);
for m = 1:row_no,
	row_sum(m) = sum(binary_image(m,:));
end

plot2d(row_sum);

// Remove from RAM
binary_image=[];
dilate_image=[];



// Line Extraction
N = 1;
K = 1;
J = 1;
for i = 1:(row_no-5),
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

// Line Image
//for i = 1 : max(size(start_coordinate), size(end_coordinate))
//	line
//end
