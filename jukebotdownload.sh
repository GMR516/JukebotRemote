#!/bin/sh
echo ""
echo "Jukebot installer started."

if hash git 1>/dev/null 2>&1
then
    echo ""
    echo "Git Installed."
else
    echo ""    
    echo "Git is not installed. Please install Git."
    exit 1
fi


if hash dotnet 1>/dev/null 2>&1
then
    echo ""
    echo "Dotnet installed."
else
    echo ""
    echo "Dotnet is not installed. Please install dotnet."
    exit 1
fi

root=$(pwd)
tempdir=JukebotInstall_Temp

rm -r "$tempdir" 1>/dev/null 2>&1
mkdir "$tempdir"
cd "$tempdir"

echo ""
echo "Downloading Jukebot, please wait."
git clone --recursive --depth 1 https://GMR516@github.com/GMR516/Jukebot.git
echo ""
echo "Jukebot downloaded."

echo ""
echo "Downloading Jukebot dependencies"
cd "$root/$tempdir/Jukebot"
dotnet restore
echo ""
echo "Download done"

echo ""
echo "Building Jukebot"
dotnet build --configuration Release
echo ""
echo "Building done. Moving Jukebot."

cd "$root"

mv "$tempdir"/Jukebot Jukebot


rm -r "$tempdir"
echo ""
echo "Installation Complete."
echo "Running Jukebot"
dotnet run --configuration Release
cd "$root"
bash jukebotautorestartupdate.sh
rm "$root/jukebotdownload.sh"
exit 0