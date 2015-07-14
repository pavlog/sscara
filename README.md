# sscara
Small size 3d printer with SCARA based mechanics

Current Status: WIP - first prints is on the way (please do not print anything - wait for status other than WIP)

Videos:
http://youtu.be/tXSMMPmcKVQ
 
Dimensions: 
* 140x210x300mm (Height configurable)

Mass:
* ~2.5 kg (looks like 3kg max)

Precision:
WIP
XY: 
Z: GT2 16 teeth pulley with 32 microsteps - 5 μm (http://reprap.org/wiki/Step_rates)
 
Others:
* Noiseless


Hardware: 
* 4 Nema17 (24mm length shaft)
* Ramps 1.4 (better with drv8825)
* External power supply 5A (without Heated bed, not final)
* Heated bed ????? depends on (but seems like require in 4x time less current than MK2B - because of 4 times lower area)
* 3(4 if you want z min) small (20x11x7mm) end stoppers
Optional:
* HC-05 bluetooth module (but i use and happy, even firmaware flashing done via bluetooth)

Firmware:
* Marlin (modified)
** FIVE_BAR define added for SCARA define
** added M450 - xyz min limits
** added M451 - xyz max limits
** added M452 - xyz home pos

Materials:
* ~1.5 meters(2m max) - GT2 timing belt 6mm(width)
* 3 - GT2 16 teeth pulleys
* 4 - Nema17 (24mm shaft length)
* 2 - 625 bearings (ID-5mm,OD-16mm,H-5mm)
* 2 - 608 bearings (ID-8mm,OD-22mm,H-7mm)
* 2 - 6800 bearings (ID-10mm,OD-19mm,H-5mm)
* 5 - 623 bearings (ID-3mm,OD-10mm,H-4mm)
* 1 - F5-12M thrust bearing - (ID-5mm,OD-12mm,H-4mm)
* 1 - aluminium tube (ID-6mm,OD-8mm) - 350mm max
* 1 - m5 threaded rod - 500mm max
* 1 - m3 threaded rod - 2 meters max
* m3 bolts and nuts
* m5 nuts
* ??? kg (need to be measured) - ABS fillaments to print parts


SCAD:
* use drawIndex variable to control parts visibility
* use printLayout to control parts/subparts layout (0 for design, 1 for export) (Some parts need to be rotated to 180 Y) (WIP)
* isExpolode - variable to control explode mode view (WIP)

Slicer:
* Slic3r
* ABS - 0.4mm nozzle, 25% infill, 0.25mm layer height

Included Software:
* SScaraVisualizer - c# application to preview/visualize dimensions and different parameters
* ReprapHeatedBedGenerator heated bed generator (forked from https://github.com/tlalexander/ReprapHeatedBedGenerator)
* Marlin - Marlin firmware(forked from https://github.com/MarlinFirmware/Marlin)

Calibration Guide:

Steps Per Unit calibration:
* G28 XY
* G1 X-50
* G1 X50
* Measure real distance and correct units (M92 X## Y##) until travel distance will become 100mm
* Do all steps again
* When calibrated - M500 to save data to EEPROM

XY calibration:

Arms initially shouble established in position exactly about home location or a little bit left and bottom from home position (home position should equals min xy).
Enable EEPROM in you firmware.
* M206 X0 Y0 - resets home offsets
* G28 goto home
* Measure distance from nozzle center to home position (MANUAL_X_HOME_POS,MANUAL_Y_HOME_POS) see Configuration.h
* M206 X#xx Y#yy - where #xx and #yy is a NEGATIVE distances from homed nozzle center and required home pos (MANUAL_X_HOME_POS,MANUAL_Y_HOME_POS). 
* G28 goto home
* G1 Z0 (to lift platform closer to nozzle)
* G1 X##MANUAL_X_HOME_POS Y##MANUAL_Y_HOME_POS - in this step nozzle center should be above home position (MANUAL_X_HOME_POS,MANUAL_Y_HOME_POS)
* M500 to save data to EEPROM

NOTE: use calibration plate from scad file (part #38 in stl folder)


Z calibration
WIP

TODO:
Ramps Fan mounts
Mount for walls for build areas
 

Development blog - https://3dgems.blogspot.com