<h1>Rainbow Vomit</h1>

Challenge Text
```
o.O What did YOU eat for lunch?!

The flag is case insensitive.

Dev: Tom
 Hint! Replace spaces in the flag with { or } depending on their respective places within the flag.
 Hint! Hues of hex
 Hint! This type of encoding was invented by Josh Cramer.
 output.png 
```

output.png looked like this

[![](https://github.com/blinkingthing/ctfs/blob/master/rtcp-houseplant/Rainbow%20Vomit/output.png "output.png")](#)

This scrambled colorful mess looked like similair to piet but the hint references encoding by Josh Cramer. Searching Josh Cramer encoding yielded [hexahue](https://www.geocachingtoolbox.com/index.php?lang=en&page=hexahue). An alphabet substituted by sets of colored rectangles. Each rectangle is a different 2x3 containing 6 pixels with a different combination of red, green, blue, cyan, magenta and yellow pixels for each letter. There is also some grayscale for punctuation, numbers and spaces. 

I tried to decode this manually but it was stressful on my eyes so I decided to stumble through python to solve this. I would love to hear some solutions on how to make this code more efficient, but I did a lot of learning as I figured out what I needed to do step by step.

I first eliminated the white borders. Then I disected the image into arrays where I could target each pixel position of each 2x3 section that represented a character. Then I built a dictionary equating letters to sets of six colors red, green, blue, cyan, magenta and yellow. Next I equated those colors to specific RGB values. Then it was just a matter of scanning RGB values for all pixels in the image while organizing the pixels into sets of 6 for each representation of a character.

After some trial and error and lots of print statements I was presented with the output:

```
there is such as thing as a tomcat but have you ever heard of a tomdog. this is the most important ?uestion of our time, and unfortunately one that may never be answered by modern science. the definition of tomcat is a male cat, yet the name for a male dog is max. wait no. the name for a male dog is just dog. regardless, what would happen if we were to combine a male dog with a tomcat. perhaps wed end up with a dog that vomits out flags, like this one rtcp should,fl5g4,b3,st1cky,or,n0t
```
the solution could be figured out with the last sentence. Maybe I should've started there. ;)
*rtcp{should,fl5g4,b3,st1cky,or,n0t}*



