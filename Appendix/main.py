import numpy as np
from function import PixelMapper, save_lonlat_frame, scaling
##############################################################################

'''
pixel : 실제 공간
lonloat : 도면 공간
실제 mapping 되는 곳에 좌표를 입력 @@@.py 사용
오른쪽 위, 왼쪽 위, 왼쪽 아래, 오른쪽 아래 순서
'''

quad_coords = {
    #10
    "pixel": np.array([
        [1622, 502],  # Third lampost top right
        [1066, 286],  # Corner of white rumble strip top left
        [700, 934],  # Corner of rectangular road marking bottom left
        [1612, 643]  # Corner                                      of dashed line bottom right
    ]),
    "lonlat": np.array([
        [439, 276],  # Third lampost top right
        [113, 58],  # Corner of white rumble strip top left
        [113, 601],  # Corner of rectangular road marking bottom left
        [439, 385]  # Corner of dashed line bottom right
    ])

    # #11
    # "pixel": np.array([
    #     [672, 326],  # Third lampost top right
    #     [215, 506],  # Corner of white rumble strip top left
    #     [261, 650],  # Corner of rectangular road marking bottom left
    #     [1019, 827]  # Corner of dashed line bottom right
    # ]),
    # "lonlat": np.array([
    #     [874, 113],  # Third lampost top right
    #     [602, 276],  # Corner of white rumble strip top left
    #     [602, 384],  # Corner of rectangular road marking bottom left
    #     [874, 547]  # Corner of dashed line bottom right
    # ])


}

#PixelMapper로 값 전달
pm = PixelMapper(quad_coords["pixel"], quad_coords["lonlat"])

##############변경해야하는 부분#######################
# 좌표값을 받아야함(하나씩)
f = open("results10-2.txt", 'r')
##################################################
frame = 0
point = dict()
while True:
    line = f.readline()

    if not line:
        break

    info = line[:-1].split(" ")

    frame = info[0]

    if info[0] in point:
        line = point.get(info[0])
        line.append(list(map(int, info[1:])))
    else:
        point[info[0]] = [list(map(int, info[1:]))]

f.close()

print(point)

###########################################################################

print("start")

save_lonlat_frame(point, pm, int(frame), 'maps.png', 'demo10-2')

print("end")

# ###########################################################################
# #scaling
# file = open('./scalingPoint.txt', 'w')
#
# for i in range(int(frame)):
#     for j in point.get(str(i+1)):
#         x_scaled, y_scaled = scaling(j[1], j[2], weight, height)
#         file.writelines(str(i+1) + ' ' + str(j[0]) +' ' + str(x_scaled) +' '+str(y_scaled) + '\n')
#
# file.close()
#
# #############################################################################