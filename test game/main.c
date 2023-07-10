//gameboy game by skye waddell <3
#include <gb/gb.h>
#include <stdio.h>
#include "./sprites/player.c"

void main()
{
    //game variables
    uint8_t spriteIndex = 0;
    uint8_t playerX = 80;
    uint8_t playerY = 70;
    uint8_t mButtons;

    //debug msg
    printf("ver2ion is the best");

    //player top left
    set_sprite_data(0,1,player);
    set_sprite_tile(0,2);
    move_sprite(0,playerX,playerY);

    //player top right
    set_sprite_data(1,2,player);
    set_sprite_tile(1,5);
    move_sprite(1,playerX+8,playerY);

    //player bottom left
    set_sprite_data(2,3,player);
    set_sprite_tile(2,4);
    move_sprite(2,playerX,playerY+8);

    //player bottom right
    set_sprite_data(3,6,player);
    set_sprite_tile(3,6);
    move_sprite(3,playerX+8,playerY+8);


    SHOW_SPRITES;

    //main game loop
    while(1)
    {
        mButtons = joypad();

        switch(joypad()){
            case J_LEFT:
            scroll_sprite(0,-1,0);
            scroll_sprite(1,-1,0);
            scroll_sprite(2,-1,0);
            scroll_sprite(3,-1,0);
            break;

            case J_RIGHT:
            scroll_sprite(0,1,0);
            scroll_sprite(1,1,0);
            scroll_sprite(2,1,0);
            scroll_sprite(3,1,0);
            break;

            case J_UP:
            scroll_sprite(0,0,-1);
            scroll_sprite(1,0,-1);
            scroll_sprite(2,0,-1);
            scroll_sprite(3,0,-1);
            break;

            case J_DOWN:
            scroll_sprite(0,0,1);
            scroll_sprite(1,0,1);
            scroll_sprite(2,0,1);
            scroll_sprite(3,0,1);
            break;
        }
        delay(15);

    }
}