exec preprocessing.sci

// Dictionary
dic = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'k' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'];

//## Commented using yelp, morphological(maximum disk)based skeletonization
//diff_matrix=list()
//
//for i = 1 : size(dic,2)
//	image = ReadImage("./training/"+dic(i)+".png");	
//	image = RGB2Gray(image)
//	
//	j = 1;
//	erode_image = 1	
// 	diff_matrix=list()
//	
//	while (sum(erode_image) <> 0 )
//		struct_element = CreateStructureElement('square',j);
//		erode_image = ErodeImage(image, struct_element)
//		open_image = OpenImage(image, struct_element)
//		diff_matrix($+1) = list(erode_image - open_image)
//		//for k = 1:size(diff_matrix)
//			
//		//end
//		j = j+1;
//		printf("%c\n",dic(i))
//		printf("%i ", j)
//		printf("sum %i",sum(image))
//	end
//	
//end ##
