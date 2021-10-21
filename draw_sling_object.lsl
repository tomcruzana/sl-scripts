key owner;
integer is_typing = FALSE;
float volume = 1.0;

toggleTexture(float opacity){
    llSetLinkAlpha(LINK_SET, opacity, ALL_SIDES);
}

default
{
    state_entry()
    {
        owner = llGetOwner();

        if(llGetAttached() != 0){
            llRequestPermissions(owner, PERMISSION_TRIGGER_ANIMATION);
        }

        toggleTexture(0.0);
    }
    
    attach(key id)
    {
        if(id == llGetOwner())
            llResetScript();
        else{
            llStopAnimation("typer");
            llStopSound();
        }
    }
    
    changed(integer change)
    {
        if(change & CHANGED_OWNER)
            llResetScript();
    }
    
    run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_TRIGGER_ANIMATION)
            llSetTimerEvent(0.25);
    }
    
    timer()
    {
        if(llGetAgentInfo(owner) & AGENT_TYPING)
        {
            /* show guitar */
            toggleTexture(1.0);
            
            if(is_typing){
                llLoopSound("Electric Guitar _ Sound Effect", volume);
            }else{
                is_typing = TRUE;
                llTriggerSound("Electric Guitar _ Sound Effect", volume);
                llStartAnimation("typer");
            }
        }else if(is_typing){
            is_typing = FALSE;
            llStopSound();
            llStopAnimation("typer");
            llTriggerSound("ending", volume);
            
            /* hide guitar */
            toggleTexture(0.0);
        }
    }
}
