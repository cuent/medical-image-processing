% ELEC 6661: Medical Image Processing
% Assignment 1
%
% Xavier Sumba
% StudentID: 40086818
%
% For 1 through 4 use the built-in image "peppers.png" to test. To load it, simply type the following: i_pepper = imread('peppers.png');

i_pepper = imread('peppers.png')

% 1.) Flip an image upside-down.

i_pepper_flip = flipdim(i_pepper, 1)

% 2.) Take a color image and make it grayscale using equal weights of R,  G, and B. 
%
% solution: averaging each channel considers the same weight for R, G and B

i_pepper_grey = mean(i_pepper, 3)

% 3.) Swap the R and B color channels of an RGB image such that R is now B and vice-versa.

i_pepper_BGR = flip(i_pepper, 3)

% 4.) Rotate a greyscale image 90 degrees counter-clockwise. (you cannot use imrotate or rot90)
i_pepper_grey_rot90 = i_pepper_grey.'

% 5.) Create a 12 by 12 by 3 "image" using the matrix from part 1 question 1.  Now, look at the "reshape" function in Matlab using the help command. Use reshape to  

	A = reshape(1:144, 12, 12).'
	A = repmat(A, 1, 1, 3)
	
    % a) convert this matrix to a 144 by 3 matrix.
	A_rsp = reshape(A, 144, 3)

    % b) convert the 144 by 3 matrix back to the original 12 by 12 by 3      structure.
	A_org = reshape(A_rsp, 12, 12, 3)
