// Removing whitespaces from grayscale image, returns co-ordinates image without white-space

function [clean_img] = rm_ws(given_img, input_string);
	
	// Make it inverted - binary image
	dirty_img =  uint8( 255 * ones(size(given_img, 1), size(given_img, 2))) - given_img;
	dirty_img = SegmentByThreshold(dirty_img, CalculateOtsuThreshold(given_img));
	dirty_img_dim = size(dirty_img);
	
	select input_string
	
	// Remove top and bottom whitespace
	case "cols" then
		col_sum=[];
		for i = 1:dirty_img_dim(1)
			col_sum(1,$+1)=sum(dirty_img(i,:));
		end

		// Opt: This can be bettered and col_sum can be removed completely by merging 2 for loops
		col_size = size(col_sum)
		ws_start = 1;
		ws_end = col_size(2);
		
		for i = 1: (col_size(2)-1)
			if (col_sum(1,i)) == 0 & col_sum(1,i+1) <> 0 then	
				ws_start = i+1;
			end
		
			if (col_sum(1,i)) <> 0 & col_sum(1,i+1) == 0 then	
				ws_end = i;
			end

		end

		clean_img = given_img(ws_start:ws_end,:);
	
	// Remove right and left side white space
	case "rows" then
		// have to write this code 
		break	
	else 
		printf("check case values");
		break	
	end
endfunction


