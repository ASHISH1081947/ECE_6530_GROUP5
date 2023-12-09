%% dtmfdial - Creates tones from each frequency given
function xx = dtmfdial(keyNames,fs)
% a DTMF (Touch Tone) telephone system.
%
% usage: xx = dtmfdial(keyNames,fs)
%  keyNames = vector of characters containing valid key names
%        fs = sampling frequency
%        xx = signal vector that is the concatenation of DTMF tones.

dtmf.keys = ... 
   ['1','2','3','A';
    '4','5','6','B';
    '7','8','9','C';
    '*','0','#','D'];

dtmf.colTones = ones(4,1)*[1209,1336,1477,1633];
dtmf.rowTones = [697;770;852;941]*ones(1,4);

toneTime = 0.25;
silenceTime = 0.07; 

tt = 0:1/fs:toneTime; % Sampling rate of the toneTime

xx = 0;
for ii = 1:length(keyNames)
    keyName = keyNames(ii);
    
    [r,c] = find(dtmf.keys==keyName);

    if (numel(r) == 0 | numel(c) == 0)
        continue
    end
    
    toneFreq = cos(2*pi*dtmf.rowTones(r,c)*tt) + cos(2*pi*dtmf.colTones(r,c)*tt); % Add two tones found by frequencies

    xx = [xx, zeros(1, silenceTime*fs), toneFreq]; % Queue all the tones after each other
end
%%