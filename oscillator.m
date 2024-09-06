function x = oscillator(freq, fs, dur, A, D, S, R)
    % Create the time vector from 0 to duration with a step of 1/sampling_rate
    t = 0:1/fs:dur;

    % Create the sine wave
    sine_wave = sin(2*pi*freq*t);

    % Total number of samples
    total_samples = length(t);

    % Compute the number of samples for each envelope part
    num_attack_samples = floor(A * fs);
    num_decay_samples = floor(D * fs);
    num_release_samples = floor(R * fs);
    num_sustain_samples = total_samples - (num_attack_samples + num_decay_samples + num_release_samples);

    % Ensure that we do not have a negative number of sustain samples
    num_sustain_samples = max(num_sustain_samples, 0);

    % Compute the attack envelope
    attack_envelope = linspace(0, 1, num_attack_samples);

    % Compute the decay envelope
    decay_envelope = linspace(1, S, num_decay_samples);

    % Compute the sustain envelope
    sustain_envelope = S * ones(1, num_sustain_samples);

    % Compute the release envelope
    release_envelope = linspace(S, 0, num_release_samples);

    % Concatenate the attack, decay, sustain, and release envelopes
    final_envelope = [attack_envelope decay_envelope sustain_envelope release_envelope];

    % Adjust the final envelope to match the length of the sine wave, just in case of rounding issues
    if length(final_envelope) > total_samples
        final_envelope = final_envelope(1:total_samples);
    elseif length(final_envelope) < total_samples
        final_envelope = [final_envelope zeros(1, total_samples - length(final_envelope))];
    end

    % Multiply the sine wave by the envelope to apply the amplitude modulation
    x = sine_wave' .* final_envelope';
end


