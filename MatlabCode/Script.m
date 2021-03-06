
close all
clear
clc
typeOfMovement=1;
numExp=0;
while typeOfMovement~=0
%% File to read selection
typeOfMovementSelection = 'What type of movement would you like to analyze?:\n      (1) Mov No or (2) Mov Pichi or (0) To finish application \n';
typeOfMovement = input(typeOfMovementSelection);
if typeOfMovement~=0
experimentSelection = 'What experiment would you like to analyze?:\n      (1) Exp 1,(2) Exp 2, (3) Exp 3,(4) Exp 4,(5) Exp 5 or(6) Exp 6 \n';
experiment = input(experimentSelection);

switch typeOfMovement
    case 1 %Mov No
        switch experiment
            case 1
                ftoread='MovNo_exp1.csv';
                plot_color='r';
            case 2
                ftoread='MovNo_exp2.csv';
                plot_color='b';
            case 3
                ftoread='MovNo_exp3.csv';
                plot_color='g';
            case 4
                ftoread='MovNo_exp4.csv';
                plot_color='k';
            case 5 
                ftoread='MovNo_exp5.csv';
                plot_color='y';
            case 6
                ftoread='MovNo_exp6.csv';
                plot_color='c';
            otherwise
                disp('Invalid selection!')
        end
    case 2 %Mov Pichi
        switch experiment
            case 1
                ftoread='MovPichi_exp1.csv';
                plot_color='r';
            case 2
                ftoread='MovPichi_exp2.csv';
                plot_color='b';
            case 3
                ftoread='MovPichi_exp3.csv';
                plot_color='g';
            case 4
                ftoread='MovPichi_exp4.csv';
                plot_color='k';
            case 5 
                ftoread='MovPichi_exp5.csv';
                plot_color='y';
            case 6
                ftoread='MovPichi_exp6.csv';
                plot_color='c';
            otherwise
                disp('Invalid selection!')
        end
    otherwise
        disp('Invalid selection!')
end

%% Find number of lines .csv file
% ftoread1 = 'MovNo_exp1.csv';
% fid = fopen(ftoread1);
% size=0;
% empty=0;
% while empty~=-1
%     empty=fgetl(fid); %reads line but does nothing with it
%     if empty~=-1
%         size=size+1;
%     end
% end
% fclose(fid);
%% Read data from .csv file
fid = fopen(ftoread);
header=44;
for i=1:header
    fgetl(fid); %reads line but does nothing with it
end
matrixData=csvread(ftoread,header,1);
matrixData=matrixData(1:2:end,:); %Para quedarnos solo con las lineas que empiezan con la palabra frame...
fclose(fid);

frameIndex=matrixData(:,1);
timeStamp=matrixData(:,2);
trackableCount=matrixData(:,3);
trackableID=matrixData(:,4);
trackable_x=matrixData(:,5);
trackable_y=matrixData(:,6);
trackable_z=matrixData(:,7);
trackable_qx=matrixData(:,8);
trackable_qy=matrixData(:,9);
trackable_qz=matrixData(:,10);
trackable_qw=matrixData(:,11);
trackable_yaw=matrixData(:,12);
trackable_pitch=matrixData(:,13);
trackable_roll=matrixData(:,14);
markerCount=matrixData(:,15);
marker1_x=matrixData(:,16);
marker1_y=matrixData(:,17);
marker1_z=matrixData(:,18);
marker1_id=matrixData(:,19);
marker2_x=matrixData(:,20);
marker2_y=matrixData(:,21);
marker2_z=matrixData(:,22);
marker2_id=matrixData(:,23);
marker3_x=matrixData(:,24);
marker3_y=matrixData(:,25);
marker3_z=matrixData(:,26);
marker3_id=matrixData(:,27);
marker4_x=matrixData(:,28);
marker4_y=matrixData(:,29);
marker4_z=matrixData(:,30);
marker4_id=matrixData(:,31);

%% Average marker
rigidbody_x=trackable_x;
rigidbody_y=trackable_y;
rigidbody_z=trackable_z;

figure(1)
subplot(3,1,1)
hold on
plot(timeStamp,rigidbody_x,'color', plot_color,'LineWidth',4)
title('Movement of rigid body')
xlabel('Time(seconds)')
ylabel('Displacement in X (m)')
subplot(3,1,2)
hold on
plot(timeStamp,rigidbody_y,'color', plot_color,'LineWidth',4)
xlabel('Time(seconds)')
ylabel('Displacement in Y (m)')
subplot(3,1,3)
hold on
plot(timeStamp,rigidbody_z,'color', plot_color,'LineWidth',4)
xlabel('Time(seconds)')
ylabel('Displacement in Z (m)')

%% Find local maxima/minima in position

% Find local maxima
[rigidbody_x_maxPeaks,rigidbody_x_maxPeaksLocs] = findpeaks(rigidbody_x);
[rigidbody_y_maxPeaks,rigidbody_y_maxPeaksLocs] = findpeaks(rigidbody_y);
[rigidbody_z_maxPeaks,rigidbody_z_maxPeaksLocs] = findpeaks(rigidbody_z);

% Find local minima
rigidbody_x_inv = 1.01*max(rigidbody_x) - rigidbody_x;
rigidbody_y_inv = 1.01*max(rigidbody_y) - rigidbody_y;
rigidbody_z_inv = 1.01*max(rigidbody_z) - rigidbody_z;
[rigidbody_x_minPeaks,rigidbody_x_minPeaksLocs] = findpeaks(rigidbody_x_inv);
[rigidbody_y_minPeaks,rigidbody_y_minPeaksLocs] = findpeaks(rigidbody_y_inv);
[rigidbody_z_minPeaks,rigidbody_z_minPeaksLocs] = findpeaks(rigidbody_z_inv);
rigidbody_x_minPeaks=rigidbody_x(rigidbody_x_minPeaksLocs);
rigidbody_y_minPeaks=rigidbody_y(rigidbody_y_minPeaksLocs);
rigidbody_z_minPeaks=rigidbody_z(rigidbody_z_minPeaksLocs);

% % Plots of maxima and minima peaks in position
% figure(1)
% y1=get(gca,'ylim');
% subplot(3,1,1)
% for i=1:length(rigidbody_x_maxPeaksLocs)
%     hold on
%     plot(timeStamp(rigidbody_x_maxPeaksLocs(i)),rigidbody_x_maxPeaks(i),'go')
% end
% for i=1:length(rigidbody_x_minPeaksLocs)
%     hold on
%     plot(timeStamp(rigidbody_x_minPeaksLocs(i)),rigidbody_x_minPeaks(i),'b*')
% end
% title('Movement of rigid body')
% xlabel('Time(seconds)')
% ylabel('Displacement in X (mm)')
% subplot(3,1,2)
% for j=1:length(rigidbody_y_maxPeaksLocs)
%     hold on
%     plot(timeStamp(rigidbody_y_maxPeaksLocs(j)),rigidbody_y_maxPeaks(j),'go')
% end
% for j=1:length(rigidbody_y_minPeaksLocs)
%     hold on
%     plot(timeStamp(rigidbody_y_minPeaksLocs(j)),rigidbody_y_minPeaks(j),'b*')
% end
% xlabel('Time(seconds)')
% ylabel('Displacement in Y (mm)')
% subplot(3,1,3)
% for k=1:length(rigidbody_z_maxPeaksLocs)
%     hold on
%     plot(timeStamp(rigidbody_z_maxPeaksLocs(k)),rigidbody_z_maxPeaks(k),'go')
% end
% for k=1:length(rigidbody_z_minPeaksLocs)
%     hold on
%     plot(timeStamp(rigidbody_z_minPeaksLocs(k)),rigidbody_z_minPeaks(k),'b*')
% end
% xlabel('Time(seconds)')
% ylabel('Displacement in Z (mm)')

%% Orientation 

% Filtering
filtWin=20;
trackable_qx=smooth(trackable_qx,filtWin);
trackable_qy=smooth(trackable_qy,filtWin);
trackable_qz=smooth(trackable_qz,filtWin);
trackable_qw=smooth(trackable_qw,filtWin);
trackable_yaw=smooth(trackable_yaw,filtWin);
trackable_pitch=smooth(trackable_pitch,filtWin);
trackable_roll=smooth(trackable_roll,filtWin);

figure(2)
subplot(4,1,1)
hold on
plot(timeStamp,trackable_qx,'color', plot_color,'LineWidth',4)
title('Quaternions of rigid body')
xlabel('Time(seconds)')
ylabel('Quaternion X')
subplot(4,1,2)
hold on
plot(timeStamp,trackable_qy,'color', plot_color,'LineWidth',4)
xlabel('Time(seconds)')
ylabel('Quaternion Y')
subplot(4,1,3)
hold on
plot(timeStamp,trackable_qz,'color', plot_color,'LineWidth',4)
xlabel('Time(seconds)')
ylabel('Quaternion Z')
subplot(4,1,4)
angle = 2 * acos(trackable_qw);
angle=radtodeg(angle);
hold on
plot(timeStamp,angle,'color', plot_color,'LineWidth',4)
xlabel('Time(seconds)')
ylabel('Degrees')


figure(3)
subplot(3,1,1)
hold on
plot(timeStamp,trackable_yaw,'color', plot_color,'LineWidth',3)
title('YAW, PITCH, AND ROLL')
xlabel('Time(seconds)')
ylabel('trackable yaw')
subplot(3,1,2)
hold on
plot(timeStamp,trackable_pitch,'color', plot_color,'LineWidth',3)
xlabel('Time(seconds)')
ylabel('trackable pitch')
subplot(3,1,3)
hold on
plot(timeStamp,trackable_roll,'color', plot_color,'LineWidth',3)
xlabel('Time(seconds)')
ylabel('trackable roll')

%% Find local maxima/minima in Euler's Orientation
% Computation of signal period
[periodYawSeconds,periodYawSamples] = computePeriodOfSignal(trackable_yaw, timeStamp);
[periodPitchSeconds,periodPitchSamples] = computePeriodOfSignal(trackable_pitch, timeStamp);
[periodRollSeconds,periodRollSamples] = computePeriodOfSignal(trackable_roll, timeStamp);

% Local Maxima specifications: max and min thresholds
thresholdMaxima_yaw=prctile(trackable_yaw,75);
thresholdMaxima_pitch=prctile(trackable_pitch,75);
thresholdMaxima_roll=prctile(trackable_roll,75);
thresholdMinima_yaw=prctile(trackable_yaw,25);
thresholdMinima_pitch=prctile(trackable_pitch,25);
thresholdMinima_roll=prctile(trackable_roll,25);

% Find local maxima
[rigidbody_yaw_maxPeaks,rigidbody_yaw_maxPeaksLocs] = findpeaks(trackable_yaw,'MINPEAKHEIGHT',thresholdMaxima_yaw,'MINPEAKDISTANCE',round(periodYawSamples/2));
[rigidbody_pitch_maxPeaks,rigidbody_pitch_maxPeaksLocs] = findpeaks(trackable_pitch,'MINPEAKHEIGHT',thresholdMaxima_pitch,'MINPEAKDISTANCE',round(periodPitchSamples/2));
[rigidbody_roll_maxPeaks,rigidbody_roll_maxPeaksLocs] = findpeaks(trackable_roll,'MINPEAKHEIGHT',thresholdMaxima_roll,'MINPEAKDISTANCE',round(periodRollSamples/2));

meanMaxPeaks_yaw = mean(rigidbody_yaw_maxPeaks);
meanMaxPeaks_pitch = mean(rigidbody_pitch_maxPeaks);
meanMaxPeaks_roll = mean(rigidbody_roll_maxPeaks);

% Find local minima
rigidbody_yaw_inv = 1.01*max(trackable_yaw) - trackable_yaw;
rigidbody_pitch_inv = 1.01*max(trackable_pitch) - trackable_pitch;
rigidbody_roll_inv = 1.01*max(trackable_roll) - trackable_roll;
thresholdMinima_yaw = 1.01*max(trackable_yaw) - thresholdMinima_yaw;
thresholdMinima_pitch = 1.01*max(trackable_pitch) - thresholdMinima_pitch;
thresholdMinima_roll = 1.01*max(trackable_roll) - thresholdMinima_roll;
[rigidbody_yaw_minPeaks,rigidbody_yaw_minPeaksLocs] = findpeaks(rigidbody_yaw_inv,'MINPEAKHEIGHT',thresholdMinima_yaw,'MINPEAKDISTANCE',round(periodYawSamples/2));
[rigidbody_pitch_minPeaks,rigidbody_pitch_minPeaksLocs] = findpeaks(rigidbody_pitch_inv,'MINPEAKHEIGHT',thresholdMinima_pitch,'MINPEAKDISTANCE',round(periodPitchSamples/2));
[rigidbody_roll_minPeaks,rigidbody_roll_minPeaksLocs] = findpeaks(rigidbody_roll_inv,'MINPEAKHEIGHT',thresholdMinima_roll,'MINPEAKDISTANCE',round(periodRollSamples/2));
rigidbody_yaw_minPeaks=trackable_yaw(rigidbody_yaw_minPeaksLocs);
rigidbody_pitch_minPeaks=trackable_pitch(rigidbody_pitch_minPeaksLocs);
rigidbody_roll_minPeaks=trackable_roll(rigidbody_roll_minPeaksLocs);

meanMinPeaks_yaw = mean(rigidbody_yaw_minPeaks);
meanMinPeaks_pitch = mean(rigidbody_pitch_minPeaks);
meanMinPeaks_roll = mean(rigidbody_roll_minPeaks);

% Standard deviation computation
numExp=numExp+1;
std_maxYaw(numExp) = std(rigidbody_yaw_maxPeaks);
std_maxPitch(numExp) = std(rigidbody_pitch_maxPeaks);
std_maxRoll(numExp) = std(rigidbody_roll_maxPeaks);

std_minYaw(numExp) = std(rigidbody_yaw_minPeaks);
std_minPitch(numExp)= std(rigidbody_pitch_minPeaks);
std_minRoll(numExp) = std(rigidbody_roll_minPeaks);

% Plots of maxima and minima peaks in position
figure(3)
subplot(3,1,1)
for i=1:length(rigidbody_yaw_maxPeaksLocs)
    hold on
    plot(timeStamp(rigidbody_yaw_maxPeaksLocs(i)),rigidbody_yaw_maxPeaks(i),'k*')
end
for i=1:length(rigidbody_yaw_minPeaksLocs)
    hold on
    plot(timeStamp(rigidbody_yaw_minPeaksLocs(i)),rigidbody_yaw_minPeaks(i),'k*')
end
% hold on
% plot (timeStamp, meanMaxPeaks_yaw, 'r')
% hold on
% plot (timeStamp, meanMinPeaks_yaw, 'b')

subplot(3,1,2)
for j=1:length(rigidbody_pitch_maxPeaksLocs)
    hold on
    plot(timeStamp(rigidbody_pitch_maxPeaksLocs(j)),rigidbody_pitch_maxPeaks(j),'k*')
end
for j=1:length(rigidbody_pitch_minPeaksLocs)
    hold on
    plot(timeStamp(rigidbody_pitch_minPeaksLocs(j)),rigidbody_pitch_minPeaks(j),'k*')
end
% hold on
% plot (timeStamp, meanMaxPeaks_pitch,'r')
% hold on
% plot (timeStamp, meanMinPeaks_pitch, 'b')

subplot(3,1,3)
for k=1:length(rigidbody_roll_maxPeaksLocs)
    hold on
    plot(timeStamp(rigidbody_roll_maxPeaksLocs(k)),rigidbody_roll_maxPeaks(k),'k*')
end
for k=1:length(rigidbody_roll_minPeaksLocs)
    hold on
    plot(timeStamp(rigidbody_roll_minPeaksLocs(k)),rigidbody_roll_minPeaks(k),'k*')
end
% hold on
% plot (timeStamp, meanMaxPeaks_roll, 'r')
% hold on
% plot (timeStamp, meanMinPeaks_roll, 'b')

end
end

figure;
subplot(3,1,1)
plot(1:numExp,std_maxYaw,'ro-')
xlabel('Experiment')
ylabel('Std of yaw max peaks')
hold on
plot(1:numExp,std_minYaw,'bo-')
subplot(3,1,2)
plot(1:numExp,std_maxPitch,'ro-')
xlabel('Experiment')
ylabel('Std of pitch max peaks')
hold on
plot(1:numExp,std_minPitch,'bo-')
subplot(3,1,3)
plot(1:numExp,std_maxRoll,'ro-')
xlabel('Experiment')
ylabel('Std of roll max peaks')
hold on
plot(1:numExp,std_minRoll,'bo-')

disp('Thanks for using this awesome program!')



