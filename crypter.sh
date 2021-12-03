#!/bin/bash

#functions

function decdir()
	{
		echo "here are all the keys: "
        gpg -k
		echo "you should remeber the passphrase of the private key"
		echo "directory you want to dencrypt?"
        read DECDIR
		gpg -o decrypted_file_tar_archive -d "$DECDIR"
		tar -xvf decrypted_file_tar_archive
	}
		
		
function decfile () 
	{	
		echo "here are all the keys: "
        gpg -k
		echo  "directory of the file you want to decrypt"
		read DECFILE
		echo "you should remeber the passphrase of the private key"
		gpg --batch -d "$DECFILE"
	
	}
	
function encfile ()
    {

        	echo "here are all the keys: "
        	gpg -k
        	echo "enter the uid of the key u want to use "
        	read IDKEY
        	echo "directory of the file you want to encrypt"
        	read ENCFILE

        	gpg --batch -e -r "$IDKEY" "$ENCFILE"
        	cat "${ENCFILE}.gpg"

    }
    
    
 function encdir ()
	{
			echo "here are all the keys: "
            gpg -k
			echo "enter the uid of the key u want to use "
		    read IDKEYDIR
		    echo "directory you want to encrypt"
            read ENCDIR
			gpgtar -o enc_dir  -r "$IDKEYDIR" -e "$ENCDIR"


	}
 
 function genkey ()
	{
			gpg --generate-key
        	read -p "press any key"
        	clear       #keys generated
		
	}
 
echo "do you want to decrypt or encrypt? (d / e)"
read RESP2


if [ $RESP2 = "e" ];
then 

	echo "do u want to create the keys(y or n): "
	read RESP1

	if [ $RESP1 = "y" ];
	then
		
		genkey
        	
		echo "do you want to encrpyt a dir or a file?(dir / file): "
		read RESP3
		if [ $RESP3 = "file" ];
		then
			encfile 
		elif [ $RESP3 = "dir" ];
		then
		
			encdir
		fi

	elif [ $RESP1 = "n" ];
	then
        echo "do you want to encrpyt a dir or a file?(dir / file): "
		read RESP4
       	
		if [ $RESP4 = "file" ];
		then
			encfile
		elif [ $RESP4 = "dir" ];
		then
			encdir
		fi

	fi

elif [ $RESP2 = "d" ];
then
	echo "you should have the private key to decrypt the file"
	
	echo "if you dont have any key then you have to import the private key to decrypt"
	
	echo "do you want to decrypt a dir or a file?(dir / file): "
	read RESP5

	if [ $RESP5 = "file" ];
	then
		decfile
	elif [ $RESP5 = "dir" ];
	then
		decdir
	fi


else 
	echo "undefined"

fi
