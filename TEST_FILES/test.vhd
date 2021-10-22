--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------



	 --"00000000", -- 0
   --"00000000", -- 1
   --"11111110", -- 2 *******
   --"01100110", -- 3  **  **
   --"01100010", -- 4  **   *
   --"01101000", -- 5  ** *
   --"01111000", -- 6  ****
   --"01101000", -- 7  ** *
   --"01100000", -- 8  **
   --"01100010", -- 9  **   *
   --"01100110", -- a  **  **
   --"11111110", -- b *******
   --"00000000", -- c
   --"00000000", -- d
   --"00000000", -- e
   --"00000000", -- f
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY test IS
  PORT(
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
    red      :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
END test;

ARCHITECTURE behavior OF test IS
BEGIN
  PROCESS(disp_ena, row, column)
  BEGIn
    IF(disp_ena = '1') THEN        --display time
        case row is
            when 16  =>
                green <= (others => '1');
            when 32  =>
                green <= (others => '1');
            when 48  =>
                green <= (others => '1');
            when 64  =>
                green <= (others => '1');
            when 80  =>
                green <= (others => '1');
            when 96  =>
                green <= (others => '1');
            when 112 =>
                green <= (others => '1');
            when 128 =>
                green <= (others => '1');
            when 144 =>
                green <= (others => '1');
            when 160 =>
                green <= (others => '1');
            when 176 =>
                green <= (others => '1');
            when 192 =>
                green <= (others => '1');
            when 208 =>
                green <= (others => '1');
            when 224 =>
                green <= (others => '1');
            when 240 =>
                green <= (others => '1');
            when 256 =>
                green <= (others => '1');
            when 272 =>
                green <= (others => '1');
            when 288 =>
                green <= (others => '1');
            when 304 =>
                green <= (others => '1');
            when 320 =>
                green <= (others => '1');
            when 336 =>
                green <= (others => '1');
            when 352 =>
                green <= (others => '1');
            when 368 =>
                green <= (others => '1');
            when 384 =>
                green <= (others => '1');
            when 400 =>
                green <= (others => '1');
            when 416 =>
                green <= (others => '1');
            when 432 =>
                green <= (others => '1');
            when 448 =>
                green <= (others => '1');
            when 464 =>
                green <= (others => '1');
            when 480 =>
                green <= (others => '1');
            when others =>
                green <= (others => '0');
        end case;
       

    ELSE                           --blanking time
      red <= (OTHERS => '0');
      green <= (OTHERS => '0');
      blue <= (OTHERS => '0');
    END IF;
  
  END PROCESS;
END behavior;
