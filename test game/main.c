//gameboy game by skye waddell <3
#include <gb/gb.h>
#include <gb/cgb.h>
#include <gb/metasprites.h>
#include <stdint.h>
#include "./sprites/playerSprites.c"
#include "./maps/home_town_tiles.c"
#include "./maps/home_town.c"

//game variables
uint8_t mButtons; //gamepad buttons
uint8_t bkgSpeed = 8; //background scroll speed

//states
//LEFT = 0 //RIGHT = 1
//UP = 2   //DOWN = 3
uint8_t state = 3; //spawn in DOWN state

//player variables
uint8_t player_x = 80-8;
uint8_t player_y = 80-1;
uint8_t player_size = 8;
uint8_t player_flip = FALSE;
uint8_t player_speed = 1;
uint8_t animation_delay = 10;
uint8_t player_move = FALSE;
uint8_t move_timer = 0;
uint8_t animation_timer = 0;
uint8_t animation_timer_max = 25;

//main game function
void main()
{
    set_bkg_data(0,87,homeTownTiles); //set bg to memory
    set_bkg_tiles(0,0,32,32,homeTownMap); //set bg tiles

    //set player sprites into memory
    set_sprite_data(0,24,playerSprites);

    //draw left player sprite
    set_sprite_tile(0,0); 
    move_sprite(0,player_x,player_y); 

    //draw right player sprite
    set_sprite_tile(1,2);
    move_sprite(1,player_x + player_size,player_y);

    SHOW_BKG; //draw gb background
    SHOW_SPRITES; //gb draw sprites function
    SPRITES_8x16; //enable tall sprites
    DISPLAY_ON; //turn on the gb display

    //CreatePlayer();

    //main game loop
    while(1)
    { 
        if (animation_timer < animation_timer_max) animation_timer++; else animation_timer = 0;

        switch(state)
        {
        case 0: //LEFT
            set_sprite_prop(0,0);
            set_sprite_prop(1,0);
            
            if (animation_timer < animation_timer_max/2)
            {
            set_sprite_tile(0,16);
            set_sprite_tile(1,18);
            }

            if ((player_move) && (animation_timer >= animation_timer_max/2))
            {
            set_sprite_tile(0,20);
            set_sprite_tile(1,22);
            }
        break;
        case 1: //RIGHT
            set_sprite_prop(0,S_FLIPX);
            set_sprite_prop(1,S_FLIPX);

            if (animation_timer < animation_timer_max/2)
            {
            set_sprite_tile(0,18);
            set_sprite_tile(1,16);
            }
            
            if ((player_move) && (animation_timer >= animation_timer_max/2))
            {
            set_sprite_tile(0,22);
            set_sprite_tile(1,20);
            }
        break;
        case 2: //UP
            set_sprite_prop(0,0);
            set_sprite_prop(1,0);

            if (animation_timer < animation_timer_max/2)
            {
            set_sprite_tile(0,8);
            set_sprite_tile(1,10);
            }
            
            if ((player_move) && (animation_timer >= animation_timer_max/2))
            {
            set_sprite_tile(0,12);
            set_sprite_tile(1,14);
            }   
        break;
        case 3: //DOWN
            set_sprite_prop(0,0);
            set_sprite_prop(1,0);

            if (animation_timer < animation_timer_max/2)
            {
            set_sprite_tile(0,0);
            set_sprite_tile(1,2);
            }
            
            if ((player_move) && (animation_timer >= animation_timer_max/2))
            {
            set_sprite_tile(0,4);
            set_sprite_tile(1,6);
            }
        break;
        }

        mButtons = joypad();

        if (!player_move) // if we arent moving
        {
            //LEFT BUTTON PRESS
            if (mButtons == J_LEFT)
            {
                state = 0;
                player_move = TRUE;
            } else

            //RIGHT BUTTON PRESS
            if (mButtons == J_RIGHT)
            {
                state = 1;
                player_move = TRUE;
            } else        

            //UP BUTTON PRESS
            if (mButtons == J_UP)
            {
                state = 2;
                player_move = TRUE;  
            } else		
            
            //DOWN BUTTON PRESS
            if (mButtons == J_DOWN)
            {
                state = 3;
                player_move = TRUE;
            }
        }

        //If we are moving increase timer
        //so we only move for a certain time
        //then stop moving ~ similar to pokemon movement

        if (player_move)
        {
            if (state == 0)
                scroll_bkg(-1,0);
            if (state == 1)
                scroll_bkg(1,0);
            if (state == 2)
                scroll_bkg(0,-1);
            if (state == 3)
                scroll_bkg(0,1);
            
            if (move_timer < 15)
            {
            move_timer++;
            }
            else
            {
                move_timer = 0;
                player_move = FALSE;
            }

        }

        //Done processing
        //yield CPU and wait for start of next frame
        delay(animation_delay);
        wait_vbl_done();
    }
}