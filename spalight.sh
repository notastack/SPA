#!/bin/bash
if [ -d .spa ]
then
	sleep 1
else
	mkdir .spa
	sudo apt install apg > /dev/null ; sudo apt install openssl > /dev/null
	alias spal='/home/workpad/spa/SPA/spalight.sh'
fi
if [ -r ./.spa/$1.enc ];
then
	openssl rsautl -decrypt -in ./.spa/$1.enc -out ./.spa/$1 -inkey ./.spa/private-key.pem
  cat ./.spa/$1
	rm ./.spa/$1
else
	apg -M SNCL -m 10 -n 1 > ./.spa/$1
  cat ./.spa/$1
	openssl rsautl -encrypt -in ./.spa/$1 -out ./.spa/$1.enc -inkey ./.spa/public-key.pem -pubin || ( echo no key found, genrerating new ones. ;  openssl genrsa -out ./.spa/private-key.pem 2048 ; openssl rsa -pubout -in ./.spa/private-key.pem -out ./.spa/public-key.pem ; openssl rsautl -encrypt -in ./.spa/$1 -out ./.spa/$1.enc -inkey ./.spa/public-key.pem -pubin )
	rm ./.spa/$1
fi
