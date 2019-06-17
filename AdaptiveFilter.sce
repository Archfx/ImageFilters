image = imread('image.jpg');// Reading the image
imageR = image(:,:,1); //Seperating Red
imageG = image(:,:,2); //Seperating Green
imageB = image(:,:,3); //Seperating Blue

imshow(image);// show original image

K = 9;// kernal size = 9

function output_image= af(image,K) //Adaptive filtering function

N=sqrt(K) //Width and height of kernal
[HEIGHT, WIDTH] = size(image);//Get HEIGHT & WIDTH
lv_arr=[HEIGHT, WIDTH]; //Local variance array
for i = int(N/2) + 1: HEIGHT - int(N/2)
    for j = int(N/2) + 1: WIDTH - int(N/2)
        lv_arr(i,j)=variance(double(image(i - int(N/2): i + int(N/2), j - int(N/2): j + int(N/2)))); //Calculating the local variance
    end
end
nv=mean(lv_arr); //Noice variance of the image

for x = int(N/2) + 1: HEIGHT - int(N/2)
    for y = int(N/2) + 1: WIDTH - int(N/2)
        lv=max(lv_arr(i,j),nv); //Local variance of the Window (If noise variance > local variance then local variance=noise variance)       
        lm=mean(double(image(x - int(N/2): x + int(N/2), y - int(N/2): y + int(N/2)))); //Local mean of the Window
        output_image(x, y) = (1-(nv/lv))*double(image(x, y)) + (nv/lv)*lm;
    end
end
endfunction

//Apply alphaTrimmedMeanFilter to channels seperately
outR = af(imageR,K);
outG = af(imageG,K);
outB = af(imageB,K);

//Concatenating the images
output_image = cat(3,outR,outG,outB);

figure;
imshow(output_image);// Output image
imwrite(output_image, "AdaptiveFilter.jpg");
