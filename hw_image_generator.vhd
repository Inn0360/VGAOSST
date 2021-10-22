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

ENTITY hw_image_generator IS
  PORT(
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
    red      :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS
BEGIN
  PROCESS(disp_ena, row, column)
  BEGIn
    IF(disp_ena = '1') THEN        --display time

      if (row = 0) then 
   --"00000000", -- 0

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 1) then
   --"00000000", -- 1

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 2 and 0 <= column and column < 7) then
   --"11111110", -- 2 *******
        green <= (others => '1');
      elsif((row = 3 and 1 <= column and column < 3) or (row = 3 and column > 4 and column< 7)) then
   --"01100110", -- 3  **  **
        green <= (others => '1');
      elsif((row = 4 and 1 <= column and column < 3) or (row = 4 and column > 5 and column< 7)) then
   --"01100010", -- 4  **   *
        green <= (others => '1');
      elsif((row = 5 and 1 <= column and column < 3) or (row = 5 and column = 4)) then
        green <= (others => '1');
   --"01101000", -- 5  ** *
      elsif(row = 6 and 1 <= column and column < 5) then
   --"01111000", -- 6  ****
        green <= (others => '1');
    elsif((row = 7 and 1 <= column and column < 3) or (row = 7 and column = 4)) then
   --"01101000", -- 7  ** *
        green <= (others => '1');
    elsif(row = 8 and 1 <= column and column < 3) then
        green <= (others => '1');
   --"01100000", -- 8  **
    elsif((row = 9 and 1 <= column and column < 3) or (row = 9 and column > 5 and column< 7)) then
        green <= (others => '1');
   --"01100010", -- 9  **   *
    elsif((row = 10 and 1 <= column and column < 3) or (row = 10 and column > 4 and column< 7)) then
   --"01100110", -- a  **  **
        green <= (others => '1');
    elsif(row = 11 and 0 <= column and column < 7) then
        green <= (others => '1');
        
   --"11111110", -- b *******
  


      elsif(row = 2 and 14 <= column and column < 21) then
   --"11111110", -- 2 *******
        green <= (others => '1');
      elsif((row = 3 and 15 <= column and column < 17) or (row = 3 and column > 18 and column< 21)) then
   --"01100110", -- 3  **  **
        green <= (others => '1');
      elsif((row = 4 and 15 <= column and column < 17) or (row = 4 and column > 19 and column< 21)) then
   --"01100010", -- 4  **   *
        green <= (others => '1');
      elsif((row = 5 and 15 <= column and column < 17) or (row = 5 and column = 18)) then
        green <= (others => '1');
   --"01101000", -- 5  ** *
      elsif(row = 6 and 15 <= column and column < 19) then
   --"01111000", -- 6  ****
        green <= (others => '1');
    elsif((row = 7 and 15 <= column and column < 17) or (row = 7 and column = 18)) then
   --"01101000", -- 7  ** *
        green <= (others => '1');
    elsif(row = 8 and 15 <= column and column < 17) then
        green <= (others => '1');
   --"01100000", -- 8  **
    elsif((row = 9 and 15 <= column and column < 17) or (row = 9 and column > 19 and column< 21)) then
        green <= (others => '1');
   --"01100010", -- 9  **   *
    elsif((row = 10 and 15 <= column and column < 17) or (row = 10 and column > 18 and column< 21)) then
   --"01100110", -- a  **  **
        green <= (others => '1');
    elsif(row = 11 and 14 <= column and column < 21) then
        green <= (others => '1');
    
    elsif (row = 16) then 
   --"00000000", -- 0

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 17) then
   --"00000000", -- 1

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 18 and 0 <= column and column < 7) then
   --"11111110", -- 2 *******
        green <= (others => '1');
      elsif((row = 19 and 1 <= column and column < 3) or (row = 19 and column > 4 and column< 7)) then
   --"01100110", -- 3  **  **
        green <= (others => '1');
      elsif((row = 20 and 1 <= column and column < 3) or (row = 20 and column > 5 and column< 7)) then
   --"01100010", -- 4  **   *
        green <= (others => '1');
      elsif((row = 21 and 1 <= column and column < 3) or (row = 21 and column = 4)) then
        green <= (others => '1');
   --"01101000", -- 5  ** *
      elsif(row = 22 and 1 <= column and column < 5) then
   --"01111000", -- 6  ****
        green <= (others => '1');
    elsif((row = 23 and 1 <= column and column < 3) or (row = 23 and column = 4)) then
   --"01101000", -- 7  ** *
        green <= (others => '1');
    elsif(row = 24 and 1 <= column and column < 3) then
        green <= (others => '1');
   --"01100000", -- 8  **
    elsif((row = 25 and 1 <= column and column < 3) or (row = 25 and column > 5 and column< 7)) then
        green <= (others => '1');
   --"01100010", -- 9  **   *
    elsif((row = 26 and 1 <= column and column < 3) or (row = 26 and column > 4 and column< 7)) then
   --"01100110", -- a  **  **
        green <= (others => '1');
    elsif(row = 27 and 0 <= column and column < 7) then
        green <= (others => '1');
        
   --"11111110", -- b *******

    elsif (row = 48) then 
   --"00000000", -- 0

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 49) then
   --"00000000", -- 1

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 50 and 0 <= column and column < 7) then
   --"11111110", -- 2 *******
        green <= (others => '1');
      elsif((row = 51 and 1 <= column and column < 3) or (row = 51 and column > 4 and column< 7)) then
   --"01100110", -- 3  **  **
        green <= (others => '1');
      elsif((row = 52 and 1 <= column and column < 3) or (row = 52 and column > 5 and column< 7)) then
   --"01100010", -- 4  **   *
        green <= (others => '1');
      elsif((row = 53 and 1 <= column and column < 3) or (row = 53 and column = 4)) then
        green <= (others => '1');
   --"01101000", -- 5  ** *
      elsif(row = 54 and 1 <= column and column < 5) then
   --"01111000", -- 6  ****
        green <= (others => '1');
    elsif((row = 55 and 1 <= column and column < 3) or (row = 55 and column = 4)) then
   --"01101000", -- 7  ** *
        green <= (others => '1');
    elsif(row = 56 and 1 <= column and column < 3) then
        green <= (others => '1');
   --"01100000", -- 8  **
    elsif((row = 57 and 1 <= column and column < 3) or (row = 57 and column > 5 and column< 7)) then
        green <= (others => '1');
   --"01100010", -- 9  **   *
    elsif((row = 58 and 1 <= column and column < 3) or (row = 58 and column > 4 and column< 7)) then
   --"01100110", -- a  **  **
        green <= (others => '1');
    elsif(row = 59 and 0 <= column and column < 7) then
        green <= (others => '1');
    
    elsif (row = 80) then 
   --"00000000", -- 0

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 81) then
   --"00000000", -- 1

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 82 and 0 <= column and column < 7) then
   --"11111110", -- 2 *******
        green <= (others => '1');
      elsif((row = 83 and 1 <= column and column < 3) or (row = 83 and column > 4 and column< 7)) then
   --"01100110", -- 3  **  **
        green <= (others => '1');
      elsif((row = 84 and 1 <= column and column < 3) or (row = 84 and column > 5 and column< 7)) then
   --"01100010", -- 4  **   *
        green <= (others => '1');
      elsif((row = 85 and 1 <= column and column < 3) or (row = 85 and column = 4)) then
        green <= (others => '1');
   --"01101000", -- 5  ** *
      elsif(row = 86 and 1 <= column and column < 5) then
   --"01111000", -- 6  ****
        green <= (others => '1');
    elsif((row = 87 and 1 <= column and column < 3) or (row = 87 and column = 4)) then
   --"01101000", -- 7  ** *
        green <= (others => '1');
    elsif(row = 88 and 1 <= column and column < 3) then
        green <= (others => '1');
   --"01100000", -- 8  **
    elsif((row = 89 and 1 <= column and column < 3) or (row = 89 and column > 5 and column< 7)) then
        green <= (others => '1');
   --"01100010", -- 9  **   *
    elsif((row = 90 and 1 <= column and column < 3) or (row = 90 and column > 4 and column< 7)) then
   --"01100110", -- a  **  **
        green <= (others => '1');
    elsif(row = 91 and 0 <= column and column < 7) then
        green <= (others => '1');

    elsif (row = 112) then 
   --"00000000", -- 0

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 123) then
   --"00000000", -- 1

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 124 and 0 <= column and column < 7) then
   --"11111110", -- 2 *******
        green <= (others => '1');
      elsif((row = 125 and 1 <= column and column < 3) or (row = 125 and column > 4 and column< 7)) then
   --"01100110", -- 3  **  **
        green <= (others => '1');
      elsif((row = 126 and 1 <= column and column < 3) or (row = 126 and column > 5 and column< 7)) then
   --"01100010", -- 4  **   *
        green <= (others => '1');
      elsif((row = 127 and 1 <= column and column < 3) or (row = 127 and column = 4)) then
        green <= (others => '1');
   --"01101000", -- 5  ** *
      elsif(row = 128 and 1 <= column and column < 5) then
   --"01111000", -- 6  ****
        green <= (others => '1');
    elsif((row = 129 and 1 <= column and column < 3) or (row = 129 and column = 4)) then
   --"01101000", -- 7  ** *
        green <= (others => '1');
    elsif(row = 130 and 1 <= column and column < 3) then
        green <= (others => '1');
   --"01100000", -- 8  **
    elsif((row = 131 and 1 <= column and column < 3) or (row = 131 and column > 5 and column< 7)) then
        green <= (others => '1');
   --"01100010", -- 9  **   *
    elsif((row = 132 and 1 <= column and column < 3) or (row = 132 and column > 4 and column< 7)) then
   --"01100110", -- a  **  **
        green <= (others => '1');
    elsif(row = 133 and 0 <= column and column < 7) then
        green <= (others => '1');


    elsif (row = 165) then 
   --"00000000", -- 0

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 167) then
   --"00000000", -- 1

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 168 and 0 <= column and column < 7) then
   --"11111110", -- 2 *******
        green <= (others => '1');
      elsif((row = 169 and 1 <= column and column < 3) or (row = 169 and column > 4 and column< 7)) then
   --"01100110", -- 3  **  **
        green <= (others => '1');
      elsif((row = 170 and 1 <= column and column < 3) or (row = 170 and column > 5 and column< 7)) then
   --"01100010", -- 4  **   *
        green <= (others => '1');
      elsif((row = 171 and 1 <= column and column < 3) or (row = 171 and column = 4)) then
        green <= (others => '1');
   --"01101000", -- 5  ** *
      elsif(row = 172 and 1 <= column and column < 5) then
   --"01111000", -- 6  ****
        green <= (others => '1');
    elsif((row = 173 and 1 <= column and column < 3) or (row = 173 and column = 4)) then
   --"01101000", -- 7  ** *
        green <= (others => '1');
    elsif(row = 174 and 1 <= column and column < 3) then
        green <= (others => '1');
   --"01100000", -- 8  **
    elsif((row = 175 and 1 <= column and column < 3) or (row = 175 and column > 5 and column< 7)) then
        green <= (others => '1');
   --"01100010", -- 9  **   *
    elsif((row = 176 and 1 <= column and column < 3) or (row = 176 and column > 4 and column< 7)) then
   --"01100110", -- a  **  **
        green <= (others => '1');
    elsif(row = 177 and 0 <= column and column < 7) then
        green <= (others => '1');

      

        
      ELSE
        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');
      END IF;
    ELSE                           --blanking time
      red <= (OTHERS => '0');
      green <= (OTHERS => '0');
      blue <= (OTHERS => '0');
    END IF;
  
  END PROCESS;
END behavior;
