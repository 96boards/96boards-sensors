all: Sensors.zip Sensors-seeed.csv

Sensors.csv: Sensors.xml
Sensors-seeed.csv: Sensors.csv

%-Edge_Cuts.gko: %-Edge_Cuts.gm1
	cp $< $@

%.zip: %-B_Cu.gbl %-B_Mask.gbs %-B_SilkS.gbo %-B_Paste.gbp %-F_Cu.gtl %-F_Mask.gts %-F_SilkS.gto %-F_Paste.gtp %-Edge_Cuts.gko %.drl %-NPTH.drl %-all.pos %-ft230x.xml %.csv %-bom-test.xlsx
	zip $@ $^

%.csv: %.xml
	xsltproc -o $@ ./bom2csv.xsl $<

%-seeed.csv: %.csv
	awk 'BEGIN { FS=","; OFS=","; } { print $$8,$$2,$$1; }' $< > $@

# This rule will only work with v1.2 of ftdi_eeprom or higher
flash:
	ftdi_eeprom --flash-eeprom ftdi_eeprom/ftdi_eeprom.conf
