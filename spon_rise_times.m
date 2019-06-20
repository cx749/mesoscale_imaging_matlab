function [max_dvdt,min_dvdt, max_dvdt_ave, min_dvdt_ave,amp] = spon_rise_times(lpf,X_dff,Xpks,Xlocs);

X = low_filt(lpf,X_dff); %lowpass filter 

if size(Xpks,1) > 0 %if peaks have been detected in timeseries
f = wave_form_extraction(X,Xlocs);

%find first derviative and smooth
for i = 1:size(f,2)
    rise(:,i) = diff(f(:,i));
    rise(:,i) = smooth((rise(:,i)/0.2),5);
    
    
B0 = mean(f(30:40,i));
M = max(f(40:60,i));
amp(:,i) = M-B0;

end

max_dvdt = max(rise(1:50,:)); %max rise time in first second of waveform (rising period)
min_dvdt = min(rise(50:100,:)); %min rise time in last second of waveform (falling period)

max_dvdt_ave = mean(max_dvdt); %average max_dvdt
min_dvdt_ave = mean(min_dvdt); %average min_dvdt
else
max_dvdt = NaN;
min_dvdt = NaN;
end


end
