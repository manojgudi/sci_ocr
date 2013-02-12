// Functions for getting feature vectors of training characters in ./training folder

exec preprocessing.sci
exec feature_extract.sci
exec rm_ws.sci


// Dictionary
dic = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'k' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'];
dic_size = size(dic)
path = "./training/"

////
// Write function to generate character image from lines of character for training
////

// Accepts feature vector struct, path and its name, writes three files name.row_vector, name.content and name.col_vector
function [] = write_feature(feature_struct, path, name)
	fprintfMat(path+name+".content", feature_struct.content);
	fprintfMat(path+name+".row_vector", feature_struct.row_vector);
	fprintfMat(path+name+".col_vector", feature_struct.col_vector);
endfunction


// Read features from given path, "./training/training_feature_data"
function [content_vector,list_rowsum, list_colsum] = read_feature(path, dic)

	dic_size = size(dic); // row dictionary 
	
	// defining variables
	content_vector = [];

	// list data type is awesome 
	list_rowsum = list();
	list_colsum = list();

	for i = 1 : dic_size(2)
		content_vector($+1) = fscanfMat(path+dic(i)+".content");
		list_rowsum($+1) = fscanfMat(path+dic(i)+".row_vector");
		list_colsum($+1) = fscanfMat(path+dic(i)+".col_vector"); 
	end
	
	
endfunction 



write_path = path + "training_feature_data/"
// Extrtact features from all alphabets from ./training and save it in ./training/training_feature_data
// Make this A FUCTION
for i = 1 : dic_size(2)
	
	// ReadImage
	char_image = ReadImage(path+dic(i)+".png");
	char_image = RGB2Gray(char_image);

	char_bin_image = gray2inv_bin(char_image); // inverted binary image


	char_image = rm_ws(char_bin_image,"cols");
	char_feature = extract_feature(char_image);

	// Write feature
	write_feature(char_feature, write_path, dic(i));
	
end


