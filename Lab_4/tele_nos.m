fs = 8000;
L = 80; % Choose an appropriate value based on your filter design
phone_number = '8015129695';

xx = dtmfdial(phone_number, fs);
soundsc(xx, fs); % Play the sound
decoded_keys = dtmfrun(xx, L, fs);
disp(['Decoded keys: ',phone_number ]);

% Create a spectrogram
spectrogram(xx, 256, 250, 256, fs, 'yaxis');
title('Spectrogram of the DTMF tones');

