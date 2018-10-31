import subprocess
import os
import config
import time

manual=config.manual
width=config.width
image_dir = config.image_dir
camera_dir= config.camera_dir
matches_dir = config.matches_dir
output_dir = config.output_dir


print('Starting Reconstruction...')
tic = time.clock()
#starting OpenMVG
#max_h_w=4000
if(manual):
    command = "openMVG_main_SfMInit_ImageListing -i '{}' -d '{}' -o '{}' -f '{}' ".format(image_dir,
                        camera_dir,matches_dir,(1.2*width))
else:
    command = "openMVG_main_SfMInit_ImageListing -i '{}' -d '{}' -o '{}' ".format(image_dir,camera_dir,matches_dir)
process = subprocess.call(command, shell=True)

command = "openMVG_main_ComputeFeatures -i '{}' -o '{}'".format(matches_dir + '/sfm_data.json',matches_dir)
process = subprocess.call(command, shell=True)

command = "openMVG_main_ComputeMatches -i '{}' -o '{}'".format(matches_dir + '/sfm_data.json',matches_dir)
process = subprocess.call(command, shell=True)

command = "openMVG_main_IncrementalSfM -i '{}' -m '{}' -o '{}'".format(matches_dir + '/sfm_data.json',matches_dir,output_dir)
process = subprocess.call(command, shell=True)

command = "openMVG_main_openMVG2openMVS -i '{}' -o 'scene.mvs'".format(output_dir + '/sfm_data.bin')
process = subprocess.call(command, shell=True)

print('Starting OpenMVS...')
#starting OpenMVS

#os.chdir(output_dir)
command = "DensifyPointCloud scene.mvs"
process = subprocess.call(command, shell=True)

command = "ReconstructMesh scene_dense.mvs"
process = subprocess.call(command, shell=True)

if(config.obj):
    command = "TextureMesh scene_dense_mesh.mvs --export-type obj"
else:
    command = "TextureMesh scene_dense_mesh.mvs"
process = subprocess.call(command, shell=True)

toc = time.clock()
print('Completed in {} minutes'.format( (toc - tic)/60 ))
