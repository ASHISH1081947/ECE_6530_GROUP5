function sc = dtmfscore(xx, hh)
    %DTMFSCORE
    % usage: sc = dtmfscore(xx, hh)
    % returns a score based on the max amplitude of the filtered output
    % xx = input DTMF tone
    % hh = impulse response of ONE bandpass filter

    % The signal detection is done by filtering xx with a length-L
    % BPF, hh, and then finding the maximum amplitude of the output.
    % The score is either 1 or 0.
    % sc = 1 if max(|y[n]|) is greater than, or equal to, 0.59
    % sc = 0 if max(|y[n]|) is less than 0.59

    xx = xx*(2/max(abs(xx))); %--Scale the input x[n] to the range [-2,+2]

    % Filtering the input signal
    yy = conv(xx, hh);

    % Finding the maximum amplitude of the filtered output
    max_amplitude = max(abs(yy));

    % Scoring based on the max amplitude
    if max_amplitude >= 0.59
        sc = 1;
    else
        sc = 0;
end
