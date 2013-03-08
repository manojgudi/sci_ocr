sci_ocr
=======

This a backend application for optical character recognition which uses scilab for agile development.
Prequsites:
> Scilab 5.3.3
> IPD-8.3.1 installed.


Algorithm
========= 

This is a short unconventional algorithm developed by me based on feature extraction for fast pattern recognition of characters

Definitions:

For a given 2x3  matrix:
 A = [5 6 7; 8 9 10]  we define rowsum as vector of all sum of rows and colsum as vector of all sum of columns

here rowsum = [18, 27] and colsum = [13 15 17]

* We calculate all rowsum and colsum of all images of training images of characters [a-z] and write it in folder training_feature_data
* For a given scanned document, we bisect the document in to lines of text and then later cut out all characters in each lines and save it in .sci_scripts/characters folder

For each character of scanned_document.png we apply this algorithm

1. Read all colsum and rowsum values of training images in a scilab list

2. Find rowsum and colsum of the given character and store it in a scilab struct

3. Make the length of rowsum/colsum of given character and rowsum/colsum of characters of training database by decimating the larger of the two with a *non-integral scale(check decimate_vector function in feature_extract.sci)*

4. Co-relate and compare the rowsum and colsum of given character with each colsum and rowsum of training database to compute min_dist; store each min_distance of co-related rowsum values in sorted_array_rowsum and for colsum in sorted_array_colsum

5. Sort the two vectors sorted_array_rowsum and sorted_array_colsum
	
6. The first row of sorted arrays should be given character


* Why calculate rowsum and colsum?

>> The feature-based pattern matching greatly reduces the number of iterations required.

>> Each character[a-z] can uniquely be represented by its rowsum and colsum. For ex: one may cleverly point out these following sets should have same rowsum (b,d), (p,q) henceforth called as rowsum_blind characters; but comparing their colsum clearly differenciates them. (colsum_blind set (b,p), (m,w) )



for ex: run this

`$ cd ./sci_scripts` <br>
`$ scilab-cli -f text_analysis.sci`

and run this function
> [rowsum, colsum] = compare_features(a_char, content_vector, list_rowsum, list_colsum)

It throws up two 23x2 matrices ; find the top miniumum value in 2nd column and note the corresponding index in 1st column is the character which the code has detected; that is if index in 1st column is 1, it means character corresponding to it is letter "a"
*Note that the indices correspond to set [a-z]-{ i,j, l} its one of *pain point which will be sorted out soon*
 
 
How to fiddle with code
=======================
All the code reside in ./sci_scripts

**extract_line_char.sci** => run this code and it automatically chops up ./scanned_document.png into lines (which is saved in the given folder) and characters which is saved in ./characters folder serially

**feature_extract.sci** => contains all functions to generate rowsum and colsum and decimate_vector function

**preprocessing.sci** => preprocesses image before further processing (for ex: converting a hypermatrix into a matrix by RGB2Gray function)

**rm_ws.sci** => removes white spaces above and below of single character image before rowsum/colsum is calculated.

**text_analysis.sci** => does the analysis and co-relation of rowsum of given character image and training database and contains compare_features function which does the pattern recognition
                     ./sci_scripts/training/training_image.svg => This svg can be used to generate training characters, it can be edited with inkscape(a free graphical svg editorr); change all font properties by selection and batch export. It will automatically create [a-z].png in ./sci_scripts/training/

**training.sci** => it generates rowsum and colsum for all [a-z].png in ./sci_scripts/training/ folder and writes it in ./sci_scrip	ts/training/training_feature_data/

*please note this branch is heavily under development, any error or suggestions or flaws in logic, feel free to trouble me*


IPD-8.3.1 installation
================

Clone this repository(or to get source code only, clone master repository)

Run *./dep_install* with root privileges to install the IPD package. The script also installs most of the dependencies required by IPD

### yelp
Using yelp is really useful if you need to check single instances of (unused) functions/variables or multi-line un/commenting.<br>
<a href = "https://github.com/manojgudi/yelp"> Read more</a>