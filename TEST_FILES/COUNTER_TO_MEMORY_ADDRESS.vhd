-- Author: Howin Tam

-- File Purpose: Takes pixel data input from ASCII_CHARACTER_MAP
-- Takes horizontal/vertical counter and translates it to memory addresses on ram
-- Also detectes/intercepts for specical characters

--Input
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



    )




