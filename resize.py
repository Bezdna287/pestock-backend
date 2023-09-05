import cv2
import numpy as np
import argparse
import matplotlib.pyplot as plt

def res(image):
    dim = None
    (h, w) = image.shape[:2]
    # desired width, for now, is half the original
    width = int(w/2)
    r = width / float(w)
    dim = (width, int(h * r))
    resized = cv2.resize(image, dim, interpolation = cv2.INTER_AREA)

    return resized

print("vamo er nota\n")

parser = argparse.ArgumentParser("simple_example")
parser.add_argument("dir", help="collection directory name", type=str)
parser.add_argument("fileNames", help="collection directory name", type=str)

args = parser.parse_args()

fileNames = args.fileNames.split(",")

filePath =["./images/"+args.dir + "/"+name for name in fileNames ]

imgs = [cv2.imread(path) for path in filePath ]

resized = [ res(img) for img in imgs]

filePath =["./images/"+args.dir + "/"+name for name in fileNames ]

# [cv2.imwrite(,img) for img in resized]


# c=plt.imshow(imgs[4])
# plt.show()

# d=plt.imshow(resized[4])
# plt.show()
