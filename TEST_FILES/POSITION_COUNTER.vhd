--Author: Howin Tam


-- Description: Takes Integer values, and identifies whether there are any special characters
-- That need to be intercepted before ASCII Character Map should print them
--- Also Keeps track of where the character should be printed in a 2d matrix thought a vertical and horizontal counter

-- inputs/outputs
    --ascii integer input
    
    -- Output
    -- Horizontal Counter Output
    -- Vertical Counter Output
    -- ascii integer output


--Special Characters and their descriptions
    -- 0x0B -Vertical Tab (Pushes Down one line)
    -- 0x10 -BackSpace (Moves cursor back by one witout destroying char)
    -- 0x11 -Tab
    -- 0x12 -Line Feed
    -- 0x15 -Carriage Return + Line Feed
    -- 0x40 -Space Bar

library ieee;
use ieee.std_logic.1164.all;
use ieee.numeric_std.all;


entity ascii_interpreter is 
    port(
        --inputs
        in_clk:           in     std_logic;
        in_ascii:         in     integer;

        --outputs
        --Horizontal can only go up to a max of 80
        --Vertical can only go up to a max of 30
        out_horiz_count:  out    integer:= 0;
        out_vert_count:   out    integer:= 0;
        out_ascii:        out    integer:= 0);

end ascii_interpreter;


architecture ticktock of ascii_interpreter is

    signal temp_vertical:     integer;
    signal temp_horizontal:   integer;
    signal increment_flag:    std_logic:= '0'; --Flag used to indicate if horizontal goes above max
    
    begin
        --identify special characters that will change the position of the horizontal and vertical counters

    special_char:process(in_ascii)
    begin
        --equates temporary variable to current position

        temp_vertical <= out_vert_count;
        temp_horizontal <= out_horiz_count;

        case in_ascii is
            when 11 => temp_vertical    <= temp_vertical + 1; -- Vertical Tab
                       temp_horizontal  <= temp_horizontal + 1;
            when 16 => temp_horizontal  <= temp_horizontal -1;-- Backspace
            when 17 => temp_horizontal  <= temp_horizontal + 4; -- Tab 4 character spaces
            when 18 => temp_vertical    <= temp_vertical + 1;
            when 21 => temp_horizontal <= 0;              --Carriage Return + Line Feed
                       temp_vertical <= temp_vertical + 1; 
            when 64 => temp_horizontal <= temp_horizontal + 1; --Space
            when others => null;
        end case;
    end process special_char;


    limitCheckHorz: process(temp_horizontal)
            --verifies to check that max numbers hvae not been reached
    begin
        case temp_horizontal is
            when 0 to 80 => out_horiz_count <= temp_horizontal;
            when others => out_horiz_count <= 0;
                increment_flag <= not increment_flag;
        end case ;
        
    
    end process limitCheckHorz;

    limitCheckVert: process(increment_flag)
        begin
        case temp_vertical is
            when 0 to 30 => out_vert_count <= temp_vertical;
            when others => out_vert_count <= 0;
        end case;

    end process limitCheckVert;


    passThrough: process(out_horiz_count, out_vert_count)
    begin
        out_ascii <= in_ascii;
    end process passThrough;

            

end ticktock;