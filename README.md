# osu-mass-bg-changer
Power shell script for mass changing background images in maps directory for osu! game
This script replaces all images inside each map folder with the same randomly chosen image from source folder.

# How to use
First you have to create a folder and add some images which will replace old backgrounds. Name it as you like, in my example below it named Backgrounds.

After adding enough images to new images folder open script in text editor and put paths to your new images folder and path where your osu! maps are located.

For example 1 and 2 line of code should look something like this:
```
$SourceFolder = "D:\Games\Backgrounds"
$SongsFolder = "D:\Games\osu!\Songs"
```
Save file and exit.

Open Windows PowerShell in administrator mode.
Allow running local scripts by typing command:
```
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```
Run a script from path where it's located. For example if it's located on Desktop folder the command will be:
```
& "$env:USERPROFILE\Desktop\replace_bg.ps1"
```
**$env:USERPROFILE** is an environment variable which gets your windows username, you don't need to change it manually.

If you run a script with osu! client opened then you have to press **f5** to refresh all the maps and apply changes.
