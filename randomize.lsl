default
{
    touch_start(integer total_number)
    {
        integer convertedInt = (integer)(llFrand (4.0) + 1.0);
        llSay(0, (string) convertedInt);
    }
}
