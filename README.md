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
 
Other features:
* Noiseless

Hardware: 
* 4 Nema17 (24mm length shaft)
* Ramps 1.4 (better with drv8825 due to 1/32 microstepping)
* External power supply 5A (without Heated bed, not final)
* Heated bed ????? depends on (but seems like require in 4x time less current than MK2B - because of 4 times lower area)
* 3 small (20x11x7mm) end stoppers
Optional:
* HC-05 bluetooth module (i am happy with it, even firmware flashing done via bluetooth)

Firmware:
* Marlin (modified)
** FIVE_BAR define added for SCARA define
** added M450 - xyz min limits
** added M451 - xyz max limits
** added M452 - xyz home pos

Materials:
* ~1.5 meters(2m max) - GT2 timing belt 6mm(width)
* 3 - GT2 16 teeth pulleys (ID=5mm)
* 4 - Nema17 (24mm shaft length)
* 6 - 625 bearings (ID-5mm,OD-16mm,H-5mm)
* 2 - 608 bearings (ID-8mm,OD-22mm,H-7mm)
* 11 - 623 bearings (ID-3mm,OD-10mm,H-4mm)
* 1 - F5-12M thrust bearing - (ID-5mm,OD-12mm,H-4mm)
* 1 - aluminium tube (ID-6mm,OD-8mm) - 350mm max
* 1 - m5 threaded rod - 500mm max
* 1 - m3 threaded rod - 2 meters max
* m3 bolts and nuts
* m5 nuts
* ABS filament to print parts


SCAD:
* use drawArray = [] to draw everything or drawArray=[1,2,3] for parts
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
Enable EEPROM in you firmware.

XY calibration:

* G28 goto home
* Measure distance from nozzle to center (i.e. axis center)
* M450 X#xx Y#yy - where #xx and #yy is a measured distance from nozzle to the center (xx should negative)
* M452 X#xx Y#yy - where #xx and #yy is a measured distance from nozzle to the center (xx should negative)
* G28 goto home
* M500 to save data to EEPROM

NOTE: it is possible to use use calibration plate from scad file (part #38 in stl folder)

Steps Per Unit calibration:
Theory: stepperUnitsPerRevolution*driverMicrostepping*gearboxration/360, sscara (with drv8825 1/32) = 200*32*5/360 = 88.888
* G28 XY
* G1 X-50
* G1 X50
* Measure real distance and correct units (M92 X## Y##) until travel distance will become 100mm
* M500 to save data to EEPROM

Z calibration
* G28 Z
* G1 Z0
* M451 Z#zz+#ZZ where #zz is a distance beween nozzle and platform and #ZZ curent max distance
* M452 Z#zz+#ZZ where #zz is a distance beween nozzle and platform and #ZZ curent max distance


TODO:
Ramps Fan mounts
Mount for walls for build areas
 

Development blog - https://3dgems.blogspot.com