# Defcon MUD - DC 28 Safemode

<p align="center">
  <img src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/welcome.png?raw=true">
</p>

## Spoiler Warning
This write-up contains spoilers for the game. As I believe this MUD will still exist in some form after DC28, please proceed with caution if you don't want the game spoiled.

## Intro
For Defcon 28: Safemode it was announced that [EvilMog](https://twitter.com/Evil_Mog) was going to be running an online MUD. Along with the MUD were some in game challenges/puzzles that led to flags that would gain points in an accompanying CTF. This MUD has previously been run at Derbycon and lucky for me there was some info out there about the game that Evil_mog alluded to. Namely an [interview on Iron Sysadmin](https://www.youtube.com/watch?v=xfFA7JOa5s4) and this [DerbyCon 2019 CTF writeup](https://labs.nettitude.com/blog/derbycon-2019-ctf-write-up/). 
Also lucky for me, EvilMog decided to open the MUD up a few weeks early to let people familiarize themselves with the MUD while they wrapped up finalizing the updates to the game that would be made for Defcon. I used this time to familiarize myself with Mudlet, write some helpful triggers/scripts and try to familiarize myself with the game even though I anticipated it would change a bit for the actual CTF at Defcon. [CTF rules were here](https://mud.mog.ninja/) and [CTFD scoreboard here.](https://ctf.mog.ninja/challenges)

## MUD Clients
I have played a few text-based adventures but never a MUD. I originally connected via telnet but eventually found out that there were clients tailored specifically for playing MUDs that had really usefull tools like triggers and mappers baked in. I ended up using [Mudlet](https://www.mudlet.org/). Mudlet has the ability to let the user trigger actions based on text recieved from the MUD, type shorter command aliases in to perform in-game tasks, run timed actions and write Lua scripts that can interact with the game. Evil Mog stated that bots and triggers were encouraged so I used them to my advantage. Mudlet also has a mapper built in, which when used alongside the [IRE mapping script](https://wiki.mudlet.org/w/IRE_mapping_script) provided a way to create maps of different in-game areas (Some DerbyMUD vets who used graph paper may appreciate this).

## Playing the MUD
### Newbieville / Woodland Creatures
The first area had 2 main objectives, find and kill 17 different Woodland creatures and press the button on the table in the hole in the tree after battling a bunny that didn't like you picking a flower. I believe there was an exploit where you could gain XP off the bunny by continually picking the flower but I didn't play around with it too much. 
There was also a tree near the starting point that had a branch you could `break` off and `wield` as weapon to help kill the creatures in the forest to the north. 
The woodland creatures were all clustered together towards the south end of the forest. Only one of them was especially hard to beat, but if you had a stick and decent stats on your initial character then this could be done without needing to rest up too often. 
There was also a DC28 crossover event that occured in this area, one of the @ANDnXOR crew Hyr0n has been transmogrified into a gerbil and if you looked at him you would get a flag for their badge challenge this year `flag:2LwRLe` #MattDamon. 

*Woodland Area with map and labels autocreated by Mudlet Scripts*

<p align="center">
  <img height="300" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/woodlandLabels.png?raw=true">
</p>


After you completed the Woodland and claimed the first CTF flag for it at the wooden sign, you can head down to Core/Sci-Fi.

### Core / Sci-Fi
When you head down from newbieville you get popped with a tranq dart that puts you into a technicolor cryosleep and you eventually wake up in a mining colony. For this area of the game, you can reference a `compass` that gives your position on an in-game map as well as coordinates. I ended up scraping coordinates from the `compass` and used them to move the rooms around on my mudlet map so that the layout would match the games. Rooms were 10 coordinate spaces away from one another in most cases and odd overlaps could happen if I didn't do this. Furthermore, there is a transit system that jumps you many coordinate spaces away as you move through it and copying the `compass` coordinates helped keep all that straight. I later learned that I could be calling `lua GMCP.Room.Info` and getting the x,y,z coords from there, but I had already written a trigger that scraped the coord data from the compass. 

The core/sci-fi are is large and sprawling. The main dome is split into quadrants, you start in the SE and need to go to the SW quadrant to buy armor/weapons, get healed, advance your level and re-roll your character if that's somethign you want to do. Between the CTF webpage and the `quests` board in Human Resources, you can keep track of what quests still need to be completed. 

#### Depth-First-Search 

It became immediately obvious that there was a massive ammount of rooms to explore based on the hand drawn maps I saw from the DerbyCon writeup, I figured I would start by mapping out as much of the MUD as I could. I wasn't familair with the term but @babint clued me into Depth First Search algorithims. It took me a few hours but eventually I wrote this lua script that recorded what room I was in, what direction I came from, what exits from the room there were, and then sequentially explored each exit from a room as far as it could only backtracking when I hit a dead end or had fully explored an area. There were a few bugs in the script but it allowed me to map out what I think is 90% of the MUD map (700+ rooms) in just a few minutes. This made exploration exponentially easier.

<p align="center">
  <img height="300" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/sewer_automap.gif?raw=true">
</p>


[Depth First Search code](https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/depthFirstSearch.lua)

With most of the MUD mapped out I tried exploring and killing some mobs but died often as I was low level with low level gear. In order to level up, the easiest way seemed to be the crypto mines. 

#### Crypto Mines
There are four different in game crypto mines with varying levels of payout. The basic idea is that you type `crypto` and after a set ammount of time you earn some in game money and experience. Depending on how you choose to exploit this, you can get punished and have your level reset to 0. The west mine pays out the least followed by the east, the south and the largest payouts being at the north mine. The west mine is available from the start of the game, but you need to buy upgraded mining passes to unlock the east and south mines. The north mine is available from the start of the game, but you need to solve somewhat simple math equations every time you run `crypto`. There was a CTF challenge to write a crypto-currency miner and I believe this had to be completed at the north mine. Trying to spam `crypto` too often at any other mine would result in punishment. I wrote a Lua script to pull out the integers and operators from the equations the crypto-mine would throw at me and solve the equation for me. This could solve the equations rapidly and earned me a CTF flag for the AI cryptominer as well as decent ammounts of credits and XP.

*Example crypto problem:*
```
Solve: 769 * 828 / 435 - [blank] * 600 / 179 = -1255
Represented in LPC as:
  total = (varA * varB / varC - varD * varE / varF);
```

<p align="center">
  <img height="300" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/northcrypto2.gif?raw=true">
</p>

[Crypto Miner code](https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/cryptoMiner.lua)


Now that I had lots of XP and credits, I leveled up my character and got a sweet set of mogium-unobtanium armor and went off to complete the rest of the quests. 

### Pottles the Gerbil
Pottles the Gerbil was in a small section of the sewers, two levels down. This gerbil was constantly on the move so you had to be quick to attack them if you saw them. 

### Wizard Potion
To find the wizard potion you had head to the NW section of the sewers and go down to a second level full of mobs named after different exlpoits (Rowhammer, Heartbleed, etc..). After navigating through the winding maze of exploits you eventually find a room you can go down another level from and you can `look` and find a purple potion on the ground. Drinking the potion earns you a CTF flag and transports you back to 0,0,0 at the center of the Core/Sci-Fi area. 

### Exploration Quests
To complete the exploration quests, you need to head to the SW area in the sewers and go down many levels. Eventually you hit a maze full of teachers, bankers, lawyers and goons, after navigating this area and heading down another level there is another maze full of monkeys, professors droids and stoners. Finally, after finding a room to go down two more levels you end up in a large sewer area with various rats, eels, snakes, lizards, ferrets and alligators. I initially thought I needed to kill these creatures for the exploration quests, but it turned out you only needed to `look` at them to get the CTF flags. Creatures needed here were `Mediocore Alligator` `Mediocre Lizard` `Meh Ferret` `uninitiated eel` `uninitiated snake` and `meh rat`. 

### Parrot Quest
While exploring the sewer with the creatures for the exploration quests, you could find a few more rooms leading down. One had a decoy Parrot that confused me quite a bit, but a different room led down the `THE parrot` that once killed would provide the flag for the Parrot Quest

### Sewer Quest
I personally thought this was the hardest quest in the game, or at least it gave me the most trouble. The text on the CTF site gave you the starting point `A genetic experiment has taken refuge in the sewers, find and eliminate it. Talk to arnie in the sewers below the Colony.` After finding Arnie and talking for a while you eventually had to kill him in order to get a tracker. Once the tracker was in your inventory you could `track` and it would point you in the direction of the secard, an access card that would allow you to enter the steam generator control room. Throughout this tracking process I discovered pipes that you could `enter` that weren't listed as exits (tricky!) and this opened up a few more areas in the sewer that I hadn't previously explored. This was a bit of a decoy as the tracker lead you to a button that used to work for DerbyMUD but is now defunct. If you `look` at the button it told you to look behind a maglocked door in the eastern dome for the secard. For one playthrough of the MUD I went through this process and got the secard that was behind a maglocked door but never actually figured out how to use it correctly. Apparently there is a false wall near a dry alcove in the sewer that you could get through and use the secard to access a control room. The method I chose was to get the lockpicks from behind the poster in the prison, and use the lockpicks on the loose floor panel in the sewer to gain access to the room where you had to fight the sewer boss. After killing the sewer boss you got the CTF flag for the Sewer Quest.

### Key Quest
This was another tricky quest! It required fully exploring the entire map and really digging into the text descriptions of each room. Essentially there are a series of buttons spread out all over the game that you need to press to update your characters key tracker. Once you have found and pressed all the buttons, you can `claim` the quest at Human Resources in the SW quadrant of Core/Sci-Fi. These are the location of the 8 keys `sewer x-50y30z0, north x40y230z0, east x230y-10z0, prison basement x190y460z-10, nympho, x450y-640z0, city x-20y50z0, dungeon 8-b`. For the most part there is a button on the wall in those rooms that you just need to press. I found most of these by using a mudlet trigger that played a wav file every time it saw the word `button`. This kept me from missing a button as I was exploring. There were however a few hidden buttons, one was in EvilMog park behind a shrub, one was under some papers on a desk in the north dome, and one of the most hidden was in a room that was behind a maglocked door in the east housing dome. The east housing dome maglock doors can be unlocked by shutting off the power in the area. This was one of my favorite mechanics of the game. You had to find the power room aka the dark room. When you enter this room you are greeted by the text `It is too dark to see.` If you `flip switch` in this room, you can control the power for the East Dome. With the power turned off, you can now access what is behind the three maglocked doors. It can be a bit confusing though because with the lights out, it is too dark to see in every room you visit, so make sure you have your path mapped out in advance. (Or use GMCP to check the room coords) Of the three maglocked doors, one has nothing of use behind it while another contains the secard, and the third has the button that will give you the final key for the Key quest. 

### Evil Quest
Last but not least is the Evil Quest. This starts with the text from CTF site `Something is rotten on the Colony, find foreman Kendal and ask him about 'rats'` This presented a problem that would continue throughout the duration of this quest. It required you to find different mobs and NPCs given only their name, without any clue as to their location. I first referenced the DerbyMUD writeup and the maps that EvilMog showed on the Iron Sysadmin show, but that only got me so far. It really helped with finding the Queen rat's location near the fountain though ;) I ended up writing a script in Lua that would print out a label and put it on the map for any NPCs or Mobs that were in a room. It also logged all this information to a text file. With those two scripts implemented, I could run my Depth first search script, go back through the entire map in a few minutes, then have labels on my map as well as a log that I could ctrl+F for any specific mobs or NPCs. Then I moved forward with the actual quest. 
- Kendall wanted me to kill the Queen Rat.
- Then I needed to tell Carson about the Rat.
- Then Carson wanted me to kill the Cyberslime.
- Then Carson wanted me to talk to Norman.
- Norman lost his wallet at the Roxbury, I went and `searched` the Roxbury till I found a wallet.
- After returning Norman's wallet he asks you to go to the reactor storeroom and to use his access card on the touchpadd.
- This room (-20, 10, 0) is locked and I used the picks from behind the poster in the prison to `lockpick` and get access to the `touch padd`. Using the touch padd you can upgrade your company access card and can now `access` Grey's computer in Grey's Office (80, -10, 0).
- You are then instructed to find old Tom the miner and ask him about Evidence.
- Old Tom is hanging out in the library reading room (50, 290, 0). He tells you that (surprise!) EvilMog is behind everything and to return to the touch padd.
- The touch padd tells you to go to the zombie bar(450, -660, 0) to find EvilMog's Agent.
- After battling an aggressive Child or 2 you find Evil Mog's Agent at the zombie bar and are told to eliminate Johnson. Up to this point, basically all of that could've been deduced from the previous DerbyCON writeup but I think Johsnon may have been an addition for Defcon.
- Johsnon is back down in the sewers at (-40, 70, -10). After killing Johnson you EvilMog's Agent tells you to return to the access panel (touch padd).
- The touch padd instructs you to find the access code in the sandworm pits... which are back in the sewer, a level down from where you just came from at (-80, 50, -20).
- You need to `search` the sandworm pit and kill the Sandworm. Then EvilMog's Agent tells you to head back to the touch padd. This is the last step, you are prompted with the following upon returning to the touch padd 
```
Ok so here's the deal most of the company is on the take, and the company is wholy owned by the church of wifi.... 
You have a choice, you can either go with the flow and work for the church or
you can exit the airlock and find another colony...
To make this choice you must use the access code of good or evil.
``` 
At this point you can `access good` and get thrown out the airlock to your demise, or `access evil` and complete the quest and get the final CTF flag!

### Exploits
The only real exploit I ever became aware of was using `set` to alter the location you `recall` to. So you could set a room location, log out and log in and use that as a fast travel/transport option to move quickly around the game, although I never really utilized it. 

### FED Mode
After the MUD went live a handful of people competed all the quests and a Hard mode was implemented. In this mode you couldn't use armor or weapons higher than level 2 and you were banished from the north crypto mines. This made things a bit trickier.

## Final Scores / Conclusion
I was in the lead for the beginning of the MUD when it went live but then needed to play catch up after FED mode was introduced. I'm happy to have earned my first win for a Defcon contest via this MUD. I learned a decent ammount about Lua, and Mudlet and had a good time while I was at it. 

<p align="center">
  <img src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/defconmud_top10.png?raw=true">
</p>

#### Shouts
Big thankyou to Evil Mod for putting in the time to make this MUD available for Defcon safemode. I'm hoping to learn more about the back-end of the game and implement new features throughout the year and possibly for further iterations of the MUD at future con's. Shout out to @babint for helping me think through the depth first search stuff as well probing multiple things in the MUD and Mudlet in general. Finally, shout out to vimk1ng and Shadyman for the solid competition and congratulations to vimk1ng on winning the speed run contest. (Yes, there were speed run competitions)

## Maps
I'd like to make some better maps, but these may be able to help. At the very least they illustrated the complexity of these areas. 

#### City / Core / Sci-Fi

<p align="center">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_core_4quads.png?raw=true">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_core_nw.png?raw=true">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_core_se.png?raw=true">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_core_sw.png?raw=true">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_coreXL.png?raw=true">
</p>

#### Prison / Prison Basement

<p align="center">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_detentioncenter.png?raw=true">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_prisonbasement.png?raw=true">
</p>

#### North / East / Roxburry + Nympho

<p align="center">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_northdome.png?raw=true">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_easthousing.png?raw=true">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_roxbury-nympho.png?raw=true">
</p>

#### Sewer

<p align="center">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_sewer.png?raw=true">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_sewer_ne.png?raw=true">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_sewer_nw.png?raw=true">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_sewer_se.png?raw=true">
</p>

#### Labrynth / Dungeon / Explore Quests + Parrot

<p align="center">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_exploreparrotsewer.png?raw=true">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_labrynth.png?raw=true">
  <img height="100" src="https://github.com/blinkingthing/ctfs/blob/master/dc28-defcon-mud/maps/map_labrynth2.png?raw=true">
</p>
