
it = 1; %% it : �������� ���� ������ ã�� iterator

while(it <= 40) %���ϰ����� ���� ���ڸ� �޸� �Ѵ�.
    
ARR_1 = zeros(1,30);
ARR_2 = zeros(1,30);
ARR_3 = zeros(1,30);
ARR_OUT = zeros(4900,90); %% 500���� ��� �ʹٸ� zeros(500,90)

k = 1; %�ݺ�(iteration)�� ���� �ʱ�ȭ
t = 1; %Ư�� �κк��� �߶� �������� ���� ��, ���ʽ������� ���� 

%str = 'C:\Users\ACA\PycharmProjects\UnionProject\DAT\2018_05_28_empty16.dat';
if(it<=9)
strt = sprintf('%s%d%s', 'C:\Users\ACA\PycharmProjects\UnionProject\DAT\2018_05_28_sitdown0',it,'.dat');
else
strt = sprintf('%s%d%s', 'C:\Users\ACA\PycharmProjects\UnionProject\DAT\2018_05_28_sitdown',it,'.dat');
end

csi_trace = read_bf_file(strt);
disp(strt);
while(k <= 4900)

csi_entry = csi_trace{t};
csi = get_scaled_csi(csi_entry);

A = abs(csi);
%B = db(A);

i = 1;
while(i<=30)
   
    ARR_1(i) = A(:,1,i);
    ARR_2(i) = A(:,2,i);
    ARR_3(i) = A(:,3,i);
    i = i + 1;
    
end

ARR_FINAL = [ARR_1,ARR_2,ARR_3]; %��ġ��
ARR_OUT(k,:) = ARR_FINAL;

%disp(k);
k = k + 1;
t = t + 1;
end


string = sprintf('%s%s', strt, '.csv');
csvwrite(string , ARR_OUT);
it = it + 1;

end


