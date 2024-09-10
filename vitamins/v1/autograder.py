import os
import shutil
import subprocess
import time

# Paste the autograder script in the main tester directory.
# create a directory named "results" in the main tester directory.

# Global variables
source_folder = r"../split/"
destination_folder = r"./test/"
NUM_OF_SUBMISSIONS = 2 #Number of codes submitted

# fetch all files
prev_nm = ''
i = 0
j = 0
num_of_codes = NUM_OF_SUBMISSIONS
students = []
tot_list = os.listdir(source_folder)
tot_list = sorted(tot_list)
for i in range(len(tot_list)):
    file_name = tot_list[i]
    des_name = file_name.split('_')[-1]
    source = source_folder + file_name
    destination = destination_folder + des_name
    # copy only files
    if os.path.isfile(source):
        shutil.copy(source, destination)
        print('copied', file_name)
    nm = file_name.split('_')[0]
    student = "./results/" + nm + ".txt"
    j = j+1
    if j == num_of_codes:
        pre =  subprocess.Popen(["stack-2.7.5 clean"], stdout=subprocess.PIPE,shell=True)
        time.sleep(5)
        p =  subprocess.Popen(["nohup stack-2.7.5 test > " + student], stdout=subprocess.PIPE,shell=True)
        time.sleep(10)
        j = 0
    i = i+num_of_codes
    
