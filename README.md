RtR-Epoch-M-BB-Chernarus-MiniPack
=================
v1.0.1.5-m-bb-ex-0.1-beta
=================
Epoch 1.0.1.5 by  vbawol  and modified by me
no "Spawn as Zombie" / no "Break Tool" / all Objects tied to PlayerUID [cd-key] instead of CharacterID [serverside created]

Base Building 1.2  by  Daimyo21  and  kikyou2  and modified / fixed by me
with improvements 0.3 and overall 56 buildable objects


And some useful plugins:
Self Bloodbag  [by  Krixes]
Tow  (no Heli-Lift cause of critical bugs)  [by  R3F]
Animated Plane Crash Sites  [by  Gorsy]
AN2 Plane Carepackage Drops  [by  Gorsy]
Illuminant_Tower has now working lights  [by  axeman]
Safezone script for Trader Cities  [by  ghostphantom172]
Custom Loading Screen  [Design © 2013 by  exodon]


Known Bugs / Issues:  

1. Camo Nettings and all "Towers" wich has been build with Base Building aren't removeable cause some messed up code (Camo Nettings) and a too far away "center point" (Towers) wich cause that u cant target the point on the towers to show up the remove action in the scroll menu... but i'm already working on a fix for this issue...

2. Tag as friendly isnt working due some changes in the epoch code... bug localised but haven't found a way to fix it....
  
  
Important Notes:
If u want to remove some plugins i have added, u should bring some knowledge in arma 2 scripting... cause i dont have that much time to write a tutorial how to activate each single function / plugin...  I'm already working on a "standalone" version of my base building... but i had to modify a lot of files to get this finally working without critical bugs and thats why i need much more time to create a understandable "How To" cause otherwise u could create a lot of critical bugs when u just try to copy my files out of the mission into yours... there are a lot of serverside overrides to the epoch main system wich i had to create to make both system work together....  AND i can only give support to the modifications i have made... i cannot answer questions wich belong to the main coders versions / contents...
  
  
Package Content:
1. dayz_server.pbo
2.  dayz_11.epoch.chernarus.pbo     (you maybe have to rename this... depends on wich instance u are using for your epoch... but this is the default name fromthe epoch release...)
3. Battleye Filters  (some modified filters, u wont get any kicks with these but maybe there is some risk to give hacker some ways to execute their scripts... but on my server the hackers always getting kicked cause they use too many scripts... some of them will activate the "ban-hammer" and also depends on wich other "anti hack" plugins u are using... i always recommend to use something like "AntiHax" or "Gotcha" but for those i cant give u any working files / filters... but i think with your server rpt log and the log files from your pluging u will be able to easily modify the filters to your needs to be able to play this mission without any kicks / bans...)
  
Download:  RtR-Epoch-M-BB-Chernarus-MiniPack_0-1-beta.rar
  
How To Use / Install:
(when u already have some experience with arma servers than u know what you have to do)
  
1. Download and  unpack  the .rar file somewhere...
2. After unpacking the rar file open the folder  "RtR-Epoch-M-BB-Chernarus-MiniPack_0-1-beta",  u should have a Battleye folder, a readme file, two .pbo files and two .sql files....
3. Copy the  "dayz_server.pbo"  and  replace  your old one with this... (should be stored in  "...\@Dayz_Epoch_Server\addons\"  )
4. Copy the  "dayz_11.epoch.chernarus.pbo"  and  replace  your old one with this (maybe u have to rename this file... depends on how your old file is called... but only chernarus is working with this one!!)
4.1 (Optional) If u want to edit the start loadout or some other epoch configurations then u have to unpack the mission pbo and edit the init.sqf, it already has the required code inside cause this package comes with a map in the loadout) but only do this if u really know what u are doing... i wont give support on modified packages... sorry but my time is not endless ^^ )
5. Open the  Battleye  folder and copy  all the contents  and  replace  your old filters with this one... (server battleye folder should be in the same folder  where your server config file is stored  in...)
6. Use phpMyAdmin or some software like Navicat or HeidiSQL... connect to your database... delete all tables... and import the  "RtR-Epoch-M-BB-Chernarus-MiniPack_0.1beta.sql"  file... ignore error messages... i have these errors too but everything is stored correct... maybe its only the software i use to edit the database... (u see there and extra sql file called  "CleanupActions.sql"  if u want your database to clean up destroyed cars, dead bodies and filling up empty traders stock than also import this file too...)
7. Start your Server and when u have done everything right u can have fun

  
  
Last Words:
I hope i havent forget any credits or something else... and btw... sry if some words are written wrong or when u dont understand something directly but my english is not the best ^^ i know that ^^ but i'm fine with that xD and when u find any bugs or exploits pls tell me so i can take a look into it... i already tested (together with some creativ players) nearly everything wich is possible to exploit or wich could cause bugs... only bugs are already in the "know issues" section... ^^ when u find something else the list will grow... but i hope it wont... cause i'm kind of a "Coding Noob" and it take a lot of time for me to fix bugs xD
And if u want some more stuff in this package or if u may have a solution for the known issues, then dont hesitate to contact me...
