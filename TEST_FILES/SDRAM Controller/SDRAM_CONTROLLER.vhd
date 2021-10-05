--Author: Howin Tam

-- File Purpose: SDRAM Controller for Cyclone IV OMDAZZ Board
-- Chip: HY57V641620F(L/S)TP
-- Allows for requests, and then that is just given back
-- will need to passthrough its inputs/outputs
-- input
-- Write Request 
-- Write Address
-- Write Data (8bits)
--
--output 
--
-- Read Data
--  Write Grant
--  Read Grant
-- Allows for Write and Read Requests, accept and send data
-- Focuses on write requests before read requests

-- Accessing RAM
-- Select Bank, Select Row, then Select which Column


-- One address can save 16 bits
-- each character takes 8 addresses ()???? o dont think thats right

-- Process
-- Idle (Maybe sending Refresh command here)
-- Select Row/Bank
-- Select Column
-- Write/Read
-- Close Row

--(Need to think where I need to be refreshing)



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity sdram_controller is
    generic(
        data_line:     std_logic_vector(15 downto 0);
    )

    port(
        clk_in:         in      std_logic;
        -- Reading Data
        read_rq:        in      std_logic;
        read_grant:     out     std_logic;
        read_data:      out     std_logic_vector(7 downto 0);
        read_address:   in      std_logic(8 downto 0);
        
        --Write Data
        write_rq:       in     std_logic;
        write_grant:    out    std_logic;
        write_address:  in     std_logic;
        write_data:     in     std_logic_vector(7 downto 0));

        --SDRAM Control
        --Select Bank
        bank_addr0:     out    std_logic_vector(0 to 1);
        -- Address
        addr_bus:       out    std_logic_vector(0 to 11);;
        
        --Row, Column, Write Select
        --chip select
        -- THESE PINS ARE INVERTED

        row_sel:        out    std_logic;
        col_sel:        out    std_logic;
        write_en:       out    std_logic;
        chip_sel:       out    std_logic;


    end sdram_controller;

architecture arch of sdram_controller is 
    signal write_request: std_logic;


    begin
        --Initalise SDRAM Chip
        
        bank_addr0 <= "00";
        addr_bus <= "001000100011"
        

        --State Machine to check whether requests are present
        if(clk_in'event and clk_in = '1') then
            if(write_rq ='1' or read_rq = '1') then
                write_request <= '1';
                -- set bank address
                bank_addr0 <= "00";
                chip_sel <= '0';
                row_sel  <= '0';
                col_sel  <- '1';
                write_en <= '1';
                --I NEED TO GIVE ROW DATA HERE
                addr_bus <= "000000000000"

            if( write_rq = '1') then
                write_request <= '1;
                bank_addr0 <= "00";
                chip_sel <= '0';
                row_sel  <= '1';
                col_sel  <- '0';
                write_en <= '0';
                -- I NEED TO GIVE COLUMN DATA HERE
                addr_bus <= "000000000000"

            end if;



            end if;

            --set sdram to write
            
            

            




        -- Force read request to wait


        --State Machine
            --Idle _> Checking for any active requests
            --> Checks for write requests first, then read requests


    -- actual things go here

end arch;