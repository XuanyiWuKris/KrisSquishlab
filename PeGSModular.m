%%New version of PeGS using a modular format, Adapted from Jonathan
%%Kollmer's PeGS installation in matlab Github link by Carmen Lee
%%Began on June 24

%%Ideally, this script will call various modules included in this folder
%%and will only requre some user input values. These include the image
%%location, boundary (for the annulus data and airtable data from K.
%%Daniels lab at NCSU)

function PeGSModular(topDirectory, imageNames)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%User input values
%topDirectory = '/mnt/ncsudrive/c/cllee3/MyEno/DATA/jekollme/20160701/Steps/artificial/'
topDirectory = 'C://Users/Squishfolk/Desktop/Alec/211MSDCF/'; % location of image files
preProDirectory = 'C://Users/Squishfolk/Desktop/Alec/211MSDCF/PreProImages/';
%topDirectory = './testdata/square/'
%topDirectory = '/Users/carmenlee/Desktop/20150731reprocesseduniaxial/'
% %topDirectory = './DATA/test/Step09/'
imageNames = 'DSC*.JPG'; %image format and regex
frameidind = 16;
%
%files = dir([topDirectory,imageNames])
boundaryType = "drum"; %if airtable use "airtable" if annulus use "annulus"
radiusRange = [40, 57];
%radiusRange = [45, 78]; %airtable

verbose = false;

% if (isfile([topDirectory, 'log.txt']))
%     fid = fopen([topDirectory, 'log.txt'], 'r');
% 
%     % Read data using textscan
%     data = textscan(fid, '%s %s', 'HeaderLines', 1, 'Delimiter', ':');
% 
%     % Close the file
%     fclose(fid);
%     % Extract relevant data
%     nFrames_index = find(strcmp(data{1}, 'nFrames'));
%     nFrames = str2num(data{2}{nFrames_index});
% 
%     radiusRange_index = find(strcmp(data{1}, 'radiusRange'));
%     radiusRange_str = data{2}{radiusRange_index};
%     radiusRange = str2num(radiusRange_str);
% 
%     cen_index = find(strcmp(data{1}, 'cen'));
%     cen_str = data{2}{cen_index};
%     cen = str2num(cen_str);
% 
%     rad_index = find(strcmp(data{1}, 'rad'));
%     rad_str = data{2}{rad_index};
%     rad = str2num(rad_str);
% 
%     data = [nFrames, rad, cen, radiusRange]
%     % Display the extracted data
%     disp(['Number of Frames: ', num2str(nFrames)]);
%     disp(['Radius Range: ', num2str(radiusRange)]);
%     disp(['Center: ', num2str(cen)]);
%     disp(['Radius: ', num2str(rad)]);
% 
% end

if not(isfolder(append(topDirectory,'adjacency'))) %make a new folder with warped images
    mkdir(append(topDirectory,'adjacency'));
end
if not(isfolder(append(topDirectory,'solved'))) %make a new folder with warped images
    mkdir(append(topDirectory,'solved'));
end
if not(isfolder(append(topDirectory,'synthImg'))) %make a new folder with warped images
    mkdir(append(topDirectory,'synthImg'));
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%preprocess(topDirectory, imageNames, boundaryType, verbose);

%%
particleDetect(preProDirectory, imageNames, radiusRange, boundaryType, verbose);
fprintf('particles detected')

boundaryType = "airtable";

%%
particleTrack(topDirectory, imageNames, boundaryType, frameidind, verbose, false);
fprintf('trajectories connected')
%%
contactDetection(topDirectory, imageNames, boundaryType,frameidind, verbose)
fprintf('contacts detected')
%%
diskSolve(topDirectory, imageNames, boundaryType, verbose)
fprintf('forces solved')
%%
newtonize(topDirectory, imageNames, boundaryType, verbose)
fprintf('newtonized and edges handled')
%%
adjacencyMatrix(topDirectory, imageNames, boundaryType, frameidind,verbose)
fprintf('Adjacency matrix built')
