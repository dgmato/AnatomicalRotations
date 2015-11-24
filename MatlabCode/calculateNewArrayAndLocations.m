function [ newPointsArray, newPointsLocations ] = calculateNewArrayAndLocations( oldPointsArray,oldPointsLocations, maxOmin, thr)
%calculateNewArrayAndLocations Summary of this function goes here
%   Detailed explanation goes here
%   We use this function for computing the true maximums and minimums so
%   that we can recalcule the mean.
%   maxOmin = 0 for maximum values
%   maxomin = 1 for minimum values

newPointsArray = [];
newPointsLocations=[];
k = 1;
if (maxOmin == 0) % thr is an upper threshold to filter local maxima
    for i = 1: length(oldPointsArray)
        if (oldPointsArray(i)> thr)
            newPointsArray(k) = oldPointsArray(i);
            newPointsLocations(k)=oldPointsLocations(i);
            k = k + 1;
        end
    end
else % thr is a lower threshold to filter local minima
    for i = 1: length(oldPointsArray)
        if (oldPointsArray(i)< thr)
            newPointsArray(k) = oldPointsArray(i);
            newPointsLocations(k)=oldPointsLocations(i);
            k = k + 1;
        end
    end
    
end