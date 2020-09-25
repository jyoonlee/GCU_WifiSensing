%GET_TOTAL_RSS Calculates the Received Signal Strength (RSS) in dBm from
% a CSI struct.
%
% (c) 2011 Daniel Halperin <dhalperi@cs.washington.edu>
%
function ret = get_total_rss(csi_st)
    %인수가 전달되었는지 확인
    error(nargchk(1,1,nargin));

    % Careful here: rssis could be zero
    rssi_mag = 0;
    %rssi의 a,b,c를 0인지 확인하고아닐경우
    %dbinv는 10.^(x/10)을 반환 a,b,c 순서대로 더함
    if csi_st.rssi_a ~= 0
        rssi_mag = rssi_mag + dbinv(csi_st.rssi_a);
    end
    if csi_st.rssi_b ~= 0
        rssi_mag = rssi_mag + dbinv(csi_st.rssi_b);
    end
    if csi_st.rssi_c ~= 0
        rssi_mag = rssi_mag + dbinv(csi_st.rssi_c);
    end
    %db를 통해 데시벨로 표현한 후 44와 agc값을 빼줌
    ret = db(rssi_mag, 'pow') - 44 - csi_st.agc;
end