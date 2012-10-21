function output = getSpeedLimit(path, prefix, first, last, digits, suffix, start)
            load_sequence(path, prefix, first, last, digits, suffix);
            % color information stored in imgsC for use at the end
            imgsC=ans;
            [x y z number] = size(imgsC);
            % create a grayscale double sequence of images
            for i=1:number
                        imgs(:,:,i) = double(rgb2gray(imgsC(:,:,:,i)))/255;
            end
           
            %imgs now contains a sequence of grayscale images.
            %convert to binary based on a threshold
            for i=1:number
                        bwIms(:,:,i) = im2bw(imgs(:,:,i), .5);
            end
           
            %take each frame and compare it to scaled images with typical speed limits
            %if they are simmilar enough, return positive. if a few frames in a row
            %all return positive, that's the speed limit.
           
            %load_sequence("/imgs", "speed_limit_", 1, 10, 2, ".jpg");
            %speeds = ans;
            %assume speeds contains binary speed limit examples
           
            % 1 = 15mph
            % 2 = 25mph
            % 3 = 30mph
            % 4 = 35mph
            % 5 = 40mph
            % 6 = 45mph
            % 7 = 50mph
            % 8 = 55mph
            % 9 = 60mph
            % 10 = 65mph
           
           
            %ten speed limits checked for now
            match = 0;
            for i=1:10
                        for j=1:number
                                    %tally all matches
                                    match = match + compare(speeds(:,:,i),bwIms(:,:,j));
                        end
                        %store all matches in an array
                        matches(i) = match;
            end
            %value can be ignored, we just want the index
            [value,sIndex]=max(matches);
           
            %return the actual speed based on the index
            output = getSpeedByIndex(sIndex)
           
end
 
function output = compare(speedImg,bwImg)
            thresh=95;
            val = speedImg(:,:) - bwImg(:,:);
            temp = sqrt(sum(sum(val.^2)));
            if(temp < thresh)
                        output = 1;
            else
                        output = 0;
            end
end
 
function output = getSpeedByIndex(sIndex)
            speeds = [15 25 30 35 40 45 50 55 60 65];
            output = speeds[sIndex];
end