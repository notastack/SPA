#!/bin/bash
if [ -r ./.spa/$1.enc ];
then
	openssl rsautl -decrypt -in ./.spa/$1.enc -out ./.spa/$1 -inkey ./.spa/private-key.pem
  cat ./.spa/$1
	rm ./.spa/$1
else
	apg -M SNCL -m 10 -n 1 > ./.spa/$1
  cat ./.spa/$1
	openssl rsautl -encrypt -in ./.spa/$1 -out ./.spa/$1.enc -inkey ./.spa/public-key.pem -pubin
	rm ./.spa/$1
fi
