//Bomb script by: tom primswitch
integer gap = 1;
integer counter = 120;
//for text
vector COLOR_WHITE = <1.0, 1.0, 1.0>;
float  OPAQUE      = 1.0;
 
default
{
    state_entry()
    {
       
        llSetText("Click to activate me! ", COLOR_WHITE, OPAQUE);
    }
    
    touch_start(integer total_number)
    {
        if (  llVecDist(  llDetectedPos(0), llGetPos()  ) < 3 ) {  
        llShout(0, "The Bomb has been activated!");
         llSetText("Detonating!", COLOR_WHITE, OPAQUE);
        llSetTimerEvent(gap);
        } else {
            llSay(0, "You are too far away to activate the bomb!");
        }
    }
 
    timer()
    {
        if (counter == 0)
        {
            llShout(0, "Bomb Exploded");
            llRezObject("READY-USE EMITTER", llGetPos() + <0.0,0.0,1.0>, <0.0,0.0,0.0>, <0.0,0.0,0.0,1.0>, 0);
            llShout(0, "TERRORISTS WIN!");
            llDie();
        } else {
        counter = counter - gap; 
        llSay(0, (string)counter+" seconds before explosion!");
        }
    }
}
