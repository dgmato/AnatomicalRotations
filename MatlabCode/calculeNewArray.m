function [ newPointsArray ] = calculeNewArray( oldPointsArray, maxOmin, oldMean)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   We use this function for computing the true maximums and minimums so
%   that we can recalcule the mean.
%   maxOmin = 0 for maximum values
%   maxomin = 1 for minimum values

newPointsArray = [];
k = 1;
if (maxOmin == 0)
    for i = 1: length(oldPointsArray)
        if (oldPointsArray(i)> oldMean)
            newPointsArray(k) = oldPointsArray(i);
            k = k + 1;
        end
    end
else
    for i = 1: length(oldPointsArray)
        if (oldPointsArray(i)< oldMean)
            newPointsArray(k) = oldPointsArray(i);
            k = k + 1;
        end
    end
    



end

