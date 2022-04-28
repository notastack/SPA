#!/bin/bash
echo Welcome to the SPA.
#check if user is new or not
if [ -d .spa ]
then
	echo Thank you for your continuing patronage.
else
	mkdir .spa
	sudo apt install apg > /dev/null ; sudo apt install openssl > /dev/null
	echo Thank you for choosing the SPA.
fi
#check if password already exist
if [ -r ./.spa/$1.enc ];
then
#if yes then read password
	openssl rsautl -decrypt -in ./.spa/$1.enc -out ./.spa/$1 -inkey ./.spa/private-key.pem
	echo Your current password password for $1 is : ; cat ./.spa/$1
	rm ./.spa/$1
else
#if no then create then read password
	apg -M SNCL -m 10 -n 1 > ./.spa/$1
	echo Your new password for $1 is : ; cat ./.spa/$1
	openssl rsautl -encrypt -in ./.spa/$1 -out ./.spa/$1.enc -inkey ./.spa/public-key.pem -pubin || ( echo no key found, genrerating new ones. ;  openssl genrsa -out ./.spa/private-key.pem 2048 ; openssl rsa -pubout -in ./.spa/private-key.pem -out ./.spa/public-key.pem ; openssl rsautl -encrypt -in ./.spa/$1 -out ./.spa/$1.enc -inkey ./.spa/public-key.pem -pubin )
	rm ./.spa/$1
fi
