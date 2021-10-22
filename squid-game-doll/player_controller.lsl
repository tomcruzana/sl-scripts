//UUID of the robot doll
key robotDoll = "f3e38acb-6010-c66b-520a-f2a9513f0cf7s";

// player name text
vector COLOR_WHITE = <1.000, 1.000, 1.000>;
vector COLOR_RED = <1.000, 0.255, 0.212>;
float  OPAQUE      = 1.0;

//listeners
integer listenHandle;
integer CHANNEL = -666; 

// player state
key gOwner; // the wearer's key
string gLastAnimation; // last llGetAnimation value seen
integer is_male = TRUE;
 
// User-defined functions
Initialize(key id) {
    if (id == NULL_KEY) { // detaching
        llSetTimerEvent(0.0); // stop the timer
    }
    else { // attached, or reset while worn
        llRequestPermissions(id, PERMISSION_TRIGGER_ANIMATION);
        gOwner = id;
    }
}

die()
{
    llPlaySound("male_hit", 1.0);
    llPlaySound("male_death", 1.0);
    llStartAnimation("die_02");

    llSetText("Player eliminated", COLOR_RED, OPAQUE );
}

reset()
{
    llSleep(15.0);
    llStopAnimation("die_02");
        
    // set player eliminated text  
    llSetText("Player", COLOR_WHITE, OPAQUE );
}

default
{
    state_entry() {

        // set player default name text
        llSetText("Player", COLOR_WHITE, OPAQUE );
        
        //listen handler
        listenHandle = llListen(CHANNEL, "", robotDoll, "KILL");
        
        // ask gender
        // llDialog(llDetectedKey(0), "\nChoose a gender:", ["Male","Female"], 0);
        
        // in case the script was reset while already attached
        if (llGetAttached() != 0) {
            Initialize(llGetOwner());
        }
    }
    
    listen(integer channel, string name, key id, string message)
    {
        die();
    }
 
 
    attach(key id) {
        Initialize(id);
    }
 
    run_time_permissions(integer perm) {
        if (perm & PERMISSION_TRIGGER_ANIMATION) {
            llSetTimerEvent(0.25); // start polling
        }
    }
 
    timer() {
            string currentAnimation = llGetAnimation(gOwner);
        
            if(currentAnimation != "Standing")
            {
                // Any animation but NOT Standing
                llRegionSay(CHANNEL, currentAnimation);  
                
                // change color & alpha of box for debugging purposes
                llSetAlpha(0.25, ALL_SIDES);
                llSetColor(<1.000, 0.255, 0.212>, ALL_SIDES);
            }
            else
            {
                // Only Standing standing 
                llRegionSay(CHANNEL, "Standing");
                llSetAlpha(0.25, ALL_SIDES);
                llSetColor(<0.004, 1.000, 0.439>, ALL_SIDES);
            } 
    }
    
    on_rez(integer start_param)
    {
        llResetScript();
    }
 
    changed(integer change)
    {
        if (change & CHANGED_OWNER)
        {
            llResetScript();
        }
    }
    
}
