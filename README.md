# GCU_WifiSensing




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
+ We use 

## Experiment


## Result
### CSI Demo Video
![csi_output](https://user-images.githubusercontent.com/49142825/120190195-3a3bbe00-c253-11eb-98af-b8d17e16d04c.gif)

## Appendix





[CSI_Tool]: https://dhalperi.github.io/linux-80211n-csitool/ "802.11n CSI Tool"
[read_bf_socket]: https://github.com/lubingxian/Realtime-processing-for-csitool "Realtime-processing-for-csitool"
[supplementary]: https://github.com/dhalperi/linux-80211n-csitool-supplementary "linux-80211n-csitool-supplementary
"
