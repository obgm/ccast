FILE=draft-ietf-roll-ccast
OPEN=$(word 1, $(wildcard /usr/bin/xdg-open /usr/bin/open /bin/echo))

all: txt html viewhtml

txt: $(FILE).txt

html: $(FILE).html

viewhtml: $(FILE).html
	$(OPEN) $<

pdf: $(FILE).pdf

%.xml: %.md
	kramdown-rfc2629 $< > $@

%.txt: %.xml
	xml2rfc $< --text

%.html: %.xml
	xml2rfc $< --html

%.ps: %.txt
	./fixff $<  | enscript --margins 76::76: -B -q -p $@

%.pdf: %.ps
	ps2pdf $< $@
