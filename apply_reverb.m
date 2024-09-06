function output_signal = apply_reverb(signal, impulse_response)
    if size(impulse_response, 2) > 1
        impulse_response = stereo_to_mono(impulse_response);
    end
    output_signal = fftconv(signal, impulse_response);
    output_signal = output_signal / max(abs(output_signal));
end


