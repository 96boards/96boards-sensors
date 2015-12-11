PROJECT_NAME = Sensors
OUTPUT_EXTS = -B.Cu.gbl \
	      -B.Mask.gbs \
	      -B.Paste.gbp \
	      -F.Cu.gtl \
	      -F.Mask.gts \
	      -F.SilkS.gto \
	      -F.Paste.gtp \
	      -Edge.Cuts.gm1 \
	      .drl \
	      -all.pos

OUTPUTS = $(addprefix gerbers/$(PROJECT_NAME),$(OUTPUT_EXTS))
OUTPUTS += $(PROJECT_NAME)-ft230x.xml
OUTPUTS += $(PROJECT_NAME).csv
OUTPUTS += $(PROJECT_NAME)-bom-test.xlsx
OUTPUTS += $(PROJECT_NAME).pdf
OUTPUTS += $(PROJECT_NAME)-layout.pdf

all: Sensors.zip Sensors-seeed.csv

Sensors.csv: Sensors.xml
Sensors-seeed.csv: Sensors.csv

%-Edge_Cuts.gko: %-Edge_Cuts.gm1
	cp $< $@

Sensors.zip: Makefile
%.zip: $(OUTPUTS)
	test ! -e $@ || rm $@
	zip $@ $(OUTPUTS)

%.csv: %.xml
	xsltproc -o $@ ./bom2csv.xsl $<

%-seeed.csv: %.csv
	awk 'BEGIN { FS=","; OFS=","; } { print $$8,$$2,$$1; }' $< > $@

# This rule will only work with v1.2 of ftdi_eeprom or higher
flash:
	ftdi_eeprom --flash-eeprom ftdi_eeprom/ftdi_eeprom.conf
