function [S, f, t] = spectrogram(signal, fs, window_size)
    num_windows = floor(length(signal) / window_size);
    S = zeros(window_size + 1, num_windows);
    N = 2 * window_size;
    f = (0:N/2) * (fs / N);
    t = (0:num_windows - 1) * (window_size / fs);
    for i = 1:num_windows
        start_index = (i - 1) * window_size + 1;
        segment = signal(start_index:start_index + window_size - 1);
        windowed_segment = segment .* hanning(window_size);
        fft_result = fft(windowed_segment, 2 * window_size);
        magFFT = abs(fft_result(1:window_size + 1));
        S(:, i) = magFFT;
    end
end

