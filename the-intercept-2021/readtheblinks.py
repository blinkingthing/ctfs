#!/usr/bin/env python3

# importing required libraries
import cv2
import numpy as np
import sys
  
# taking the input from webcam
vid = cv2.VideoCapture('layerone-emitting-diode.mp4')

bit = ""
byte = ""
bitcount = 0

#get number of
framecount = int(vid.get(cv2.CAP_PROP_FRAME_COUNT))
  
#loop until you run out of frames
while bitcount < framecount:
  
	# capturing the current frame
	_, frame = vid.read()
  
	# displaying the current frame
	cv2.imshow("frame", frame)

	#target pixel
	target_x = 100
	target_y = 545

	#target pixel with y,x (row,column)
	target_color = frame[target_y,target_x]

	#if value is less than 100, bit is 0 else it's a 1
	if int(target_color[2]) < 100 : 
		bit = "0"
	else: 
		bit = "1"

	byte = byte + bit
	bitcount += 1

	#eperimentation led to a "byte" count of 400. really it's a line count.
	if bitcount %400 == 0:
		print(byte)
		byte =""