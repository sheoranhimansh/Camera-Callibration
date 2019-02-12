location = './new/';
images = imageSet(location);
imageFileNames = images.ImageLocation;
[imagePoints, boardSize] = detectCheckerboardPoints(imageFileNames);
squareSizeInMM = 29;
worldPoints = generateCheckerboardPoints(boardSize,squareSizeInMM);
params = estimateCameraParameters(imagePoints,worldPoints);
showReprojectionErrors(params);

figure;
imshow(imageFileNames{1});
hold on;
plot(imagePoints(:,1,1), imagePoints(:,2,1),'go');
plot(params.ReprojectedPoints(:,1,1), params.ReprojectedPoints(:,2,1),'r+');
legend('Detected Points','ReprojectedPoints');
hold off;
% for i = 2:36
%     if (i ~= 8 && i ~= 15 && i ~= 21 && i ~= 27 && i ~= 32)
%     plot([proj(1, i), proj(1, i-1)], [proj(2, i), proj(2, i-1)], 'g');
%     end
% end
% 
% for i = 1:7
%         plot([proj(1, i), proj(1, 7+i)], [proj(2, i), proj(2, 7+i)], 'g');
%         if (i <= 6)
%         plot([proj(1, 7+i), proj(1, 14+i)], [proj(2, 7+i), proj(2, 14+i)], 'g');
%         plot([proj(1, 14+i), proj(1, 20+i)], [proj(2, 14+i), proj(2, 20+i)], 'g');  
%         end
%         if (i <= 5)
%         plot([proj(1, 20+i), proj(1, 26+i)], [proj(2, 20+i), proj(2, 26+i)], 'g');
%         plot([proj(1, 26+i), proj(1, 31+i)], [proj(2, 26+i), proj(2, 31+i)], 'g');
%         end     
% end