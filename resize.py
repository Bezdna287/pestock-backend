import cv2
import argparse

def res(image):
    dim = None
    (h, w) = image.shape[:2]
    # desired width, for now, is hardcoded right below
    width = int(w/4)
    r = width / float(w)
    dim = (width, int(h * r))
    resized = cv2.resize(image, dim, interpolation = cv2.INTER_AREA)

    return resized


parser = argparse.ArgumentParser("simple_example")
parser.add_argument("dir", help="collection directory name", type=str)
parser.add_argument("fileNames", help="collection directory name", type=str)

args = parser.parse_args()

print("Resizing /"+args.dir+"\n")

fileNames = args.fileNames.split(",")

filePath =["./images/"+args.dir + "/"+name for name in fileNames ]

imgs = [cv2.imread(path) for path in filePath ]

resized = [ res(img) for img in imgs]

outputPath =["./images/"+args.dir + "/resized/"+name for name in fileNames ]

# print(outputPath[4])

# cv2.imwrite(outputPath[4],resized[4])

[cv2.imwrite(outputPath[index],img) for index, img in enumerate(resized)]


# c=plt.imshow(imgs[4])
# plt.show()

# d=plt.imshow(resized[4])
# plt.show()
