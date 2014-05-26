VSN = 1.0
IMG_BUILD = stoo/erldns_build:$(VSN)
IMG = stoo/erldns:$(VSN)

PREFIX = erldns

.PHONY: all build image clean

define sshidpub
echo "Looking for RSA key" \
    && test -f ~/.ssh/id_rsa.pub \
    && cp -p ~/.ssh/id_rsa.pub image/sshid.pub \
    || ( echo "RSA key not found, trying DSA" \
         && cp -p ~/.ssh/id_dsa.pub image/sshid.pub )
endef


all: image

build: image/$(PREFIX).tar.gz

image/$(PREFIX).tar.gz:
	docker build -t "$(IMG_BUILD)" build
	docker run -i --rm "$(IMG_BUILD)" \
	    tar zcf - -C /devdock/work opt/$(PREFIX) >$(PREFIX).tar.gz.tmp
	mv $(PREFIX).tar.gz.tmp image/$(PREFIX).tar.gz

image: image/$(PREFIX).tar.gz
	$(sshidpub)
	docker build -t "$(IMG)" image
	rm -f image/sshid.pub

clean:
	rm -f image/$(PREFIX).tar.gz
