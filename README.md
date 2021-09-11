# GCU_WifiSensing

<div>
        <b>Project name: GCU WiFiSensing (2020.07 ~ 2021.06)</b><br>
        <b>Team members: 이재윤(Jaeyoon Lee), 정은서(Eunseo Jeong), 여찬영(Chanyeong Yeo)</b>
</div><br>

<h3>System architecture</h3>

![struct](https://user-images.githubusercontent.com/57625667/120338235-01711700-c32f-11eb-92d5-12514e8b48e2.png)

In our project, Fair MOT and Linux 802.11n CSI tool library were used. Each library was used when recognizing and tracking objects from the video data received from the initial camera and when collecting and quantifying Wi-Fi CSI data from the AP.


## CSI

+ We use the [802.11n CSI Tool][CSI_Tool] for Wi-Fi Sensing. So Reference [this link][CSI_Tool] and install 802.11n CSI Tool
+ Install Matlab program, and Downlad Our CSI file(Reference for [Realtime-processing-for-csitool][read_bf_socket], [linux-80211n-csitool-supplementary][supplementary]) this file read csi data and output csi matrix
+ Install success next step

1. our File:

        git clone https://github.com/jyoonlee/GCU_WifiSensing.git


2. In matlab:

        cd CSI
        cd matlab
        run read_bf_socket using Matlab
    
3. In terminal:

       sudo stop network-manager
       sudo modprobe -r iwlwifi mac80211
       sudo modprobe iwlwifi connector_log=0x1

4. In other terminal(connect Wifi):
        
        iw dev
        sudo ip link show wlan0
        sudo ip link set wlan0 up
        iw wlan0 link
        sudo iw dev wlan0 connect [WiFi name]
        iw wlan0 link
        sudo dhclient wlan0
        
5. connet csi:
         
        cd CSI
        cd linux-80211n-csitool-supplementary-master/netlink
        gcc log_to_server.c -o log_to_server
        sudo ./log_to_server 127.0.0.1 8090

6. ping test
           
        ping -i 0.2 192.168.1.1
        





## FairMOT
+ We used [FairMOT][FairMOT] model and changed the code according to us.
+ We referred to [this link][FairMOT] for FairMOT code.

+ installation 
        
        conda create -n FairMOT
        conda activate FairMOT
        conda install pytorch==1.7.0 torchvision==0.8.0 cudatoolkit=10.2 -c pytorch
        cd ${FAIRMOT_ROOT}
        pip install -r requirements.txt
+ baseline model
  pretrain model fairmot_dla34.pth [Google][pretrain_model] Reference [this link][FairMOT]
  Model save structure
  
          ${FAIRMOT_ROOT}
           └——————models
                   └——————fairmot_dla34.pth
                   └——————...
           └——————src
                   └——————...
           └——————video
                   └——————video
           └——————demo
                   └——————result.txt
                   └——————frame image
                   └——————output.mp4
                   └——————...


+ Use FairMOT Object Detection
        
        cd ${FAIRMOT_ROOT(Object Detection)}
        cd src
        python demo.py mot --load_model ../models/fairmot_dla34.pth --conf_thres 0.4
 
+ result.txt output
        
        YY-MM-DD hh:mm:ss       object label

+ Use FairMOT position
        
        cd ${FAIRMOT_ROOT(Position)}
        cd src
        python demo.py mot --load_model ../models/fairmot_dla34.pth --conf_thres 0.4

+ result.txt output
        
        frame_number    Object id       position x      position y


## Experiment

+ Use TrainModel.py
        
        python TrainModel.py

+ input
1. CSI Data
2. Object Detection Result.txt

+ Progress
1. synchronize csi label and Result.txt
2. Use Randomforest



## Result
### CSI Demo Video
![csi_output](https://user-images.githubusercontent.com/49142825/120190195-3a3bbe00-c253-11eb-98af-b8d17e16d04c.gif)

### MOT Demo Video
[![MOT_output](https://user-images.githubusercontent.com/57625667/119636222-615b4f80-be4f-11eb-9e6c-1bb084599b41.png)](https://youtu.be/T1cR2hBOlt8)

### Experiment
<img src="https://user-images.githubusercontent.com/49142825/120305804-27d18b00-c30c-11eb-845b-fb719730e0cf.png"  width="640" height="400">






[CSI_Tool]: https://dhalperi.github.io/linux-80211n-csitool/ "802.11n CSI Tool"
[read_bf_socket]: https://github.com/lubingxian/Realtime-processing-for-csitool "Realtime-processing-for-csitool"
[supplementary]: https://github.com/dhalperi/linux-80211n-csitool-supplementary "linux-80211n-csitool-supplementary"
[FairMOT]: https://github.com/ifzhang/FairMOT "FairMOT"
[pretrain_model]: https://drive.google.com/file/d/1iqRQjsG9BawIl8SlFomMg5iwkb6nqSpi/view "pretrain_model"
