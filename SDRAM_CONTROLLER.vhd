--Author: Howin Tam
--- TOTAL MEMORY THAT WE WILL BE USING
--- 640 X 480 BITS = 307200


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

--MEMORY ADDRESS INPUT
-- 000000000000 00000000

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sdram_controller is
 
    port(
        clk_in:         in      std_logic;
        clk_out:        out     std_logic;        
        -- Reading Data (Wired to Reader)
        read_rq:        in      std_logic;
        read_grant:     out     std_logic;
        read_data:      out     std_logic_vector(7 downto 0);
        read_address:   in      std_logic_vector(29 downto 0);
        
        --Write Data ( Wired to Position to COunter Module)
        write_rq:       in     std_logic;
        write_grant:    out    std_logic;
        write_data:     in     std_logic_vector(7 downto 0));
        write_address:  in     std_logic_vector(29 downto 0);


        --SDRAM Control
        --Select Bank
        bank_addr0:     out    std_logic_vector(0 to 1):='00';
        -- Address
        addr_bus:       out    std_logic_vector(0 to 11);
        clk_en:         out    std_logic;
        
        row_sel:        out    std_logic;
        col_sel:        out    std_logic;
        write_en:       out    std_logic;
        chip_sel:       out    std_logic;

        data_inout:    inout std_logic(15 down to 0);
    end sdram_controller;

architecture arch of sdram_controller is 
    -- writing/reading flags
    signal read_true:         std_logic:= '0';
    signal write_true:        std_logic:= '0';
    signal read_done:         std_logic:= '0';
    signal write_done:        std_logic:= '0';
    signal mem_col_read:      std_logic:= '0';
    signal mem_col_write:      std_logic:= '0';

    signal reset:             std_logic:= '0';
    alias  row_addr:      std_logic_vector is addr_bus(19 downto 8) 
    alias  column_addr:   std_logic_vector is addr_bus(7 downto 0)
    begin

        --Start SDRAM Controller in Idle Mode
        -- Here the SDRAM Controller is waiting for a read/write request
        -- Read requests take priority, but will wait if a write request is in progress
        -- System will have to use rising clock ( based on SDRAM CHIP)

        --!!! THERE MAYBE TIMING ERRORS IF READING HAS TO WAIT FOR WRITING TO FINISH
-----------------------------------------------------------------------------

        -- synchronises the clock with the SDRAM Controller
        clk_passthrough : process(clk_in)
        begin
            if(clk_in'event and clk_in = '1') then
                clk_out <= not clk_out;
        end process clk_passthrough;
-----------------------------------------------------------------------------
        idle: process(clk_in)
        begin  
            if(clk_in'event and clk_in = '1') then
                -- check if read request or write request has been flagged (read priority)
                -- Resets value once it identifies that the system is done reading/writing
                if (read_done or write_done = '1') then
                    read_grant <= '0';
                    write_grant<= '0';
                    reset <= '1';
                else
                    --- possible that write will never be executed because read is priority
                    reset <= '0';
                    
                    if (read_grant or write_grant = '1') then
                        null;
                    else 
                        case read_rq is
                            when '1' => 
                                read_grant <= '1';
                            when others => null;            
                        end case;

                        if(read_true = '0') then
                            case write_rq is 
                                when '1' => 
                                    write_grant <= '1';
                                when others => null;
                            end case;
                        end if;
                    end if;
        end process idle;
-----------------------------------------------------------------------------
        
        memory_select_row: process(read_grant,write_grant)
        begin
            --only starts if at least one of the values is true
            if(read_grant or write_grant = '1') then
                -- get bank location, row address, write to SDRAM
                ---converting Memory address to row address
                addr_bus <= row_addr;
                row_sel <= 1;

                if(read_grant = '1') then
                    mem_col_read <= not mem_col_read;
                else
                    mem_col_write <= not mem_col_write;
                end if;
                
            end if;

        end process memory_select_row;
-----------------------------------------------------------------------------
        memory_select_column: process(mem_col_read, mem_col_write,reset)
        begin
            if (reset ='1') then
                read_true <= '0';
                write_true <= '0';
                write_en <= '0';
            else
                row_sel <= '0';
                write_en <= '0';
                col_sel <= '1'
                if(mem_col_read) then
                    read_true <= '1';
                elsif (mem_cool_write) then
                    write_en <= '1';
                    write_true <= '1';
                end if;
                ---- resets to known state before only sending column info
                addr_bus <= '000000000000'
                addr_bus(7 downto 0) <= column_addr;
            end if;
        end process memory_select_column;
-----------------------------------------------------------------------------
        -- starts as long as read_true is changed
        read : process(read_true, reset)
        begin
            if (reset = '1') then
                read_done <= '0';
                read_data <= '00000000'
            else
                read_data <= data_inout


            end if;
        end process read;
-----------------------------------------------------------------------------

        -- starts as long as read_true is changed
        write: process(write_true,reset)
        begin
            if(reset ='1') then
                
                write_done <= '0';
            else

            end if;


        end process write;
-----------------------------------------------------------------------------
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


