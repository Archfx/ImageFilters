image = imread('image.jpg');// Reading the image
imageR = image(:,:,1); //Seperating Red
imageG = image(:,:,2); //Seperating Green
imageB = image(:,:,3); //Seperating Blue

imshow(image);// show original image
K = input('Enter the Window Size (4,9,25,etc) : ');// kernal size = 9
P = input('Enter the trim value for Window :');

function out_image= atmf(image,K,P) // Function to add alphatrimmed mean filter
N=sqrt(K)
[HEIGHT, WIDTH] = size(image);//Get HEIGHT & WIDTH
for i = int(N/2) + 1: HEIGHT - int(N/2)
    for j = int(N/2) + 1: WIDTH - int(N/2)
        K_SORTED = gsort(matrix(image(i - int(N/2): i + int(N/2), j  - int(N/2): j  + int(N/2)), 1, K), 'g', 'i');
        out_image(i , j ) = mean(double(K_SORTED(P + 1: K - P)));  
    end
end
endfunction

//Apply alphaTrimmedMeanFilter to channels seperately
outR = atmf(imageR,K,P);
outG = atmf(imageG,K,P);
outB = atmf(imageB,K,P);

//Concatenating the images
output_image = cat(3,outR,outG,outB);

printf('Filtering completed');
figure;
imshow(output_image); // Display output image
imwrite(output_image, "AlphaTrimmedMeanFilter.jpg");
