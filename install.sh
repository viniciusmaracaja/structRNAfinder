#!/bin/bash

NORMAL="\\033[0;39m"
RED="\\033[0;31m"
BLUE="\\033[0;34m"
TEST=$HOME

die() {
    echo "$RED""Exit - ""$*""$NORMAL" 1>&2
    exit 1
}

echo "$RED""Make sure your internet connection works for your shell prompt under current user's privilege ...""$NORMAL";
echo "$BLUE""Starting structRNAfinder installation ...""$NORMAL";

#check for make
which make > /dev/null;
if [ $? != "0" ]; then
	echo "$RED""Can not proceed without make, please install and re-run ""$NORMAL"
	exit 1;
fi

#check for g++
which g++ > /dev/null;
if [ $? != "0" ]; then
	echo "$RED""Can not proceed without g++, please install and re-run""$NORMAL"
	exit 1;
fi

# perl
which perl > /dev/null;
if [ $? != "0" ]; then
    echo "$RED""Can not proceed without Perl, please install and re-run""$NORMAL"
    exit 1;
fi

# check for gzip 
which gzip > /dev/null;
if [ $? != "0" ]; then
    echo "$RED""Can not proceed without gzip, please install and re-run""$NORMAL"
    exit 1;
fi

#check OS (Unix/Linux or Mac)
os=`uname`;

# get the right download program
if [ "$os" = "Darwin" ]; then
	# use curl as the download program 
	get="curl -L -o"
else
	# use wget as the download program
	get="wget --no-check-certificate -nc -O"
fi

if [ -d ./tmp_structRNAfinder ]; then
    rm -rf ./tmp_structRNAfinder
fi
mkdir ./tmp_structRNAfinder
cd ./tmp_structRNAfinder

################ Install dependencies  ###################

PREFIX_BIN=/usr/local/bin
PREFIX_SHARE=/usr/local/share

if [ ! -w $PREFIX_BIN ]; then
    die "Cannot write to directory $PREFIX_BIN. Maybe missing super-user (root) permissions to write there.";
fi 

if [ ! -w $PREFIX_SHARE ]; then
    die "Cannot write to directory $PREFIX_SHARE. Maybe missing super-user (root) permissions to write there.";
fi 

##export PATH=$PREFIX_BIN:$PREFIX_BIN/convert/bin:$PATH

############### Install scritps ########################

cp -rf ../share/structRNAfinder $PREFIX_SHARE
cp ../bin/* $PREFIX_BIN
chmod 777 $PREFIX_BIN/structRNAfinder
chmod 777 $PREFIX_BIN/SRF_*
chmod -R 777 $PREFIX_SHARE/structRNAfinder

#some structRNAfinder tests
which structRNAfinder > /dev/null;
if [ $? = "0" ]; then
	echo "$BLUE""structRNAfinder appears to be installed successfully""$NORMAL"
else
	echo "$RED""structRNAfinder NOT installed successfully""$NORMAL"; exit 1;
fi


################ Vienna ###################

wasInstalled=0;
which RNAfold > /dev/null;
if [ $? = "0" ]; then
	echo -n "$BLUE""Vienna appears to be already installed. ""$NORMAL"
	wasInstalled=1;
fi

echo -n "Would you like to install/re-install Vienna? (y/n) [n] : "
read ans
if [ XX${ans} = XXy ]; then
    $get ViennaRNA-2.1.8.tar.gz http://www.tbi.univie.ac.at/RNA/packages/source/ViennaRNA-2.1.8.tar.gz
    tar xvzf ViennaRNA-2.1.8.tar.gz
    cd ViennaRNA-2.1.8
    ./configure
    make
    make install
    wasInstalled=0;
fi

#some Vienna tests
if [ $wasInstalled = 0 ]; then
    which RNAfold > /dev/null;
    if [ $? = "0" ]; then
	echo "$BLUE""Vienna appears to be installed successfully""$NORMAL"
    else
	echo "$RED""Vienna NOT installed successfully""$NORMAL"; exit 1;
    fi
fi

################ Infernal ###################

wasInstalled=0;
which cmsearch > /dev/null;
if [ $? = "0" ]; then
	echo -n "$BLUE""Infernal appears to be already installed. ""$NORMAL"
	wasInstalled=1;
fi

echo -n "Would you like to install/re-install Infernal? (y/n) [n] : "
read ans
if [ XX${ans} = XXy ]; then
	$get infernal-1.1.tar.gz http://selab.janelia.org/software/infernal/infernal-1.1-linux-intel-gcc.tar.gz
	tar xvzf infernal-1.1.tar.gz
	cp infernal-1.1-linux-intel-gcc/binaries/* $PREFIX_BIN
	wasInstalled=0;
fi

#some Infernal tests
if [ $wasInstalled = 0 ]; then
    which cmsearch > /dev/null;
    if [ $? = "0" ]; then
	echo "$BLUE""Infernal appears to be installed successfully""$NORMAL"
    else
	echo "$RED""Infernal NOT installed successfully""$NORMAL"; exit 1;
    fi
fi

################ Rfam ###################

echo -n "Would you like to download/re-download Rfam.cm? (y/n) [y] : "
read ans
if [ XX${ans} != XXn ]; then
	echo "Where should Rfam.cm be downloaded ? [$TEST]\nWrite new directory or press Enter to continue... "
	read answ
	answ=${answ:-$TEST}
	TEST=$answ
	if [ ! -d $TEST ]; then
		echo "Directory $TEST does not exist!"
    		echo -n "Do you want to create $TEST folder ? (y/n) [n] : "
    		read ans
    		if [ XX${ans} = XXy ]; then
        		mkdir $TEST || die "Cannot create  $TEST folder. Maybe missing super-user (root) permissions"
    		else
        		die "Must specify a directory to download Rfam.cm!"
    		fi
	fi
	if [ ! -w $TEST ]; then
    		die "Cannot write to directory $TEST. Maybe missing super-user (root) permissions to write there.";
	fi 
	$get Rfam.cm.gz ftp://ftp.ebi.ac.uk/pub/databases/Rfam/12.0/Rfam.cm.gz
	gzip -d Rfam.cm.gz
	cmpress -F Rfam.cm
	cp Rfam.cm* $TEST
	
	echo "$BLUE""Rfam.cm appears to be downloaded successfully""$NORMAL"	
fi

################# Install Graphics for perl image###########

echo "\nWould you like to install/re-install Bio::Graphics? "
echo "$RED""It is important to generate images by perl, do not install only if you are installed yet""$NORMAL"
echo -n "Command to be used:\napt-get install libgd-perl\ncpan install Bio::Graphics\nIf you have another way to install it, please answer \"n\" (y/n) [y] : "
read ans
if [ XX${ans} != XXn ]; then
	echo "$BLUE""Installing Bio::Graphics to perl""$NORMAL"
	apt-get install libgd-perl
	cpan install Bio::Graphics
	echo "$BLUE""\nBio::Graphics appears to be installed successfully""$NORMAL"
fi


################ End of the installation ###################
# clean up
cd ..
rm -rf tmp_structRNAfinder

echo;
echo "$RED""All done !""$NORMAL"
