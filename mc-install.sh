#!/bin/bash

echo "Thanks for using this mcinstall script!"

sudo apt update

read -p "Folder name: " folderName

if [ -e $folderName ]
then
  echo "Folder already exists"
else
  mkdir $folderName

  sudo apt-get install openjdk-17-jre

  cd $folderName

  wget https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar

  touch run.txt

  echo "java -Xmx1024M -Xms1024M -jar server.jar nogui" > run.txt

  mv run.txt run.sh

  touch eula.txt

  chmod +x run.sh

  read -p "Do you agree to the eula [true or false]: " eulaAgreement

  case $eulaAgreement in

    true )
      sed -i 's/false/true/g' eula.txt

      echo "eula=true" > eula.txt
    ;;

    false )
      echo -n "Please set the eula to true to run the minecraft server."
    ;;
    *)
      echo -n "Please pick a valid option."
  esac

  sleep 10

  ./run.sh
fi