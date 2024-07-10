function [AOA] = AOAestimation(targets, Pmusic, angle)
    p = Pmusic;
    AOA = [];
    threshold = -3; % (dB), power of angle threshold
    [~,indexs] = findpeaks(p, "minpeakheight", -2);
    for i = 1:length(indexs)
        index = indexs(i);
        count = 1;
        AOA = [AOA, angle(index)];
        while true
            flag = 0;
            if (Pmusic(index)-Pmusic(index-count))<3
                AOA = [AOA, angle(index-count)];
                flag = 1;
            end
            if (Pmusic(index)-Pmusic(index+count))<3
                AOA = [AOA, angle(index+count)];
                flag = 1;
            end
            if flag == 0
                break;
            end
            count = count + 1;
        end
        AOA = [AOA, -1];
    end 
end