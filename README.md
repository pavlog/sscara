# sscara
Small size 3d printer with SCARA based mechanics

Current Status: V3 - WIP

V3 Videos
https://youtu.be/qMoxgC5KaG4
https://youtu.be/IasEUXix5cc

History:
* 28.01.2016 - V3 - WIP
* 11.01.2016 - V2 - DONE (fail)
* 05.01.2016 - V2 - Final tests
* 28.07.2015 - V2 - WIP
* 27.07.2015 - V1 - DONE
* 27.04.2015 - V1 - WIP

Videos:
v3 - https://youtu.be/qMoxgC5KaG4
 

Precision:
WIP
XY: 0.03 mm with 32 microsteps at 150 mm radius from axes center. (chord length c=2*R*sin(alpha/2), alpha = 1.8/5/32 (stepper/gearratio/nummicrosteps);
Z: GT2 16 teeth pulley with 32 microsteps - 5 μm (http://reprap.org/wiki/Step_rates)
 
Other features:
* Noiseless

Hardware: 
* 4 Nema17 (24mm length shaft)
* Ramps 1.4
* 4 drv8825 (drv8825 is better due to 1/32 microstepping)
* External power supply 5A (without Heated bed)
* Heated bed ????? depends on (but seems like require in 4x time less current than MK2B - because of 4 times lower area)
* 3 small (20x11x7mm) end stoppers
Optional:
* HC-05 bluetooth module (i am happy with it, even firmware flashing done via bluetooth)

Marlin Firmware modifications:
* FIVE_BAR define added for SCARA define
* added M450 - xyz min limits
* added M451 - xyz max limits
* added M452 - xyz home pos
* added M370 X#Angle Y#Angle
* G2/G3 commands support
* Fixed math for pure SCARA (2 arms)

Materials:
* ~1.5 meters(2m max) - GT2 timing belt 6mm(width)
* 3 - GT2 16 teeth pulleys (ID=5mm)
* 4 - Nema17 (24mm shaft length) (39 mm Nema17 might be used for xy)
* 4 - 625 bearings (ID-5mm,OD-16mm,H-5mm)
* 2 - 608 bearings (ID-8mm,OD-22mm,H-7mm)
* 21 - 623 bearings (ID-3mm,OD-10mm,H-4mm)
* 1 - aluminium tube (ID-6mm,OD-8mm) - 350mm max
* 1 - m5 threaded rod - 500mm max
* 1 - m3 threaded rod - 2 meters max
* m3 bolts and nuts
* m5 nuts
* ABS filament to print parts


SCAD:
* use drawArray = [] to draw everything or drawArray=[1,2,3] for parts
* use printLayout to control parts/subparts layout (0 for design, 1 for export) (Some parts need to be rotated to 180 Y) (WIP)
* NemaSize - tweak nema len, NemaLengthMedium,NemaLengthShort,NemaLengthLong

Slicer:
* Slic3r
* ABS - 0.4mm nozzle, setup is described in scad file for each part

Included Software:
* Software/SScaraVisualizer.html (may not be up to date) or use (up to date) https://jsfiddle.net/PavloG/0vq1nf2v/
* Marlin firmware - use https://github.com/pavlog/Marlin (forked from https://github.com/MarlinFirmware/Marlin)

Reachability visualizer
* http://jsfiddle.net/PavloG/0vq1nf2v/

Calibration Guide:
Enable EEPROM in you firmware.

Initial rough calibration:
* G28 goto home
* Steps Per Units - M92 X## Y## where ## is a stepperUnitsPerRevolution*driverMicrostepping*gearboxration/360, (Nema17 1.8deg with drv8825 1/32), v1 = 200*32*5/360 = 88.888, v2 = 142.222

XY init calibration:

* G28 goto home
* M452 X#xx Y#yy - where #xx and #yy is a measured distance from nozzle to the axis center (xx should negative, +/-1 mm is enought)

NOTE: Put your min max software limits a little bit bigger (i used 3 cm)  (use M450 and M451), this is required for the next steps.

XY precise calibration:

Precise Steps Per Units calibration:
* G28 goto home
* M370 X0+#xx Y-90+#yy // move arms to 90 and 180 degrees, #xx and #yy is an extra angle to move arms exactly to 90 and 180 degrees
* M370 X90+#xx Y0+#yy // #xx and #yy from prev step
* if your arms not exacly 0 and 90 degrees use M92 X## Y## +/- values until all sequence above will get 0 and 90 degrees
* Repeat a few times until you get 90 and 180 degrees exactly
* M500 to save data to EEPROM


Precise home offsets calibration:
* G28 goto home
* M370 X0 Y-90 // move arms to 0 and -90 degrees
* M206 X## Y## (where X## Y## is a angular distance to 90 and 180, this is homing offsets in angles, can be used from prev steps)
* Repeat a few times until you get 90 and 180 degrees exactly
* M500 to save data to EEPROM


Z calibration
* G28 Z
* Ajust platform height

Development blog - https://3dgems.blogspot.com