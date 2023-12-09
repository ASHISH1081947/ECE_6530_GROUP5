%% Fianl Design code which brings together 
fs = 8000;
window = 256;  % Window size for spectrogram
overlap = 128; % Overlap between successive windows
tk = ['A','B','C','D','*','#','0','1','2','3','4','5','6','7','8','9'];
%tk = ['4','0','7','*','8','9','1','3','2','#','B','A','D','C'];
%tk = ['3','8','5','2','5','9','2','9','0','6'];
xx = dtmfdial(tk, fs);
soundsc(xx, fs)

%figure;
%spectrogram(xx, window, overlap, [], fs, 'yaxis');
%xlabel('Time (s)');
%ylabel('Frequency (kHz)');
%colorbar;

L = 80;
dtmfrun(xx, L, fs)