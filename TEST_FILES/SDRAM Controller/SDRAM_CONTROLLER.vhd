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
-- General Information:
-- Clock Frequency of Memory is 133Mhz (1 Clock Cycle in 10ns)
-- Clock Frequency of Memory Controller is 3 times slower, 33.25Mhz(1 Clock Cycle is 30ns)


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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sdram_controller is
 
    port(
-------------------------------------------------------------------
        clk_in:         in      std_logic;
        clk_out:        out     std_logic:= '0';        
        -- Reading Data (Wired to Reader)
        read_rq:        in      std_logic;
        read_grant:     out     std_logic:= '0';
        read_data:      out     std_logic_vector(7 downto 0);
        read_address:   in      std_logic_vector(29 downto 0);
        --Write Data ( Wired to Position to Counter Module)
        write_rq:       in     std_logic;
        write_grant:    out    std_logic:= '0';
        write_data:     in     std_logic_vector(7 downto 0);
        write_address:  in     std_logic_vector(29 downto 0);
--------------------------------------------------------------------
        --SDRAM Control
        --Select Bank
        bank_addr0:     out    std_logic_vector(0 to 1) := "00";
        -- Address
        addr_bus:       out    std_logic_vector(11 downto 0);
        clk_en:         out    std_logic:= '1';
        dqmk:           out    std_logic:= '0';
        --Inverted Signals
        row_sel:        out    std_logic:= '1';
        col_sel:        out    std_logic:= '1';
        write_en:       out    std_logic:= '1';
        chip_sel:       out    std_logic:= '1';
        -- Data Bus
        data_inout:    inout std_logic_vector(15 downto 0));
    end sdram_controller;

architecture arch of sdram_controller is 
    -- writing/reading flags
    signal current_state:      integer:= 0;
    signal initialisation:    integer:= '1';
    signal boot_up:            std_logic:= '0';
    signal idle_trigger:       std_logic:= '0';

    signal read_true:         std_logic:= '0';
    signal write_true:        std_logic:= '0';

    signal row_done:          std_logic:= '0';


    signal read_done:         std_logic:= '0';
    signal write_done:        std_logic:= '0';
    signal mem_col_read:      std_logic:= '0';
    signal mem_col_write:     std_logic:= '0';

    signal reset:             std_logic:= '0';
    alias  row_addr:      std_logic_vector is addr_bus(19 downto 8); 
    alias  column_addr:   std_logic_vector is addr_bus(7 downto 0);
    begin
        -- Only runs at boot up
        initialise: process(bootup)
        variable clock_delay:   integer:= 0;
        begin
            if(clk_in'event and clk_in = '1') then
                if(clock_delay > 0) then
                    clock_delay:= Clock_Delay - 1;
                    chip_sel <= '1'; -- Disables all inputs as the memory is processing the commands
                else
                    case initialisation is
                        when 1 =>
                            --Precharge (2 Clock Cycles)
                            chip_sel <= '0';
                            row_sel  <='0';
                            --CAS = High
                            write_en <= '0';
                            --DQM Doesnt matter
                            addr_bus(9) <= '1'; -- A10
                            initialisation <= 2;
                            clock_delay := 2;
                        when 2 =>
                            --Auto Refresh (3 Clock Cycles + 1)
                            write_en <= '1';
                            clock_delay := 4;
                            intialisation <= 3;
                        when 3 =>
                            --Auto Refresh (3 Clock Cycles)
                            clock_delay := 3;
                            intialisation <= 4;
                        when 4 =>
                            -- Program Mode Register(2 Clock Cycles + 1)
                            bank_addr <= "00";
                            addr_bus <= "001000110000";
                            clock_delay := 2;
                            initialisation <= 5;
                        when others =>
                            null;
                    end case;
                end if;
            end if;
        end process initialise;

        --Main Process is here
        default : process(clk_in)

        variable refresh_cycles_left:  integer:= 0;
        variable write_accept:        std_logic:= '0';
        variable read_accept:         std_logic:= '0';
        variable lock:                std_logic:= '1';
        begin
            if(clk_in'event and clk_in = '1') then
                case current_state is 
                    when 0 =>
                        if(initialisation < 5) then
                            boot_up <= not boot_up;
                        else
                            current_state <= 1;
                        end if;
                    when 1 => -- Idle State
                            -- THIS LOGIC HERE MAY NOT BE RIGHT, BUT WILL BE PLACED HERE FOR NOW
                        if(read_rq = '1') then
                               -- Go to Row State here
                                read_accept:= '1';
                                read_true <= '1';
                        elsif(write_rq = '1') then
                                write_accept::= '1';
                                write_true <= '1';
                        end if;
                        
                        if(refresh_cycles_left = 0) then
                            --- If the Self Refresh Command has finished, allow it to send other commands.
                            if(read_accept = '1') then
                                -- Go to Row State here
                                current_state <= 2;
                            elsif(write_accept = '1') then
                                current_state <= 2;
                            else
                            -- Self Refresh
                                chip_sel <= '0';
                                row_sel <= '0';
                                col_sel <= '0';
                                write_en <= '1';
                                refresh_cycles_left := 3;
                            end if;
                        else
                            refresh_cycles_left:= refresh_cycles_left - 1;
                        end if;
                        -- go to Idle State here
                    when 2 => -- Row State
                            -- Go to Row State (REQUIRES ONE CLOCK CYCLE)
                        if(lock = '0') then
                            if (read_accept = '1') then
                                read_true <= not read_true;
                            elsif (write_true = '1') then
                                write_true <= not write_true;
                            -- trigger lock to stop this running all the time
                                lock:= '1';
                            end if;
                        elsif (lock = '1') then
                            if(row_done = '1') then
                                current_state <= 3;
                                lock:= '0';
                            else
                                null;
                            end if;
                        end if;


                    when 3 => -- Column State
                        -- could be done consecutively after row
                end case;
            -- First Checks for Initialisation
            -- Then goes to Idle state
            -- If request is triggered, then go to Row State, where it then goes to column state
            -- Once column state has been triggered
            -- Go to read/write state
            -- then 
            end if;
        end process default;
                
        --Start SDRAM Controller in Idle Mode
        -- Here the SDRAM Controller is waiting for a read/write request
        -- Read requests take priority, but will wait if a write request is in progress
        -- System will have to use rising clock ( based on SDRAM CHIP)

        --!!! THERE MAYBE TIMING ERRORS IF READING HAS TO WAIT FOR WRITING TO FINISH
-----------------------------------------------------------------------------
        -- passthrough the clock with the SDRAM 
        clk_passthrough : process(clk_in)
        begin
            if(clk_in'event and clk_in = '1') then
                clk_out <= not clk_out;
            end if;
        end process clk_passthrough;
-----------------------------------------------------------------------------
        memory_select_row: process(read_true,write_true)
        begin
            --only starts if at least one of the values is true
            if(read_true or write_true = '1') then --This logic doesnt work -> ! need to find another way of doing this
                ---converting Memory address to row address
                addr_bus <= row_addr;
                row_sel <= 1;

                if(read_true = '1') then
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
                read_data <= '00000000';
            else
                read_data <= data_inout;


            end if;
        end process read;
-----------------------------------------------------------------------------

        -- starts as long as read_true is changed
        write: process(write_true,reset)
        begin
            if(reset ='1') then
                
                write_done <= '0';
            else
                write_data <= data_inout;
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

end arch;

 --idle: process(idle_trigger)
 --       begin  
 --           if(clk_in'event and clk_in = '1') then
--
--
 --               -- check if read request or write request has been flagged (read priority)
 --               -- Resets value once it identifies that the system is done reading/writing
 --               if (read_done or write_done = '1') then
 --                   read_grant <= '0';
 --                   write_grant<= '0';
 --                   reset <= '1';
 --               else
 --                   --- possible that write will never be executed because read is priority
 --                   reset <= '0';
 --                   
 --                   if (read_grant or write_grant = '1') then
 --                       null;
 --                   else 
 --                       case read_rq is
 --                           when '1' => 
 --                               read_grant <= '1';
 --                           when others => null;            
 --                       end case;
--
 --                       if(read_true = '0') then
 --                           case write_rq is 
 --                               when '1' => 
 --                                   write_grant <= '1';
 --                               when others => null;
 --                           end case;
 --                       end if;
 --                   end if;
 --               end if;
 --           end if;
 --       end process idle;