function [periodOfTheSignalSeconds,periodOfTheSignalSamples] = computePeriodOfSignal(signal, timeStamp)
% This function computes the period of a given signal ("signal") sampled in
% time according to the array "timeStamp" (in seconds). The period is
% computed by analysing the autocorrelation function of the signal. The
% period is given in seconds.
    
    % Find time step in timeStamp
    step=zeros(length(timeStamp)-1,1);
    for i=1:length(timeStamp)-1
        step(i)=timeStamp(i+1)-timeStamp(i);
    end
    stepSize=mean(step);
    
    % Autocorrelation function+ peaks
    autocorrelation=xcorr(signal,signal);
    [~,locs]=findpeaks(autocorrelation);
    
    % Find period from peaks
    periodOfTheSignalSeconds=mean(diff(locs)*stepSize);
    periodOfTheSignalSamples=mean(diff(locs));
end