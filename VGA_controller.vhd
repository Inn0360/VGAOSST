----
-- VGA Controller specifically for timing
--
--
--Steps to get VGA to work
-- 1. Timing for all sections to be right
-- 2. Outputs to track where it is up to
-- 3. outputs for display enable,

---------------

library ieee;
use ieee.std_logic_1164.all;

entity vga_timing is -- Entity declares outputs/inputs
    generic(                -- generic statement, not input/output
        -- values for horizontal timing
        horizontal_pixels      : integer := 640  ;-- Display Pixels
        horizontal_fporch      : integer := 16   ;-- Front Porch Pixels
        horizontal_bporch      : integer := 48   ;-- Back Porch Pixels
        horizontal_sync        : integer := 96   ;-- Sync  Pixels
        horizontal_sync_pol    : std_logic := '0';-- std_logic is a logic type variable
                                                 -- sets default value of sync polarity to be 0/ negative

        vertical_pixels        : integer := 480  ; -- Vertical Display Pixels
        vertical_fporch        : integer := 10   ; -- Front porch pixels
        vertical_bporch        : integer := 33   ; -- back porch         
        vertical_sync          : integer := 2    ; -- sync pulse
        vertical_sync_pol      : std_logic := '0'); -- sync polarity set to 0
    
    port(                       -- defines the ins and outs for the module
        -- inputs( clock in, reset pulse)
        pixel_clock_in     : in     std_logic; -- pixel clock input. in this case (25.17mhz)
        reset_pulse        : in     std_logic; -- active low asycnhronous reset
        horizontal_sync_out: out    std_logic; -- Signal outputs high for H Sync Pulse
        horizontal_coord   : out    integer; -- signa out with horizontal pixel coord
        vertical_sync_out  : out    std_logic; -- signal output high for V sync pulse
        vertical_coord     : out    integer; -- signal out of vertical coord
        display_on         : out    std_logic; -- "1" for display on, "0" for blanking stage
        blank              : out    std_logic; -- blanking to DAC
        sync               : out    std_logic); -- sync output to DAC
end vga_timing;

-- architecture contains the actual logical code
-- also contains the interconnects, CONSTANTS, or other components referenced
architecture display_size of vga_timing is
    constant horiz_timing   : integer := horizontal_pixels + horizontal_fporch + horizontal_bporch +horizontal_sync;
    constant verti_timing   : integer := vertical_pixels + vertical_fporch + vertical_bporch + vertical_sync;
begin
    -- NEED TO CHECK WHAT THESE THINGS DO
    blank <= '1'; -- sets the blanking signal to 1. This sets the DAV t oaccept signals
    sync <= '0'; --  on DAC, means that there is no sync signal on G line

    -- if the reset pin has been set, reset the counter/pixel coordin to 0,0
    
-- once the display has finished, set values for blanking period

--CHECK RESET PIN TRUE
    -- process statements allow for sequential computation

    -- Intial Starting Process to reset integer to a known state
    -- if the variable for both is somewhere in the middle of the screen, reset to 0
    process(pixel_clock_in, reset_pulse) 
        variable hcounter : integer RANGE 0 to horiz_timing - 1 := 0;
        variable vcounter : integer RANGE 0 to verti_timing - 1 := 0;
        
    begin

        if(reset_pulse = '0') THEN -- if reset pin has been set
            hcounter := 0;
            horizontal_coord <= 0;
            vcounter := 0;
            vertical_coord <= 0;
            display_on <= '0';
            horizontal_sync_out <= not horizontal_sync_pol;
            vertical_sync_out <= not vertical_sync_pol;

            -- everytime it is a rising clock
        elsif (pixel_clock_in'EVENT AND pixel_clock_in = '1') THEN-- defines a positive clock edge 

            --Horizontal Counters
            -- if the counter is anywhere but 0
            if(hcounter < horiz_timing - 1) THEN
                hcounter := hcounter + 1;
            else -- once the horizontal line has reached the end of the screen
                hcounter := 0;
                if (vcounter < verti_timing - 1) then -- for vertical changes
                    vcounter := vcounter +1;
                else
                    vcounter := 0;
                end if;
            end if;

            --horizontal sync signal
            if (hcounter < horizontal_pixels + horizontal_fporch or hcounter >= horizontal_pixels + horizontal_fporch + horizontal_sync) then
                horizontal_sync_out <= not horizontal_sync_pol ; -- disassert horizontal sync pulse
            else
                horizontal_sync_out <= horizontal_sync_pol ;

            end if;
            -- vertical sync

            if (vcounter < vertical_pixels + vertical_fporch or vcounter >= vertical_pixels + vertical_fporch + vertical_sync) then
                vertical_sync_out <= not vertical_sync_pol; -- disassert vertical sync pulse
            else
                vertical_sync_out <= vertical_sync_pol;

            end if;

            -- set pixel coordinates

            if (hcounter < horizontal_pixels) then
                horizontal_coord <= hcounter ; -- saves the current horizontal value to integer output
            end if;

            if (vcounter < vertical_pixels) then
                vertical_coord <= vcounter;
            end if;

            --set blanking on/off

            if(hcounter < horizontal_pixels and vcounter < vertical_pixels) then
                display_on <= '1';
            else
                display_on <= '0';
            end if;
        end if;
    end process;

    end display_size;

        