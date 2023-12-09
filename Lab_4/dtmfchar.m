function key = dtmfchar(row, col)
    % DTMFCHAR key = dtmfchar(row, col)
    % maps row and column indices to DTMF key character
    row_chars = '123A';
    col_chars = '456B';
    key = [row_chars(row), col_chars(col)];
end
