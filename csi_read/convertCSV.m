
it = 1; %% it : �������� ���� ������ ã�� iterator
flag = 0; %% collection ���� �ߺ� ������ 

while(it <= 2) %���ϰ����� ���� ���ڸ� �޸� �Ѵ�.
    
ARR = zeros(1,30);
% ARR_1_2 = zeros(1,30);
% ARR_1_3 = zeros(1,30);
% ARR_2_1 = zeros(1,30);
% ARR_2_2 = zeros(1,30);
% ARR_2_3 = zeros(1,30);
ARR_OUT = zeros(26,30); %% 500���� ��� �ʹٸ� zeros(500,90)

k = 1; %�ݺ�(iteration)�� ���� �ʱ�ȭ
t = 1; %Ư�� �κк��� �߶� �������� ���� ��, ���ʽ������� ���� 



csi_trace = read_bf_file('csi_clear_1.dat');
% disp('csi_6.dat');
while(k <= 26)

csi_entry = csi_trace{t};
csi = get_scaled_csi(csi_entry);

A = abs(csi);

%B = db(A);

i = 1;

while(i<=30)
    if size(A,1) == 1
        ARR(i) = (A(:,1,i) + A(:,2,i) +A(:,3,i))/3;
    end
    if size(A,1) == 2
        ARR(i) = (A(1,1,i) + A(1,2,i) + A(1,3,i) + A(2,1,i) + A(2,2,i) + A(2,3,i))/6;
%     ARR_1_1(i) = A(1,1,i);
%     ARR_1_2(i) = A(1,2,i);
%     ARR_1_3(i) = A(1,3,i);
%     ARR_2_1(i) = A(2,1,i);
%     ARR_2_2(i) = A(2,2,i);
%     ARR_2_3(i) = A(2,3,i);
    end
    i = i + 1;
    
end
%if size(A,1) == 1
% ARR_FINAL = [ARR_1_1,ARR_1_2,ARR_1_3]; %��ġ��
%end
%if size(A,1) == 2
%ARR_FINAL = [ARR_1_1,ARR_1_2,ARR_1_3, ARR_2_1, ARR_2_2, ARR_2_3] %��ġ��
%end

ARR_OUT(k,:) = ARR;

%disp(k);
k = k + 1;
t = t + 1;
end

% mongodb connection 
server = "localhost";
port = 27017;
dbname = "admin";
conn = mongo(server,port,dbname)

if flag == 0
    collection = "csi_data";
    createCollection(conn,collection);
    flag = 1;
end

% check connection
isopen(conn)

for i = 1:(k-1)
    csi_data.timestamp = i;
    csi_data.data = ARR_OUT(i,:);
    n = insert(conn,collection,csi_data);
end

%string = sprintf('%s%s', 'csi_clear_1', '.csv');
%csvwrite(string , ARR_OUT);
it = it + 1;
end


