%GET_SCALED_CSI Converts a CSI struct to a channel matrix H.
%
% (c) 2008-2011 Daniel Halperin <dhalperi@cs.washington.edu>
%
function ret = get_scaled_csi(csi_st)
    % Pull out CSI
    %csi는 복소수이다.
    csi = csi_st.csi;
    
    
    % Calculate the scale factor between normalized CSI and RSSI (mW)
    %conj는 켤레 복소수를 구한다. 켤레 복소수와 복소수를 곱해 복소수를 실수로 만듬
    %2 - 2i * 2 + 2i = 8 과 같이
    csi_sq = csi .* conj(csi);
    %csi_sq(:)는 일열로 만든 후 모든 값을 더함
    csi_pwr = sum(csi_sq(:));
    %dbinv는 10.^(x/10)을 반환 데시벨을 변환함
    %rss값을 데시벨을 변환한 후 더한 다음 다시 'pow'를 이용해 데시벨로 바꿔준 후 agc와 44를 빼줌 
    rssi_pwr = dbinv(get_total_rss(csi_st));
    %   Scale CSI -> Signal power : rssi_pwr / (mean of csi_pwr)
    % subcarrier수인 30개로 나누면 평균 CSI_pwr값이 나옴 그값을 rssi_pwr에 나눔
    scale = rssi_pwr / (csi_pwr / 30);

    % Thermal noise might be undefined if the trace was
    % captured in monitor mode.
    % ... If so, set it to -92
    % noise가 -127보다낮을 경우 -92로 설정 아닐 경우 기존 noise사용
    if (csi_st.noise == -127)
        noise_db = -92;
    else
        noise_db = csi_st.noise;
    end
    thermal_noise_pwr = dbinv(noise_db);

    
    % Quantization error: the coefficients in the matrices are
    % 8-bit signed numbers, max 127/-128 to min 0/1. Given that Intel
    % only uses a 6-bit ADC, I expect every entry to be off by about
    % +/- 1 (total across real & complex parts) per entry.
    %
    % The total power is then 1^2 = 1 per entry, and there are
    % Nrx*Ntx entries per carrier. We only want one carrier's worth of
    % error, since we only computed one carrier's worth of signal above.
    % 이와 같은 공식으로 error를 구함
    quant_error_pwr = scale * (csi_st.Nrx * csi_st.Ntx);

    % Total noise and error power
    total_noise_pwr = thermal_noise_pwr + quant_error_pwr;

    % Ret now has units of sqrt(SNR) just like H in textbooks
    ret = csi * sqrt(scale / total_noise_pwr);
    if csi_st.Ntx == 2
        ret = ret * sqrt(2);
    elseif csi_st.Ntx == 3
        % Note: this should be sqrt(3)~ 4.77 dB. But, 4.5 dB is how
        % Intel (and some other chip makers) approximate a factor of 3
        %
        % You may need to change this if your card does the right thing.
        ret = ret * sqrt(dbinv(4.5));
    end
end
