key owner;
integer serverChannel = -12345404;
integer serverListener;
string oldMsg;
string newMsg;

default
{
    state_entry()
    {
        owner = llGetOwner();
        serverListener = llListen(serverChannel, "", "", "");

    }
    
    listen(integer channel, string name, key id, string message)
    {
        newMsg = message;
        
        if(newMsg != oldMsg)
        {
            llInstantMessage(owner, newMsg);
            oldMsg = newMsg;
        }
    }
}
