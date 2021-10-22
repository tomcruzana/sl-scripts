/* NOTE: when doll is singing, it needs to be looking away from the players */

// listener
integer listenHandle;
integer CHANNEL = -666; 

// use - to reverse the direction of swing, eg. -90;
integer rotation_angle = -180;
rotation g_rot_swing;

// sound volume 
float volume = 1.0;
string doll_song = "Mugunghwa Kkoci Pieot Seumnida";
integer is_singing = FALSE;

// user-defined functions
string sing()
{
    // randomize selection of the song (1 - 4)
    integer convertedInt = (integer)(llFrand (1.0) + 1.0);
    return (string) convertedInt;
}

turnHead(float interval, integer singing_val)
{
    is_singing = singing_val;
    llShout(0, " doll singing? " + (string)is_singing);
    llSetLocalRot( (g_rot_swing = ZERO_ROTATION / g_rot_swing) * llGetLocalRot() );
    llSleep(interval);
}


removeListenHandle()
{
    llListenRemove(listenHandle);
}

playSongSpeed(string msg)
{
        if (msg == "1")
        {
            llShout(0, doll_song + " 1");
            llPlaySound("easy_doll",volume);
            llListenControl(listenHandle, FALSE);
            turnHead(5.0, TRUE);
            llListenControl(listenHandle, TRUE);
            turnHead(0.0, FALSE);
        }    
        else if (msg == "2")
        {
            llShout(0, doll_song);
            llPlaySound("medium_doll",volume);
            turnHead(3.0, TRUE);
            turnHead(0.0, FALSE);
        }  
        else if (msg == "3")
        {
            llShout(0, doll_song);
            llPlaySound("hard_doll",volume);
            turnHead(2.0, TRUE);
            turnHead(0.0, FALSE);
        }  
        else if (msg == "4")
        {
            llShout(0, doll_song);
            llPlaySound("evil_doll",volume);
            turnHead(1.0, TRUE);
            turnHead(0.0, FALSE);
        } 
}


default
{
    
    state_entry()
    {
        listenHandle = llListen(CHANNEL, "", "", "");
        
        // initialized doll rotation angle
        g_rot_swing = llEuler2Rot( <0.0, rotation_angle * DEG_TO_RAD, 0.0> );
        
        // play doll song with the specified interval value
        playSongSpeed(sing());
        llSetTimerEvent(10.0);
    }

    listen(integer channel, string name, key id, string message)
    {
        // shoot player if not in standing state and if doll isn't singing
        if (message != "Standing")
        {
            llPlaySound("fire_auto", volume);
            llRegionSay(CHANNEL, "KILL");
        }
    }
    
    timer()
    {
        playSongSpeed(sing());
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
