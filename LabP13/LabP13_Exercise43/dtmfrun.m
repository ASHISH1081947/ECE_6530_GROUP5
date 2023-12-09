%%  DTMF Decode Function: dtmfrun.m
function keys = dtmfrun(xx,L,fs)
%DTMFRUN keys = dtmfrun(xx,L,fs)
% returns the list of key names found in xx.
% keys = array of characters, i.e., the decoded key names
% xx = DTMF waveform
% L = filter length
% fs = sampling freq
%
%center_freqs = <============================FILL IN THE CODE HERE
%hh = dtmfdesign( center_freqs,L,fs );
% hh = L by 8 MATRIX of all the filters. Each column contains the
% impulse response of one BPF (bandpass filter)
%
%[nstart,nstop] = dtmfcut(xx,fs); %<--Find the beginning and end of tone bursts
%keys = [];
%for kk=1:length(nstart)
%x_seg = xx(nstart(kk):nstop(kk)); %<--Extract one DTMF tone
%<=========================================FILL IN THE CODE HERE
dtmf.keys = ... 
   ['1','2','3','A';
    '4','5','6','B';
    '7','8','9','C';
    '*','0','#','D'];

dtmf.colTones = ones(4,1)*[1209,1336,1477,1633];
dtmf.rowTones = [697;770;852;941]*ones(1,4);

center_freqs = [dtmf.rowTones(:,1)' , dtmf.colTones(1,:)]; 

hh = dtmfdesign(center_freqs, L, fs);

[nstart,nstop] = dtmfcut(xx,fs);

% Keep track of keys and locations of those frequencies
keys = [];
locations = [];

for kk=1:length(nstart)
    x_seg = xx(nstart(kk):nstop(kk)); 
    locations = [];

    for jj=1:length(center_freqs)
        locations = [locations, dtmfscore(x_seg,hh(:,jj))];
    end
    
    aa = find(locations == 1);
    
    % Edge case detection here
    if length(aa) ~= 2 | aa(1) > 4 | aa(2) < 5
        continue
    end
    
    row = aa(1);
    col = aa(2)-4;
    
    % Return a list of 
    keys = [keys, dtmf.keys(row,col)];
end
%%
