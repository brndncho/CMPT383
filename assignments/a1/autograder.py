import os
import shutil
import subprocess
import time
import zipfile

def dictOfAssocList(assocList):
    res = {}
    for (k,v) in assocList:
        res[k] = res.get(k,[]) + [v]
    return res

#sed -i '.bak' 1,42d dump.sql

# Paste the autograder script in the main tester directory.
# create a directory named "results" in the main tester directory.

# Global variables
source_folder = r"./subs/"
destination_folder = r"./test/"

# fetch all files
students = []
tot_list = sorted(os.listdir(source_folder))
zip_des = []
if '.DS_Store' in tot_list:
    os.remove(source_folder+'.DS_Store')

for name in tot_list:
    if name.endswith('.zip'):
        new_list = []
        print ('The file: ', name, ' has the extension: .zip ')
        std_name = name.split('_')[0]
        src_path = source_folder+name
        zip_des = zip_des + [src_path]
        with zipfile.ZipFile(src_path,"r") as zip_ref:
            all_items = zip_ref.namelist()
            new_list = [item for item in all_items if not item.startswith('__MACOSX/')]
            new_list_bk = new_list
            if 'src/' in new_list:
                l2 = [item for item in new_list if item.startswith('src/')]
                l3 = [item for item in l2 if not item == 'src/']
                new_list = []
                for each in l3:
                    fl = each.split('/')[-1]
                    new_list.append(fl)
            for target_file in new_list:
                target_name = std_name + "_" + target_file
                target_path = os.path.join(source_folder, target_name)
                with open(target_path, "wb") as f: 
                    if 'src/' in new_list_bk:
                        f.write(zip_ref.read('src/'+target_file))
                    else:
                        f.write(zip_ref.read(target_file))
                    
# Remove all the zip files from the directory
for zip_remove in zip_des:
        os.remove(zip_remove)

# Reading the directory again for final list after unzipping the folder
tot_list = sorted(os.listdir(source_folder))


keyed_list = map(lambda fname : (fname.split('_')[0],fname),tot_list)
userDict = dictOfAssocList(keyed_list)
for (userName,fileNames) in userDict.items():
    destinations = []
    for file_name in fileNames:
        des_name = file_name.split('_')[-1]
        if "-" in des_name:
            des_name = des_name.split('-')[0] + '.hs'
        source = source_folder + file_name
        destination = destination_folder + des_name
        destinations = destinations + [destination]
        if os.path.isfile(source):
            shutil.copy(source, destination)
    student = "./results/" + userName + ".txt"
    pre =  subprocess.Popen(["stack-2.7.5 clean"], stdout=subprocess.PIPE,shell=True)
    time.sleep(5)
    p =  subprocess.Popen(["nohup stack-2.7.5 test > " + student], stdout=subprocess.PIPE,shell=True)
    time.sleep(10)
    for destination in destinations:
        os.remove(destination)
