# sscara
Small size 3d printer with SCARA based mechanics

Current Status: WIP (please do not print anything until i get first prints on #sscara)

Dimensions: 
* 120x180x250mm (Height configurable)

Hardware: 
* 4 Nema17 (24mm length shaft)
* Ramps 1.4 (better with drv8825)
* External power supply 5A (without Heated bed, not final)
* Heated bed ????? depends on (but seems like require in 4x time less current than MK2B - because of 4 times lower area)

Mass:
* 2kg (because of steppers) - still not measured

Software:
* Marlin (seems like potentially without modifications (maybe homing will be changed))

Materials:
* ??? meters(need to be measured) - GT2 timing belt 6mm
* 3 - GT2 16 teeth pulleys
* 4 - Nema17 (24mm shaft length)
* 2 - 625 bearings (ID-5mm,OD-16mm,H-5mm)
* 2 - 608 bearings (ID-8mm,OD-22mm,H-7mm)
* 1 - aluminium tube (ID-6mm,OD-8mm) - Length still not determined
* 1 - m5 threaded rod - Length still not determined
* m3 bolts and nuts - a few/lot of them (will be calculated later on project finish)
* m5 nuts - a few/lot of them (will be calculated later on project finish)
* ??? kg (need to be measured) - ABS fillaments to print parts


SCAD:
* use drawIndex variable to control parts visibility
* use printLayout to control parts/subparts layout (0 for design, 1 for export)
* isExpolode - variable to control explode mode view (WIP)

Slicer:
* Slic3r
* ABS - 0.4mm nozzle, 25% infill, 0.25mm layer height

Included Software:
* SScaraVisualizer - c# application to preview and  visualize dimensions and different parameters
* ReprapHeatedBedGenerator heated bed generator (forked from https://github.com/tlalexander/ReprapHeatedBedGenerator)

Development blog - https://3dgems.blogspot.com