# sscara
Small size 3d printer with SCARA based mechanics

Current Status: V2 - WIP (a lot of improvements on the way)

V2 Improvements:
* x8 gear ratio
* Belt path shortened twice
* No belt coupliers
* No teeth on big pulleys (more precision, easy to print)
* Smaller dimensions (but with the same print area)
* A lot of improvements - more modular and service friendly
* Z axis improved a lot

History:
* 05.01.2016 - V2 - Final tests
* 28.07.2015 - V2 - WIP
* 27.07.2015 - V1 - DONE
* 27.04.2015 - V1 - WIP

Videos:
v1 - https://youtu.be/Ef477o_Nw88
 
Dimensions: 
* Base footprint - 165x140mm, height - 330mm

Printing Area:
* 100x120x120mm

Mass:
* ~2.5 kg (looks like 3kg max)

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

Calibration Guide:
Enable EEPROM in you firmware.

Initial rough calibration:
* G28 goto home
* Homing position - M370 X#xx Y#yy - where #xx and #yy is an angles (##yy should be more 180+, +/- a few angles is enought)
* Steps Per Units - M92 X## Y## where ## is a stepperUnitsPerRevolution*driverMicrostepping*gearboxration/360, (Nema17 1.8deg with drv8825 1/32), v1 = 200*32*5/360 = 88.888, v2 = 142.222

Steps Per Unit calibration (WIP WIP WIP not checked):
* G28 XY
* G1 X-50 Y50
* G1 X50 Y50
* Tweak (M92 X## Y##) until travel path become straigh line (parrallel to X axis), repeat a few times (sometime using other ten Y50 values)
* M500 to save data to EEPROM

XY init calibration:

* G28 goto home
* M452 X#xx Y#yy - where #xx and #yy is a measured distance from nozzle to the center (xx should negative, +/-1 mm is enought)

XY precise calibration:

* G28 goto home
* M370 X90 Y180 // move arms to 90 and 180 degrees
* M206 X## Y## (where X## Y## is a angular distance to 90 and 180)
* Repeat a few times until you get 90 and 180 degrees exactly
* M500 to save data to EEPROM
NOTE: Steps per unit must me calibrated already
NOTE2: Home position calculation will use M206 offset angles to calculate real home pos

Z calibration
* G28 Z
* G1 Z0
* M451 Z#zz+#ZZ where #zz is a distance beween nozzle and platform and #ZZ curent max distance
* M452 Z#zz+#ZZ where #zz is a distance beween nozzle and platform and #ZZ curent max distance

Development blog - https://3dgems.blogspot.com