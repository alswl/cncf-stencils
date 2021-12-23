import yaml
from shutil import copy2
import os

ROOT = '.'

def copy(category, sub_category, logo):
    os.makedirs(os.path.join(ROOT, 'build', 'final', category + " > " + sub_category), exist_ok=True)

    src = os.path.join(ROOT, 'build/cached_logos', logo)
    if not os.path.isfile(src):
        src = os.path.join(ROOT, 'build/hosted_logos', logo)
        if not os.path.isfile(src):
            print('Not exist ' + src)
            return
    dest = os.path.join(ROOT, 'build', 'final', category + " > " + sub_category, logo)

    copy2(src, dest)

def parse():
    raw = ''
    with open('vendor/landscape/landscape.yml', 'r') as f:
        raw = f.read()
    config = yaml.load(raw)


    for c in config['landscape']:
        c_name = c['name']
        print("processing " + c_name)
        for sub_c in c['subcategories']:
            sub_c_name = sub_c['name']
            for i in sub_c['items']:
                logo = i['logo']
                copy(c_name, sub_c_name, logo)


if __name__ == '__main__':
    parse()
