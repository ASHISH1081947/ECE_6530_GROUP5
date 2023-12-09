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

    % Mark DTMF frequencies on the plot
    marker_freq = 2 * pi * dtmf_freqs(i) / fs;
    %plot(marker_freq, abs(freqz(hh(:, i), 1, marker_freq, fs)), 'ro', 'MarkerSize', 8);
end

hold off;

title('Magnitude Response of Scaled DTMF Bandpass Filters');
xlabel('Normalized Frequency (\omega / \pi)');
ylabel('Magnitude');
legend('697 Hz', '770 Hz', '852 Hz', '941 Hz', '1209 Hz', '1336 Hz', '1477 Hz', '1633 Hz', 'Location', 'best');
grid on;

function hh = dtmfdesign(fb, L, fs)
    n = 0:L-1; % Set value of sample points
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
end