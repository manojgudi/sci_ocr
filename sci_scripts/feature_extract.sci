
// Functions for qualitative feature extraction


// functions
function [sum_vector] = vector_sum(image_mat, mode_str)
	
	image_mat_size = size(image_mat);

	select mode_str

	case "cols" then // Sum of each column
		cols_sum = []
		for i = 1 : image_mat_size(2)
			col_sum(1,$+1) = sum(image_mat(:,i)); // col_sum is row vector
		end
		sum_vector = col_sum;
		col_sum = [];

	case "rows" then // Sum of each row
		row_sum = []
		for i = 1 : image_mat_size(1)
			row_sum(1,$+1) = sum(image_mat(i,:)); // row_sum is row vector
		end
		sum_vector = row_sum;
		row_sum = [];

	else
		printf("check for args");
	end
	
endfunction


// image_mat is a binary image
function [feature_struct] = extract_feature(image_mat)

	image_mat_size = size(image_mat);
	feature_struct = struct('content', (sum(image_mat)/(image_mat_size(1) * image_mat_size(2))) ,...
				'row_vector' , vector_sum(image_mat, "rows"), ...
				'col_vector' , vector_sum(image_mat, "cols"));

endfunction

//  Non-integral scaling( = old_size/new_size ) Decimation function

function [dec_vec] = decimate_vector(given_vec, new_size)
	given_vec_size = size(given_vec);
	
	// Assuming row_vector; and assuming given_vec_size > new_size
	no_of_removal = given_vec_size(2) - new_size;
	step_size = given_vec_size(2)/no_of_removal;

	// To fill in zeros, later 1 will be subtracted
	given_vec = given_vec+1;

	count = step_size;
	for i = 1:step_size:given_vec_size(2)
		given_vec(i)=0;
	end

	// Remove Zeros from given_vec, shrinking,
	dec_vec = [];
	for i = 1 : given_vec_size(2)
		if given_vec(i)<> 0 then
			dec_vec(1,$+1)=given_vec(i) - 1 ; // The addition of 1 earlier is subtracted here
		end
	end

endfunction
