# GIMP_3.0.8_lens_distortion_batch_automation
Script to apply the GIMP 3.0.8 lens distortion filter to multiple files and save the modified files to a second folder. The current script is set to remove linear lens distortion from a GoPro Hero 12 from underwater images.
-----
# To tune your distortion values:
If you need to modify the script to match your camera's settings, open an image you'd like to fix, and using the top dropdown menu go to Filters > Distorts > Lens Distortion... Adjust the values to remove the image distortion and save those numbers. The example below are the values used in the default files in this repository:
<img width="398" height="397" alt="LensDistortionMenu" src="https://github.com/user-attachments/assets/e2b82f4d-f164-4df9-b160-899a13307769" />


# To load the script:
Download the 




The script will save the altered files to the D_output folder (in this example) and leave the originals in the D_input folder.
