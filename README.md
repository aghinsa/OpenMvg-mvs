# OpenMvg-Mvs  

* Clone and run from parent
* Building the container  
  > sudo docker build -t 'image_name:tag' .  

* Running  
 > sudo docker run -it --rm -v full_parent_path:full_container_path --name container_name image_name:tag  

* put images in parent/images
* cd to container_path run python3 pipeline.py
* change permission of file
  > sudo chmod 777 *
