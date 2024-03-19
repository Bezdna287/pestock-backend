import cv2
import argparse

def res(image):
    dim = None
    (h, w) = image.shape[:2]
    # desired width, for now, is hardcoded right below
    if w >= 500:
        width = int(w/8)
        r = width / float(w)
        dim = (width, int(h * r))
        resized = cv2.resize(image, dim, interpolation = cv2.INTER_AREA)
    else:
        resized = image

    return resized

parser = argparse.ArgumentParser("simple_example")
parser.add_argument("dir", help="collection directory name", type=str)
parser.add_argument("fileNames", help="collection directory name", type=str)

args = parser.parse_args()

print("Resizing /"+args.dir+"\n")

prefix = "./images/"+args.dir + "/"

fileNames = args.fileNames.split(",")

numFiles = len(fileNames)

for i,name in enumerate(fileNames):
    name=name.strip()
    [inputPath, outputPath]=(prefix+name,prefix+"resized/"+name)
    img = cv2.imread(inputPath)

    if(img is not None):
        resized = res(img)
        status=str(cv2.imwrite(outputPath,resized))
        print(status+"\t"+outputPath+"\n")