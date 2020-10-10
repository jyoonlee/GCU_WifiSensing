
i = 1;

T = [];
V = [];


while(i<5000)

    
csi_trace = read_bf_file('C:\Users\ACA\Documents\MATLAB\matlab\test_data\2018_05_14_sit01_01.dat');
csi_entry = csi_trace{i};
csi = get_scaled_csi(csi_entry);

csi_trace2 = read_bf_file('C:\Users\ACA\Documents\MATLAB\matlab\real_data\walking10.data');
csi_entry2 =  csi_trace2{i};
csi2 = get_scaled_csi(csi_entry2);



A = abs(csi);
%A = angle(csi);
%B = db(A);
B = A;
C1 = abs(csi2);
C2 = abs(csi2);

C = cat(3,V,B);
T = cat(3,T,V,B);

 
 subplot(2,1,1);
 plot(squeeze(T).');
 
 xlim([0, 4000]);
 ylim([-10 ,30]);
 legend('Rx Antenna A', 'Rx AntennaB', 'Rx Anttenna C');
 xlabel('Subcarrier index');
 ylabel('SNR [dB]');
 
 
 
 subplot(2,1,2);
 
 
 plot(squeeze(C2).');
 
 ylim([0 ,30]);
 legend('Rx Antenna A', 'Rx AntennaB', 'Rx Anttenna C');
 xlabel('Subcarrier index');
ylabel('SNR [dB]');
 
 
 
 pause(0.01);
 
 V = B;
 
 
 
 hold on;
 cla reset;
 
 i = i + 1;

end

