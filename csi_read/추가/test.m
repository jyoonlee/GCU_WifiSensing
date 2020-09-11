
i = 1;

T = [];
V = [];

S_Phase = [];
oldPhase = [];

while(i<1000)

    
csi_trace = read_bf_file('D:\Matlab\matlab\real_data\running11.data');
csi_entry = csi_trace{i};
csi = get_scaled_csi(csi_entry);


csi_trace2 = read_bf_file('D:\Matlab\matlab\real_data\running11.data');
csi_entry2 =  csi_trace2{i};
csi2 = get_scaled_csi(csi_entry2);



A = abs(csi);
B = db(A);


Phase = angle(csi);
ABC1 = Phase(1,1,:);
ABC2 = Phase(1,2,:);
ABC3 = Phase(1,3,:);

PABC1 = sanitize_phase(ABC1);
PABC2 = sanitize_phase(ABC2);
PABC3 = sanitize_phase(ABC3);

UABC =[PABC1 PABC2 PABC3];
Phase = UABC;

%PPhase = Phase(1,:,:);
%PPhase1 = squeeze(PPhase);
%PPPhase = sanitize_phase(PPhase1);
%Phase = PPPhase;

%C1 = abs(csi2);
%C2 = db(C1);

C2 = angle(csi2);

%C = cat(3,V,B);
%T = cat(3,T,V,B);

S_Phase = cat(3,S_Phase,oldPhase,Phase);

subplot(2,1,1);
plot(squeeze(S_Phase).');

xlim([0, 30]);
ylim([-100 , 100]);
legend('Rx Antenna A', 'Rx AntennaB', 'Rx Anttenna C');
xlabel('Subcarrier index');
ylabel('SNR [dB]');



subplot(2,1,2);


plot(squeeze(C2).');

ylim([-6 ,4]);
legend('Rx Antenna A', 'Rx AntennaB', 'Rx Anttenna C');
xlabel('Subcarrier index');
ylabel('SNR [dB]');



pause(0.02);

V = B;
oldPhase = Phase;


hold on;
%cla reset;

i= i+1;

end

