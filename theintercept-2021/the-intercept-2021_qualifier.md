# Layerone - The Intercept 2021

![2019_intercept__ctf_color.png](./images/2019_intercept__ctf_color.png "2019_intercept__ctf_color.png")


`We got some new toys here in the lab, but there’s something a bit off about them. We’ve noticed they don’t seem to be doing what the manufacturers described – could we be victims of supply chain attack? The lab monkeys are hard to understand (all that techno-mumbo-jumbo), but they’re saying the devices seem to be emitting a variety of strange signals. As always we need your help to figure things out. We’ve left the package at the arranged location. Can you intercept and decipher all the strange signals?`

## Qualifiers Challenge

The Intercept is a hardware Capture the Flag (CTF) event focused on testing your skills in hardware hacking, anti-tamper technologies, reverse engineering, programming, and more! For 2021, LayerOne is a virtual event so the Intercept team have prepared devices to ship out to various teams to compete in the CTF. To qualify, each team needed to solve the following qualifying challenge.

### The Problem

The challenge was presented as a zip file download, `layerone-intercept-quals.7z`. Once decompressed, you got the mp4 file `layerone-emitting-diode.mp4`. This was an approximately 25 minute long video with an animated image of a blinking LED. 

![layerone-emitting-diode.png](./images/layerone-emitting-diode.png "layerone-emitting-diode.png")

Our team started with `binwalk` and `exiftool` but didn't find any stenography present. Then, based on the premise of the Intercept, we started looking more into possible signals to decode from the presented problem. The first thought was morse code but the pattern of the blinking LED in the video didn't follow any strict morse code patterns and also seemed to have varying levels of luminance, not strictly binary ON or OFF states. 

Thinking back to stories of data ex filtration via blinking HDD activity lights, I started to dig into the possibility of the LED in the video transmitting data. @SickPea first used `ffmpeg` to start extracting individual frames from the video to analyze them individually. I took a slightly different route using a python script and `opencv` to analyze the video frame by frame, isolating a single pixel within the lens of the LED and recording it's changing color value throughout the duration of the video. The first time I ran the script, I got `51600` RGB values. The even-ness of this number stood out. I disregarded the blue and green values, only paying attention to the red. The following is an section of the values I got from the frame-by-frame analysis:
```
190
190
190
190
52
138
148
148
146
150
148
148
148
148
163
114
48
40
40
40
40
40
54
190
190
190
190
190
171
```
What immediately stood out was the most of the numbers either in the range of 40-60 or 100+. Also, there were single frames where the value would jump between the two groups of numbers (like the 52 on line 5 in the above example). This indicated to me that we were meant to be analyzing every single frame of the video on a frame-by-frame basis, and that there were two distinct groupings of numbers so it was probably binary data. 

I interpolated the red color values to 1's and 0's by setting it to 1 if the value was greater than 100, or 0 if it was less than 100, and then seperated the resulting data into 8 digit chunks, thinking that it might be binary bytes. This didn't lead to any useful data, however it let us visually see the data and patterns started to emerge. Experimenting with the size of the groups of 'bits' definite patterns started to emerge.

\newpage

"Binary" data with no grouping. 

![bits.png](./images/bits.png "bits.png")

\newpage

Groups of 100. 

![100.png](./images/100.png "100.png")

At this point I thought I might be seeing ASCII art, and @zachhanson94 confirmed that it looked like an image, so I kept at it. Eventually I saw something that looked like the LayerOne logo and I knew we were close. 

\newpage 

### The Solve

We ended up landing on 129 rows of 400 characters each. After playing with the font size and color in the terminal, you can clearly see the LayerOne logo and with the flag `flag{s33_n0t_th4t_h4rd}` in ComicSans below. 

![flag.png](./images/flag.png "flag.png")

### The Code

```python
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
```
#### Afterthoughts

This was a fun warm-up for the Intercept. I've never analyzed video frames using python and OpenCV before so that's a good tool to add to the kit. Overall this was a fun and interesting challenge. 

### Shouts

Thanks to DG and jrozner for organizing the Intercept. 

Thanks to our team, Never Say Die, which for this CTF includes SickPea, babint, wasabi, tr_h, zachhanson94 and blinkingthing.  

[LayerOne](https://www.layerone.org/)

