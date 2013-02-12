exec  training.sci


a_char = ReadImage("characters/single_char 1.png");

path = path + "training_feature_data/";
// dic is defined in training.sci
[content_vector, list_rowsum, list_colsum] = read_feature(path, dic);


// given_image should be grayscale
function [sorted_array] = compare_features(given_img, feature_content, feature_list_rowsum, feature_list_colsum)
	
	// Extract feature of given_image first
	given_img_bin = gray2inv_bin(given_img);
	given_img_feature_struct = extract_feature(given_img_bin);
	
	scale_vector = [];
	given_img_fr_size = max(size(given_img_feature_struct.row_vector)); // neglecting 1 in (1, size)
	given_img_fc_size = max(size(given_img_feature_struct.col_vector)); // neglecting 1 in (1, size)
	
	scaling_diff = [] * 23
	
	for i = 1 : 23   // change it to 26 when problem for i j l are solved
		
		list_rowsum_size = max(size(list_rowsum(i)))  // neglecting 1 in (1, size)
		
		// make row_vector of each equal
		if (given_img_fr_size >= list_rowsum_size) then
			dec_given_img_rv = decimate_vector(given_img_feature_struct.row_vector, list_rowsum_size); // using given_img_feature_struct.row_vector as output doesnt work!!

			dec_list_rs = list_rowsum(i);
		else	
			dec_given_img_rv = given_img_feature_struct.row_vector;
			dec_list_rs = decimate_vector(list_rowsum(i), given_img_fr_size);a// using list_rowsum(i) output doesnt work!!
		end
	
		// Pattern matching FOR ROW
		size_dec_vectors = max(size(dec_given_img_rv)); // can be replaced with dec_list_rs too since sizes are equal now
		scaling = [] * size_dec_vectors
		for j = 1:size_dec_vectors
			if dec_given_img_rv(j) <> 0 then
				scaling(j,1) = dec_list_rs(j)/dec_given_img_rv(j);
			else
				scaling(j,1) = 1;
			end
		end
		
		scaling_diff(i,1) = i;
		scaling_diff(i,2) = (max(scaling)) - min(scaling);

	end

	sorted_array = scaling_diff;
endfunction

