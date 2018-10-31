import os
home=os.path.expanduser('~')
main_dir=os.path.join(home,'temp_vi')
image_dir = os.path.join(main_dir,'images')
#camera_dir = '/home/aghinsa/building/openMVG/src/openMVG/exif/sensor_width_database/sensor_width_camera_database.txt'
camera_dir=os.path.join(main_dir,'sensor_width_camera_database.txt')
matches_dir = os.path.join(main_dir,'matches')
output_dir = os.path.join(main_dir,'output')

#obj
obj=True
#manual
manual=False
width=2400
