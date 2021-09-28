-- Author: Howin Tam

-- File Purpose: Takes pixel data input from ASCII_CHARACTER_MAP
-- Takes horizontal/vertical counter and translates it to memory addresses on ram
-- Also detectes/intercepts for specical characters

--Input
-- Sending Command (When send command is sent, only then start reading)
-- Pixel_data_in : std_logic_vector(7 downto 0)
-- Horizontal counter in: integer
-- Vertical counter in: integer

-- Output
-- Memory Address ()
-- Memory Write Request
-- Pixel_data_out 


-- LOOKING INTO AVALON MM INTERFACE, as SDRAM Controller can be done via platform designer
-- Address [21..0]
-- ByteEnable -> each bit corresponds to a byte in writedata and readdata
-- Write(specifies which bytes to write into)/ vice versa fpr reads

--chipselect (Enable Chip)
--write Data(link to pixel data)
--read_n (Unassert to indicate read ( ACTIVE LOW))
--Write ( ^^ simialr to read)
--readdata (Response to Read data transfer?)
--read data valid ( indicates that read data signal contains valid data)
--wait request (indicates the sdram is doing something)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_add_conv is 
    port(
        --input
        in_send:        in    std_logic;
        in_pixel_data:  in    std_logic_vector;
        in_horiz_count: in    integer;
        in_verti_count  in    integer);

        --output (To be decided)
    )
end entity mem_add_conv;

architecture beep of mem_add_conv is 

    --constants go here
begin

    start: process(sending)
        begin
            if(sending = '1') then
                -- when it detects back space character, only move the cursor
                case in_pixel_data is
                    when "10101010" => 

        




