topDirectory = 'C://Users/Squishfolk/Desktop/Kris/211MSDCFSample/'; % location of image files
imageNames = 'DSC*.JPG'; %image format and regex
images=dir([topDirectory, '/warpedimg/',imageNames(1:end-4),'warped.tif']);
im = imread([images(1).folder,'/', images(1).name]);
imshow(im)
circ = drawcircle;