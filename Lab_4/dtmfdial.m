function xx = dtmfdial(keyNames, fs)
    % DTMFDIAL Create a signal vector of tones to dial a DTMF telephone system.
    %
    % usage: xx = dtmfdial(keyNames, fs)
    % keyNames = vector of characters containing valid key names
    % fs = sampling frequency
    % xx = signal vector that is the concatenation of DTMF tones.
    
    % Define DTMF frequency information
    dtmf.keys = ['1', '2', '3', 'A'; '4', '5', '6', 'B'; '7', '8', '9', 'C'; '*', '0', '#', 'D'];
    dtmf.colTones = ones(4, 1) * [1209, 1336, 1477, 1633];
    dtmf.rowTones = [697; 770; 852; 941] * ones(1, 4);

    % Define tone and silence durations
    tone_duration = 0.20; % seconds
    silence_duration = 0.05; % seconds

    % Initialize output signal vector
    xx = [];

    for k = 1:length(keyNames)
        % Find row and column indices for the current key
        [row, col] = find(keyNames(k) == dtmf.keys);

        % Check for illegitimate key name
        if isempty(row) || isempty(col)
            error(['Invalid key name: ', keyNames(k)]);
        end

        % Generate DTMF tone pair
        t = 0:1/fs:tone_duration; % time vector for the tone pair
        tone = sin(2 * pi * dtmf.rowTones(row, col) * t) + sin(2 * pi * dtmf.colTones(row, col) * t);

        % Concatenate tone pair to the output signal
        xx = [xx, tone];

        % Add silence between tone pairs
        silence = zeros(1, round(fs * silence_duration));
        xx = [xx, silence];
    end
end
