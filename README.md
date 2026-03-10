# GIMP_3.0.8_lens_distortion_batch_automation
Script to apply the GIMP 3.0.8 lens distortion filter to multiple files and save the modified files to a second folder. The current script is set to remove linear lens distortion from a GoPro Hero 12 from underwater images.
-----
# To tune your distortion values:
If you need to modify the script to match your camera's settings, open an image you'd like to fix, and using the top dropdown menu go to Filters > Distorts > Lens Distortion... Adjust the values to remove the image distortion and save those numbers. The example below are the values used in the default files in this repository:

<img width="398" height="397" alt="LensDistortionMenu" src="https://github.com/user-attachments/assets/e2b82f4d-f164-4df9-b160-899a13307769" />

# To load the script:
Download the batch-lens-distortion.scm and run_gimp_lens_distortion.sh files to your desktop.

In a terminal window run '''chmod +x ~/Desktop/run_gimp_lens_distortion.sh''' to give the script permissions to run.

Create a D_input folder and D_output folder on your desktop.

Place the GoPro image files in the D_input folder. The script will save the altered files to the D_output folder and leave the originals in the D_input folder.

From your terminal run '''~/Desktop/run_gimp_lens_distortion.sh'''

# Output example
You will get file processing updates that look like the following example, which processed two files:

'''
========================================
  GIMP 3.0 Batch Lens Distortion
========================================
  Input    : /Users/johnstarmer/Desktop/D_input
  Output   : /Users/johnstarmer/Desktop/D_output
  Barrel   : 0   Edge    : 53
  Zoom     : 48     Shift X : 0
  Shift Y  : 5  Brighten: 0
  Files    : 2 JPG(s) found
========================================

[1/2] Processing: GOPR3782.JPG
GIMP is started as MacOS application
GIMP was built with MacPorts
/Applications/GIMP.app/Contents/MacOS/gimp-console-3.0: LibGimpBase-WARNING: gimp: gimp_wire_read(): unexpected EOF
GIMP-Warning: Welcome to GIMP 3.0.8!

batch command executed successfully
  Saved -> /Users/johnstarmer/Desktop/D_output/GOPR3782.JPG
[2/2] Processing: GOPR4000.JPG
GIMP is started as MacOS application
GIMP was built with MacPorts
/Applications/GIMP.app/Contents/MacOS/gimp-console-3.0: LibGimpBase-WARNING: gimp: gimp_wire_read(): unexpected EOF
GIMP-Warning: Welcome to GIMP 3.0.8!

batch command executed successfully
  Saved -> /Users/johnstarmer/Desktop/D_output/GOPR4000.JPG

========================================
  Done. 2 file(s) processed.
  Output folder: /Users/johnstarmer/Desktop/D_output
========================================
'''

