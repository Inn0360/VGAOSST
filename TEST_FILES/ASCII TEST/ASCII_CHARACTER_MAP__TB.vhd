----- CHECKS TO SEE IF THE ASCII CHARACTER MAP FILE CORRECTLY OUTPUTS
-- ASCII PIXEL DATA

-- Author: Howin Tam

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ascii_tb is 

    port(
        pixel_line_data:  out    std_logic_vector(7 downto 0);
        sending: out std_logic);
    
end entity ascii_tb;

architecture bench of ascii_tb is
    
    signal clk       : std_logic := '1';
    signal bit_in    : integer   := 0  ; 

    component bit_to_ascii
         port(
            clk:         in    std_logic; 
            bit_in:      in    integer; -- binary bit of ascii in
                                                   -- smallest input: 0x00 (00000000) 
                                                   -- largest input: 0xFF (11111111)
            --write_ready: in    std_logic;    2      -- !!THIS NEEDS TO BE ADDED
            pixel_line_data:  out    std_logic_vector(7 downto 0);
            sending : out  std_logic);
            
    end component;
    
    begin

        dut : bit_to_ascii
            port map(
                clk => clk,
                bit_in => bit_in,
                pixel_line_data => pixel_line_data,
                sending => sending);

        clock :process
            begin
                wait for 1 ns; 
                clk <= not clk;
        end process clock;

        in_integer : process
            begin
                    wait for 36 ns;
                    if(bit_in = 127) then
                        bit_in <= 0;
                    end if; 
             
                    bit_in <= bit_in + 1;
                
        end process in_integer;

end bench;
        


