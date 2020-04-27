from PIL import Image
import scipy.misc as smp

im = Image.open('output.png')
rgb_im = im.convert('RGB')

#six pixels per charachter arranged in these positions
# A1 A2
# B1 B2
# C1 C2
# arrays of pixel positions
A1 = []
A2 = []
B1 = []
B2 = []
C1 = []
C2 = []

#rgb values for each color
re = (255,0,0)
gr = (0,255,0)
bl = (0,0,255)
ye = (255,255,0)
cy = (0,255,255)
ma = (255,0,255)
blk = (0,0,0)
wh = (255,255,255)
gry = (128,128,128)

#colors in order A1,A2,B1,B2,C1,C2 for each possible charachter
a = (ma,re,gr,ye,bl,cy)
b = (re,ma,gr,ye,bl,cy)
c = (re,gr,ma,ye,bl,cy)
d = (re,gr,ye,ma,bl,cy)
e = (re,gr,ye,bl,ma,cy)
f = (re,gr,ye,bl,cy,ma)
g = (gr,re,ye,bl,cy,ma)
h = (gr,ye,re,bl,cy,ma)
ii = (gr,ye,bl,re,cy,ma)
j = (gr,ye,bl,cy,re,ma)
k = (gr,ye,bl,cy,ma,re)
l = (ye,gr,bl,cy,ma,re)
m = (ye,bl,gr,cy,ma,re)
n = (ye,bl,cy,gr,ma,re)
o = (ye,bl,cy,ma,gr,re)
p = (ye,bl,cy,ma,re,gr)
q = (bl,ye,cy,ma,re,gr)
r = (bl,cy,ye,ma,re,gr)
s = (bl,cy,ma,ye,re,gr)
t = (bl,cy,ma,re,ye,gr)
u = (bl,cy,ma,re,gr,ye)
v = (cy,bl,ma,re,gr,ye)
w = (cy,ma,bl,re,gr,ye)
x = (cy,ma,re,bl,gr,ye)
y = (cy,ma,re,gr,bl,ye)
z = (cy,ma,re,gr,ye,bl)
period = (blk,wh,wh,blk,blk,wh)
comma = (wh,blk,blk,wh,wh,blk)
space = (wh,wh,wh,wh,wh,wh)
zero = (blk,gry,wh,blk,gry,wh)
one = (gry,blk,wh,blk,gry,wh)
two = (gry,wh,blk,blk,gry,wh)
three = (gry,wh,blk,gry,blk,wh)
four = (gry,wh,blk,gry,wh,blk)
five = (wh,gry,blk,gry,wh,blk)
six = (wh,blk,gry,gry,wh,blk)
seven = (wh,blk,gry,wh,gry,blk)
eight = (wh,blk,gry,wh,blk,gry)
nine = (blk,wh,gry,wh,blk,gry)

alphabet = [a,b,c,d,e,f,g,h,ii,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,period,comma,space,zero,one,two,three,four,five,six,seven,eight,nine]

xoffset = 2
yoffset = 2

pixels = list(im.getdata())
width, height = im.size

pixels = [pixels[i * width:(i + 1) * width] for i in xrange(height)]


#rint("width = "+str(width))
#print("height = "+str(height))


#print("deleted border")
#print("width = "+str(width))
#print("height = "+str(height))



charswide = (width - (xoffset*2)) / 2
charshigh = (height - (yoffset*2)) / 3
totalchars = charswide * charshigh



#print("charachters wide = "+str(charswide))
#print("charachters high = "+str(charshigh))
#print("total charchters = "+str(totalchars))


#print("length of pixels[] = "+str(len(pixels)))

#print(pixels)

#delete extra columns
for row in pixels:
    del row[103]
    del row[102] 
    del row[1]
    del row[0]
    #for tup in row:
    #  print(tup)

#delete extra rows
del pixels[33]
del pixels[32]
del pixels[1]
del pixels[0]
    
#print(pixels)

#print("length of pixels[] = "+str(len(pixels)))

#print(A1)
#print(len(A1))
A = []
B = []
C = []

A.extend(pixels[0])
A.extend(pixels[3])
A.extend(pixels[6])
A.extend(pixels[9])
A.extend(pixels[12])
A.extend(pixels[15])
A.extend(pixels[18])
A.extend(pixels[21])
A.extend(pixels[24])
A.extend(pixels[27])

B.extend(pixels[1])
B.extend(pixels[4])
B.extend(pixels[7])
B.extend(pixels[10])
B.extend(pixels[13])
B.extend(pixels[16])
B.extend(pixels[19])
B.extend(pixels[22])
B.extend(pixels[25])
B.extend(pixels[28])

C.extend(pixels[2])
C.extend(pixels[5])
C.extend(pixels[8])
C.extend(pixels[11])
C.extend(pixels[14])
C.extend(pixels[17])
C.extend(pixels[20])
C.extend(pixels[23])
C.extend(pixels[26])
C.extend(pixels[29])

A1.extend(A[0::2])
A2.extend(A[1::2])
B1.extend(B[0::2])
B2.extend(B[1::2])
C1.extend(C[0::2])
C2.extend(C[1::2])

code = []

for i in range(0,500):
    temp = ((A1[i],A2[i],B1[i],B2[i],C1[i],C2[i]))
    code.append(temp)

result = []
for co in code:
    if co == a:
        result.extend("a")
    elif co == b:
        result.extend("b")
    elif co == c:
        result.extend("c")
    elif co == d:
        result.extend("d")
    elif co == e:
        result.extend("e")
    elif co == f:
        result.extend("f")
    elif co == g:
        result.extend("g")
    elif co == h:
        result.extend("h")
    elif co == ii:
        result.extend("i")
    elif co == j:
        result.extend("j")
    elif co == k:
        result.extend("k")
    elif co == l:
        result.extend("l")
    elif co == m:
        result.extend("m")
    elif co == n:
        result.extend("n")
    elif co == o:
        result.extend("o")
    elif co == p:
        result.extend("p")
    elif co == q:
        result.extend("q")
    elif co == r:
        result.extend("r")
    elif co == s:
        result.extend("s")
    elif co == t:
        result.extend("t")
    elif co == u:
        result.extend("u")
    elif co == v:
        result.extend("v")
    elif co == w:
        result.extend("w")
    elif co == x:
        result.extend("x")
    elif co == y:
        result.extend("y")
    elif co == z:
        result.extend("z")
    elif co == space:
        result.extend(" ")
    elif co == period:
        result.extend(".")
    elif co == comma:
        result.extend(",")
    elif co == zero:
        result.extend("0")
    elif co == one:
        result.extend("1")
    elif co == two:
        result.extend("2")
    elif co == three:
        result.extend("3")
    elif co == four:
        result.extend("4")
    elif co == five:
        result.extend("5")
    elif co == six:
        result.extend("6")
    elif co == seven:
        result.extend("7")
    elif co == eight:
        result.extend("8")
    elif co == nine:
        result.extend("9")
    else:
        result.extend("?")

#print(len(result))
#print(result)

def convert(s): 
  
    # initialization of string to "" 
    str1 = "" 
  
    # using join function join the list s by  
    # separating words by str1 
    return(str1.join(s))

print(convert(result))
