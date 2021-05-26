from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from pymongo import MongoClient

import _init_paths


import logging
import os
import os.path as osp
from opts import opts
from tracking_utils.utils import mkdir_if_missing
from tracking_utils.log import logger
import datasets.dataset.jde as datasets
from track import eval_seq
import cv2


logger.setLevel(logging.INFO)


def demo(opt):
    result_root = opt.output_root if opt.output_root != '' else '.'
    mkdir_if_missing(result_root)

    logger.info('Starting tracking...')
    # cap = cv2.VideoCapture('./videos/MOT16-03.mp4')
    # while(cap.isOpened()):
    #     print("dddddddddddddddd")
    #     ret, frame = cap.read()
    #     gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    #     cv2.imshow('frame', gray)
    #
    #     if cv2.waitKey(1)&0xFF == ord('q'):
    #         break
    # cap.release()
    # cv2.destroyAllWindows()
    #
    # result_root = ../demos
    # opt.input_video = ../videos/MOT16-03.mp4
    # opt.img_size = (1088, 608)
    # print("dddddddddddd",os.listdir(os.getcwd()))

    # mongo db
    connection = MongoClient('localhost', 27017)
    db = connection.get_database('teamA')
    print(db.list_collection_names())
    collection = db.get_collection('localInfo')

    # db.localInfo.remove()
    # db.createCollection('localInfo')

    ####video make

    # dataloader = datasets.LoadVideo('../videos/our.mp4', opt.img_size)

    dataloader = datasets.LoadVideo('../videos/cctvDemo.mov', opt.img_size)



    result_filename = os.path.join('../demos/cctvDemo_results.txt') # ../demos/results.txt
    frame_rate = dataloader.frame_rate #24 852 480 724 / 30 1920 1080 916
    width = dataloader.vw
    height = dataloader.vh
    print("1111111", frame_rate, width, height)


    frame_dir = None if opt.output_format == 'text' else osp.join(result_root, 'frame')


    #'''
    # eval_seq(track) -> plot_tracking(visualization)
    eval_seq(opt, dataloader, 'mot', result_filename, collection, save_dir=frame_dir, show_image=False, frame_rate=frame_rate)

    if opt.output_format == 'video':
        output_video_path = osp.join(result_root, 'cctvDemo_result.mp4')
        cmd_str = 'ffmpeg -f image2 -i {}/%05d.jpg -b 5000k -c:v mpeg4 {}'.format(osp.join(result_root, 'frame'), output_video_path)
        os.system(cmd_str)
    #'''


if __name__ == '__main__':
    os.environ['CUDA_VISIBLE_DEVICES'] = '0'
    opt = opts().init()
    demo(opt)
