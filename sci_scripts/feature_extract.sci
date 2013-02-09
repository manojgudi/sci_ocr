//function [feature_vector] = extract_feature(image_mat)
	// creaste row vector and col vector and % content and sheet	
//end

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
