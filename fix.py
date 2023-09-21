import os
from os.path import isfile, join

dumPath = [f for f in os.listdir('currentDump') if isfile(join('currentDump', f))]

print(dumPath)

with open(join('currentDump',dumPath[0]), 'r+') as file:
    content = file.read().replace('CREATE ROLE postgres;', '--CREATE ROLE postgres;')
    print(content)
    file.seek(0)
    file.truncate()
    file.write(content)
