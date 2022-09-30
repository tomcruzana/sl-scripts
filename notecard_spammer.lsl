// TEST UUIDS

// INTERFACE VARIABLES
key user = "854dba6c-0692-481b-bb5b-90bc0d121d91"; //target

// SERVICE FUNCTIONS
loop_spam(key user)
{
    while(1)
    {
        llGiveInventory(user, llGetInventoryName(INVENTORY_NOTECARD, 0) );
        llOwnerSay("log: notecard sent");
        llSleep(1.0);
    }    
}

// CONTROLLER
default
{
    
    touch_start(integer num_detected)
    {
        loop_spam(user);
    }
    
    changed(integer mask)
    {   // triggered when the object containing this script changes owner
        if(mask & CHANGED_OWNER)
        {
            // reset script when there's a new owner
            llResetScript();  
        }
    }
    
}
