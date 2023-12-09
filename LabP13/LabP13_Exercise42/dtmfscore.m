%%  A Scoring Function: dtmfscore.m
%% 4.2a)
function sc = dtmfscore(xx, hh)
    %DTMFSCORE
    % usage: sc = dtmfscore(xx, hh)
    % returns a score based on the max amplitude of the filtered output
    % xx = input DTMF tone
    % hh = impulse response of ONE bandpass filter
    %
    % The signal detection is done by filtering xx with a length-L
    % BPF, hh, and then finding the maximum amplitude of the output.
    % The score is either 1 or 0.
    % sc = 1 if max(|y[n]|) is greater than, or equal to, 0.59
    % sc = 0 if max(|y[n]|) is less than 0.59
    % xx = xx*(2/max(abs(xx))); %--Scale the input x[n] to the range [-2,+2]

    xx = xx*(2/max(abs(xx))); % Scale the input x[n] to the range [-2,+2]

    yy = conv(xx,hh); % Y = X * H and this convolution needs to be calculated

    % If yy > 0.59 return 1 else 0
    if max(yy(200:length(yy)-200)) >= 0.59
        sc = 1;
    else
        sc = 0;
    end
end

%% 4.2b)
% DONE - RULE FOR SCORING
%% 4.2c)
% DONE - RULE FOR NORMALIZING INPUT SIGNAL
%% 4.2d)
% The maximum value of H(e^jw) must be equal to one for each filter because
% each bandpass filter contributes a different value to the total
% normalized frequencies. When we scale the frequency, each filter shows a
% particular passband which is earier to filter out than non-normalized
% frequencies.
%% 4.2e) DONE - HELP FOR FUNCTION