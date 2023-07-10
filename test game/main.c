//gameboy game by skye waddell <3
#include <gb/gb.h>
#include <stdio.h>

void main()
{
    uint8_t mButtons;
    printf("ver2ion is the best");

    while(1)
    {
        mButtons = joypad();
        if(mButtons & J_A)
            printf("A ");
        
        while(mButtons == joypad());
    }
}