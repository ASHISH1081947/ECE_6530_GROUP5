function hh = dtmfdesign(fb, L, fs)
    % DTMFDESIGN
    % hh = dtmfdesign(fb, L, fs)
    % returns a matrix (L by length(fb)) where each column contains
    % the impulse response of a BPF, one for each frequency in fb
    % fb = vector of center frequencies
    % L = length of FIR bandpass filters
    % fs = sampling freq
    % Initialize the matrix to store the filters
    hh = zeros(L, length(fb));

    % Loop over each center frequency in fb
    for i = 1:length(fb)
        % Generate the impulse response for the bandpass filter
        n = 0:L-1;
        h = cos(2 * pi * fb(i) * n / fs);

        % Measure the peak value of the unscaled frequency response
        peak_value = max(abs(fft(h)));

        % Scale the filter to have a maximum magnitude of one
        B = 1 / peak_value;

        % Apply the scaling to the filter
        hh(:, i) = B * h;
    end
end
