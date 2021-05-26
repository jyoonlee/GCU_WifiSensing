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
    # ch01 - 20210512 - 170547 - 170807 - 101000000000
    # ch01-20210512-192233-194121-101000000000
    video_name = 'ch01-20210512-192106-194821-101000000000.mp4'

    dataloader = datasets.LoadVideo('../videos/'+video_name, opt.img_size)



    result_filename = os.path.join('../demos/0512_results.txt') # ../demos/results.txt
    frame_rate = dataloader.frame_rate

    frame_dir = None if opt.output_format == 'text' else osp.join(result_root, 'frame')
    print(video_name)
    video_name = (video_name.split('-')[1]+video_name.split('-')[2]).replace(" ","")
    print(video_name)
    #'''
    # eval_seq(track) -> plot_tracking(visualization)
    eval_seq(opt, video_name, dataloader, 'mot', result_filename, save_dir=frame_dir, show_image=False, frame_rate=frame_rate)

    if opt.output_format == 'video':
        output_video_path = osp.join(result_root, '0512_result.mp4')
        cmd_str = 'ffmpeg -f image2 -i {}/%05d.jpg -b 5000k -c:v mpeg4 {}'.format(osp.join(result_root, 'frame'), output_video_path)
        os.system(cmd_str)
    #'''


if __name__ == '__main__':
    os.environ['CUDA_VISIBLE_DEVICES'] = '0'
    opt = opts().init()
    demo(opt)
