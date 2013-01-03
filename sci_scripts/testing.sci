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
//threshold = CalculateOtsuThreshold(main_image);
//binary_image = SegmentByThreshold(main_image, threshold);
//binary_image = DilateImage(binary_image, struc_element);
//WriteImage(binary_image, path+"binary.png");
//ShowImage(binary_image, "yo");


// SUMMATIONS
[i,j] = size(dilate_image)
// Rowsum
for m = 1:i,
	row_sum(m) = sum(dilate_image(m,:));
end

plot2d(row_sum);
