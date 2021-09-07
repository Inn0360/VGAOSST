-- Author: Howin Tam
-- File Purpose: Takes line by line in, and stores it to the correct pixel location
--              Once that has finished, allow it to be read and sent

-- Input 
--640 x 480 pixel canvas ( 639 x 479)
-- pixel position signal (vga timing)

-- Increment Signal - saving
-- Data in signal - saving
-- CLk_in signal (same as vga timing)

-- horizontal coordinate + vertical coordinate ( reading)
--

-- Output
--  reading output
--
-- 
-- 


library ieee;
use ieee.std_logic)1164.all;
use ueee.numeric_std.all;

entity vid_memory is 
    generic(

        --- addition by
        pixel_position_h:       integer     := 0; -- goes up to 80
        pixel_position_v:       integer     := 0); ---goes up to 30

    port(
        
        --Normal
        clk_in:                     in    std_logic;

        -- Saving information to Module
        increment:                  in    integer;
        data_in:                    in    std_logic_vector(7 downto 0);

        --Reading
        horizontal_coords:          in    std_logic;
        vertical_coords:            in    std_logic;

        out_green:                  out   std_logic;
        out_red:                    out   std_logic;
        out_yellow:                 out   std_logic);



        -- video memory


        
end vid_memory;


architecture arch of vid_memory is 
    increment
    --constants here

    begin

        --writing to video memory
        process(clk_in, increment, data_in,)


        process(clk_in,pixel_position_h, pixel_position_v, increment)    
        begin
            if(clk_in'event and clk_in = '1') then
                if(increment == '1') then
                    pixel_position_h <= pixel_position_h + 1;
                    if ( pixel_position_h >= 80) then
                        pixel_position_h := 0;
                        pixel_position_v := pixel_position_v + 1;








