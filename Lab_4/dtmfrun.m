function keys = dtmfrun(xx, L, fs)
%DTMFRUN keys = dtmfrun(xx, L, fs)
% returns the list of key names found in xx.
% keys = array of characters, i.e., the decoded key names
% xx = DTMF waveform
% L = filter length
% fs = sampling freq

% Define center frequencies for DTMF tones
center_freqs = [697, 770, 852, 941, 1209, 1336, 1477, 1633];

% Design the bandpass filters
hh = dtmfdesign(center_freqs, L, fs);

% Find the beginning and end of tone bursts
[nstart, nstop] = dtmfcut(xx, fs);

keys = [];
for kk = 1:length(nstart)
    % Extract one DTMF tone segment
    x_seg = xx(nstart(kk):nstop(kk));

    % Initialize variables to store scores for row and column frequencies
    row_scores = zeros(1, 4);
    col_scores = zeros(1, 4);

    % Loop through row frequencies
    for row = 1:4
        % Score the row frequency using dtmfscore
        row_scores(row) = dtmfscore(x_seg, hh(:, row));
    end

    % Loop through column frequencies
    for col = 1:4
        % Score the column frequency using dtmfscore
        col_scores(col) = dtmfscore(x_seg, hh(:, col + 4));
    end

    % Find the indices of scored frequencies
    row_index = find(row_scores == 1);
    col_index = find(col_scores == 1);

    % Check if one row frequency and one column frequency are scored
    if length(row_index) == 1 && length(col_index) == 1
        % Determine the key based on the row and column index
        key = ['1', '2', '3', 'A'; '4', '5', '6', 'B'; '7', '8', '9', 'C'; '*', '0', '#', 'D'];
        decoded_key = key(row_index, col_index);

        % Append the decoded key to the result
        keys = [keys, decoded_key];
    else
        % Error indicator if too many or too few frequencies are scored
        keys = [keys, 'Error'];
    end
end
