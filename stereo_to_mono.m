function mono = stereo_to_mono(stereo)
    mono = zeros(size(stereo, 1), 1);

    for i = 1:size(stereo, 1)
        mono(i, 1) = mean(stereo(i, :));
    endfor

    max_val = max(abs(mono));
    if max_val ~= 0
        mono = mono / max_val;
    endif
end

