function filtered_signal = low_pass(x, fs, fc)
    % Compute the Fourier Transform of the signal x
    X = fft(x);

    % Number of points in FFT
    N = length(X);

    % Compute all possible frequencies of the signal
    frequencies = (0:N-1) * (fs / N);

    % Create a vector mask that is 1 for frequencies lower than the cutoff frequency fc
    % and 0 for frequencies higher than the cutoff frequency
    mask = frequencies <= fc;

    % To handle the symmetry in FFT for real signals, apply mask to both halves
    mask = mask | (frequencies >= fs - fc);

    % Apply the Hadamard product between the Fourier Transform of the signal and the mask
    Y = X .* mask;

    % Compute the inverse Fourier Transform to get the filtered signal
    filtered_signal = ifft(Y);

    % Normalize the filtered signal
    filtered_signal = filtered_signal / max(abs(filtered_signal));
end


