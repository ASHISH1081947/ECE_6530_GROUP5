%%  Simple Bandpass Filter Design: dtmfdesign.m

%% 4.1a)
% For this one, we decided to use the mathematical description to calculate
% beta and then multiplied it accross to get the value of the hh column
% vector.
%% 4.1b)
function hh = dtmfdesign(fb, L, fs)
% DTMFDESIGN
% hh = dtmfdesign(fb, L, fs)
% returns a matrix (L by length(fb)) where each column contains
% the impulse response of a BPF, one for each frequency in fb
% fb = vector of center frequencies
% L = length of FIR bandpass filters
% fs = sampling freq
%
% Each BPF must be scaled so that its frequency response has a
% maximum magnitude equal to one.

n = 0:L; % Set value of sample points
omega = 0:pi/300:pi; % Set value of omega with pi/300 steps
for i = 1:length(fb)
    % Design simple bandpass filter
    hb(i,:) = cos((2*pi*fb(i)*n)/fs);

    % Beta calculation for gain scaling
    beta(i,:) = abs(1/(max(freqz(hb(i,:),1,omega)))); 

    % scale each filter to finish
    h(i,:) = hb(i,:)*beta(i,:);
end
% Transpose the vector into a column vector
hh = h';
%% 4.1c)
% DONE - ADDITIONAL INFO FOR PART D) F)
% We justify the legth of the filters based on the width of the passband we
% want to pass in relation to the width and amplitude of the side lobes.
% As the length of the filter increases, the width of the passband
% decreases and we want to strike a balance between having efficient code
% and passing appropariate frequencies without skipping parts of an
% individual frequency.
%% 4.1d)
% Define DTMF frequencies
dtmf_frequencies = [697, 770, 852, 941, 1209, 1336, 1477, 1633];
% Parameters
L = 40;
fs = 8000;

% Generate bandpass filters
hh = dtmfdesign(dtmf_frequencies, L, fs);

% Plot frequency responses
figure;
hold on;

for i = 1:size(hh, 2)
    % Frequency response of the i-th filter
    H = freqz(hh(:, i), 1, 'half', fs);

    % Plot magnitude response
    plot(linspace(0, pi, length(H)), abs(H), 'LineWidth', 1.5);
end

hold off;

title('Magnitude Response of Scaled DTMF Bandpass Filters');
xlabel('Normalized Frequency (\omega / \pi)');
ylabel('Magnitude');
legend('697 Hz', '770 Hz', '852 Hz', '941 Hz', '1209 Hz', '1336 Hz', '1477 Hz', '1633 Hz', 'Location', 'best');
grid on;
%% 4.1e) 
% Define DTMF frequencies
dtmf_freqs = [697, 770, 852, 941, 1209, 1336, 1477, 1633];
% Parameters
L = 40;
fs = 8000;

% Generate bandpass filters
hh = dtmfdesign(dtmf_freqs, L, fs);

% Plot frequency responses
figure;
hold on;

for i = 1:size(hh, 2)
    % Frequency response of the i-th filter
    H = freqz(hh(:, i), 1, 'half', fs);

    % Plot magnitude response
    plot(linspace(0, pi, length(H)), abs(H), 'LineWidth', 1.5);
end

hold off;

title('Magnitude Response of Scaled DTMF Bandpass Filters');
xlabel('Normalized Frequency (\omega / \pi)');
ylabel('Magnitude');
legend('697 Hz', '770 Hz', '852 Hz', '941 Hz', '1209 Hz', '1336 Hz', '1477 Hz', '1633 Hz', 'Location', 'best');
grid on;
%% 4.1f) DONE - HELP Section