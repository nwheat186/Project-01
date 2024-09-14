/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR car_key = 0
VAR licence = 0
VAR doom = -1
-> home

// intro

== home ==
You wake up on your 18th brithday and head to the naval register to join the war vs Japan 
+ [Head to your car] -> car
* {not car_key == 1}[Search the room] -> key_pickup
* {car_key == 1} [Search the room again] -> kept_searching

== key_pickup ==
You searched your room and found your keys
~ car_key = 1
* [Keep searching] -> kept_searching
+ [Head to your car] -> car

== kept_searching ==
You found your pilot licence
~ licence = 1
* [Head to your car] -> car

== car ==
{not car_key == 1: You left your keys in your house}
{car_key == 1: Time to head to the naval register}
+ [Go back] -> home
* {car_key == 1} [Head to the naval register]
-> ship_choice

== ship_choice ==
You are at the naval register and the person in charge of assigning you to a ship asks you for your choice between three ships
+ [Pick the escort carrier] -> CVE_intro
+ [Pick the destoryer] -> DD_intro

== CVE_intro ==
A CVE is a mass produced carrier meant to help deal with enemy subs with the use of planes armed with depth charges or provide some air support for landing troops. {not licence == 1: you forgot your pilot licence at home}
* {licence == 1}[Sign on as a pilot] -> CVE_pilot
+ [Pick a different ship] -> ship_choice

== CVE_pilot ==
You join the squadron on USS St. Lo
-> CVE_spotting

== DD_intro ==
A destoryer is capable of damaging any ship with its torpedoes and is armed with depth charges to fight enemy subs and its main guns are duel purpose to fight aircraft and lighter ships.  
+ [Sign on as a gunner] -> DD_gunner
+ [Pick a different ship] -> ship_choice

== DD_gunner ==
You join the crew of USS Johnston
-> DD_sailing

//loop
== function doom_counter ==
~ doom = doom + 1
{
 - doom < 4:
~ return "You see shells flying torwards your ship. you are running out of time" 
}
{
- doom > 3:
~ return "The Japanese are getting more accurate, you will be hit soon"  
}

//DD route

== DD_sailing ==
you are on a mission to help out ground forces fighting on layte gulf as apart of laffy 3. You are with six escort carriers, two other destoryers, and four destoryer escorts. You go through your normal routine on the ship.
    * [carry on with your day] -> Yamato_spotted

== Yamato_spotted ==
As you continue through your day below deck, the speaker turns on. The captain says that there is a Japanese fleet approaching. You go onto the deck and see the largest battleship you have ever seen with 22 other ships.
* [go to your battlestation] -> aiming

== aiming ==
{doom_counter()}
looking at the japanese forces you see that there are 4 battleships, 6 heavy cruisers, 2 light cruisers and 11 destoryers. your 5in gun wont do much against the cruisers or battleships unless they get closer. the director brings your gun to fire at a heavy cruiser to draw fire away from the carriers.
* [fire] -> firing

== firing ==
{doom_counter()}
You help reload the gun as it blazes away at the japanese cruiser as the firing trigger is held down by the main director. You notice that the ship starts turning to face the enemy head on alone.
* [countinue to help reload the gun] -> brawling 


== brawling ==
{doom_counter()}
The ship countines forward and then makes a turn to launch torpedoes as the other destoryers go follow you. The kongo is forced to turn away but the Japanese are still pushing forward. You notice that the shells being fired are different types from star shells to ap. The ship as not been hit yet but you know that is not going to last 

* [brace]-> dd_hit

== dd_hit ==
{not failed_repair:{doom_counter()} you brace for the adventiually hit as three 18.1in shells tear straight through the ship as it falls back, cutting your gun from the main director and your radio.} 
{not AA_gun}You remember that the 40mm bofors nearby has a radio.
{AA_gun} You take control of the gun and fire it at the Japaniese ships
* [repair the director] -> failed_repair
* [head to the AA gun] -> AA_gun
* [{AA_gun} fire away] -> sinking

== failed_repair ==
you tried to repair the connection to the director but the shells from Yamato has left it in a state that it cant be repaired until docked
-> dd_hit

== AA_gun ==
{doom_counter()}
You contact the captain and he states that you should fire using mainual control and match what the data from the radar. 
* [head back to the gun] -> dd_hit

== sinking ==
{doom_counter()}
you blaze away supporting the other dds as the ship gets hit some more time, but they are not enough to stop the ship from fighting. The ship faces a destoryer squadron. After brawling with the destoryer squadron the ship began to sink after receiving so main hits that the crew could not repair quick enough to keep her a float 
* [focus the dd]-> DD_ending

== DD_ending ==
the destoryer squadron manages to sink your ship and as you abandon ship you see the captain of a destoryer salute you as it passes you as they fallback.
-> ending

// CVE Route

== CVE_spotting ==
You are on patrol around layte gulf as apart of Taffy 3 when you spot 4 battleships. You study them to see if they are taskforce 34 but you see that they have pagoda masts. You relize that this is an enemy taskforce.
* [report your spotting information] -> spotting_report
* [continue surveying to look at escorts] -> examine_closer

== examine_closer ==
You see that the battleships are escorted by  6 heavy cruisers, 2 light cruisers and 11 destoryers. You identify 3 of the 4 battleships are a Nagato and two Kongos. The last one is the biggest battleship you have ever seen.

* [report] -> spotting_report

== spotting_report  ==
You state to your carrier you have spotted a large japanese fleet, with one of the battleships being the Yamato, a battleship the size of the entire taskforce combined.

* [head back to the ship] -> Return

== Return ==
{doom_counter()}
You return and your aircraft is quickly refilled and armed with one of the few torpedos on the ship. 
Before you head out you are breifed about what to do.
-> breifing

== breifing ==
 You are instructed to use your torpedo to force the enemy ships away and to make dummy runs once you used your topedo to draw attention away from the carriers.
* [head to the plane] -> launch

== launch ==
{doom_counter()}
You get into the air and make as many runs as you can on the enemy battleships. You are covered by allied fighters that are making strafing runs, but for your later runs it seems like they are running out of ammo.
->low_fuel

==low_fuel ==
Soon you run low on fuel but the carriers are not safe to land on.

* [land on layte gulf] -> airfield

== airfield ==
Other pilots have seen to have the same idea as it seems like the place is getting set up to run constant flight operations

* [help prepare your aircraft] -> swarm

== swarm ==
You are loaded with bombs and are refueled so you take off to attack the Japanese. You noticed that the flagship of the taskforce has turned away so you focus the other ships that are chasing the carriers.
{doom_counter()}
-> Kamakazie

== Kamakazie ==
After constant runs on the enemy ships you see enemy fighters approaching.Yet they don't seem to be providing aircover for their taskforce, but instead are heading to the carriers
*[try to help out the carriers] -> help
*[continue attacking the enemy] -> continue

== help ==
You try to help out the carriers but you could not do much, but the carriers stopped alot of the planes
-> CVE_sinking

== continue ==
You continue to attack but you see that a Japanese zero made it through the flak 
-> CVE_sinking

== CVE_sinking ==
you see {help: a |the } crash into your carrier. The explosion causes a chain reaction, sinking the carrier.

* [countinue to attack the Japanese] -> CVE_ending

== CVE_ending ==
After countless runs, the Japanese turn back. You push the advantage, then land on one of the remaining carriers. 
-> ending

== ending ==
The age of battleships was proven over as US aircraft carriers continue pushing forward until the end of the war and managed to sink the largest battleships in history. Japan would surrender about a year later after the Battle of Samar.
-> END

