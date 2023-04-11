import os, os.path
import shutil, sys

base_dir = os.path.join(os.path.dirname(__file__))
os.chdir(base_dir)
# print(os.getcwd())

if not os.path.isdir("build"):
    os.mkdir("build")
elif not "--rebuild" in sys.argv:
    raise FileExistsError("Cannot create new build: ")
    exit(-1)
else:
    print("Deleting and recreating build directory\n")
    if os.path.isdir("build"): shutil.rmtree("build")
    os.mkdir("build")
    

def copyDir(d):
    # print(d)
    for f in os.listdir(d):
        src = os.path.join(d, f)
        target = os.path.join("build", os.sep.join(d.split(os.sep)[1:]) if len(d.split(os.sep)) > 1 else "", f)
        print(f"{src} -> {target}")
        if os.path.isdir(os.path.join(base_dir, src)):
            os.mkdir(target)
            # print(target)
            copyDir(src)
        else:
            shutil.copy2(src, target)
copyDir("src")
