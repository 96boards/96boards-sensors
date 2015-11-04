PROJECT_NAME = Sensors
OUTPUT_EXTS = -B_Cu.gbl \
	      -B_Mask.gbs \
	      -B_Paste.gbp \
	      -F_Cu.gtl \
	      -F_Mask.gts \
	      -F_SilkS.gto \
	      -F_Paste.gtp \
	      -Edge_Cuts.gko \
	      .drl \
	      -all.pos

OUTPUTS = $(addprefix gerbers/$(PROJECT_NAME),$(OUTPUT_EXTS))
OUTPUTS += $(PROJECT_NAME)-ft230x.xml
OUTPUTS += $(PROJECT_NAME).csv
OUTPUTS += $(PROJECT_NAME)-bom-test.xlsx

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
