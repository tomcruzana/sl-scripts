key serverId = "4e5958ed-1b1a-3e38-85a7-88698b69c66d";
integer serverChannel = -12345404;
integer publicListener;
string interceptedMessage;

default
{
    state_entry()
    {   
        // initialize public chat listener
        publicListener = llListen(PUBLIC_CHANNEL, "", llDetectedName(0), "");
    }
    
    listen(integer channel, string name, key id, string message)
    {
        
        if(llStringLength(message) == 0)
        {
            llSetTimerEvent(0.0);
        }
        else
        {
            // capture message in public chat
            interceptedMessage += llKey2Name(id) +": "+ message+"\n";
            
            // start 5-sec timer interval
            llSetTimerEvent(5.0);
        }
    }

    timer()
    {
        // transmit captured messages to the server prim
        llRegionSayTo(serverId, serverChannel, interceptedMessage);
        
        // clear message cache
        interceptedMessage = "";
    }
}