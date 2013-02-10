main_image = ReadImage("scanned_doc.png");
main_image=RGB2Gray(main_image);

// Path variable
path="./"

[row_no,col_no] = size(main_image)


// Rowsum of Binary Image
row_sum = zeros(row_no,1);
for m = 1:row_no,
	row_sum(m) = sum(main_image(m,:));
end


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


// Write line function
for i = 1 : (row_no),
	line = main_image((end_coordinate(i):start_coordinate(i+1)), : );
	line_number = msprintf("line %d.png", i); 
	WriteImage(line, path + line_number);
end



// Pick up a line
sample_line = ReadImage("./line 2.png");
original_line = sample_line;
sample_line = uint8( 255 * ones(size(sample_line, 1), size(sample_line, 2))) - sample_line; // Inverted Image

[ rows_no, cols_no] = size(sample_line)


// Split into characters

//// binary image of line
binary_image = SegmentByThreshold(sample_line, CalculateOtsuThreshold(sample_line));
 
//// Col_sum

col_sum = zeros(1,cols_no);
for m = 1:cols_no,
	col_sum(m) = sum(binary_image(:,m));
end

// initialization
char_start = [];
char_end = [];

for m = 1 : (cols_no-1)
	
	if (col_sum(1, m) == 0 & col_sum(1,m+1) <> 0) then  // <> is NOT EQUAL OPERATOR, WHY?
		char_start(1,$+1) = m;
	end

	if (col_sum(1, m) <> 0 & col_sum(1,m+1) == 0) then
		char_end(1,$+1) = m;
	end
	
end

// Since order of char_end and char_start are and SHOULD be same,

char_img = size(char_start);

exec "feature_extract.sci"
exec "rm_ws.sci"
exec "preprocessing.sci"
for m = 1 : char_img(2)

	char_number = msprintf("single_char %d.png", m)	
	char_image = original_line(:,char_start(m):char_end(m))
	char_image = rm_ws(char_image,"cols") // Remove top and bottom white space 


	// Some times char_image is [], find out why
	if char_image <> [] then
		inv_binimg = gray2inv_bin(char_image);
		feature_image = extract_feature(inv_binimg);
	 	WriteImage(char_image,path+"characters/"+char_number);
	end
end

