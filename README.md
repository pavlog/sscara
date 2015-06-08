# sscara
Small size 3d printer with SCARA based mechanics

Dimensions: 
* 120x180x250mm (Height configurable)

Hardware: 
* 4 Nema17 (24mm length shaft)
* Ramps 1.4
* External power supply 5A (without Heated bed)
* Heated bed ????? depends on (but seems like require in 4x time less current than MK2B - because size 4 times less)

Mass:
* 2kg (because of steppers) - still not measured

Software:
* Marlin (seems like potentially without modifications (maybe homing will be changed))

Materials:
* ??? meters(need to be measured) - GT2 timing belt 6mm
* 3 - GT2 16 teeth pulleys
* 4 - Nema17 (24mm shaft length)
* 2 - 625 bearings (ID-5mm,OD-16mm,H-7mm)
* 2 - 608 bearings (ID-8mm,OD-16mm,H-7mm)
* 1 - aluminium tube (ID-6mm,OD-8mm) - Length still not determined
* 1 - m5 threaded rod - Length still not determined
* m3 bolts and nuts - a few/lot of them (will be calculated later on project finish)
* m5 nuts - a few/lot of them (will be calculated later on project finish)
* ??? kg (need to be measured) - ABS fillaments to print parts


SCAD:
* use #drawIndex variable to control parts visibility

Slicer:
* Slic3r
* ABS - 0.4mm nozzle, 25% infill, 0.25mm layer height

Included Software:
* SScaraVisualizer - c# application to preview and  visualize dimensions and different parameters

Development blog - https://3dgems.blogspot.com