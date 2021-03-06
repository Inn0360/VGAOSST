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

ENTITY test2 IS
  PORT(
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
    red      :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
END test2;

ARCHITECTURE behv OF test2 IS
BEGIN
  PROCESS(disp_ena, row, column)
  BEGIn
  -- OSST WAS HERE  >_<
    IF(disp_ena = '1') THEN        --display time
-------------------------------------------------------------------------------------------------------------------------
--O-

      if (row = 120) then 
   --"00000000", -- 0
        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 121) then
   --"00000000", -- 1

        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');

      elsif(row = 122 and 256 < column and column < 262) then
   --   "01111100", -- 2  *****

        green <= (others => '1');
      elsif((row = 123 and 256 <= column and column < 258) or (row = 123 and column > 260 and column< 263)) then
   --"   "11000110", -- 3 **   **
        green <= (others => '1');

      elsif((row = 124 and 256 <= column and column < 258) or (row = 124 and column > 260 and column< 263)) then

      --"   "11000110", -- 4 **   **
        green <= (others => '1');

      elsif((row = 125 and 256 <= column and column < 258) or (row = 125 and column > 260 and column< 263)) then
        green <= (others => '1');
      --"   "11000110", -- 5 **   **

      elsif((row = 126 and 256 <= column and column < 258) or (row = 126 and column > 260 and column< 263)) then

     --"   "11000110", -- 6 **   **
        green <= (others => '1');

      elsif((row = 127 and 256 <= column and column < 258) or (row = 127 and column > 260 and column< 263)) then

      --"   "11000110", -- 7 **   **
        green <= (others => '1');

      elsif((row = 128 and 256 <= column and column < 258) or (row = 128 and column > 260 and column< 263)) then

        green <= (others => '1');
      --"   "11000110", -- 8 **   **

      elsif((row = 129 and 256 <= column and column < 258) or (row = 129 and column > 260 and column< 263)) then
        green <= (others => '1');
      --"   "11000110", -- 9 **   **

      elsif((row = 130 and 256 <= column and column < 258) or (row = 130 and column > 260 and column< 263)) then
      --"   "11000110", -- a **   **

        green <= (others => '1');

      elsif(row = 131 and 256 < column and column < 262) then
        green <= (others => '1');

      --"01111100", -- b  *****
---------------------------------------------------------------------------------------
--S  
-- Column Start -- 264
      elsif(row = 122 and 264 < column and column < 270) then
   --    "01111100", -- 2  *****
        green <= (others => '1');

      elsif((row = 123 and 264 <= column and column < 266) or (row = 123 and column > 268 and column< 271)) then

   --   "11000110", -- 3 **   **
        green <= (others => '1');

      elsif((row = 124 and 264 <= column and column < 266) or (row = 124 and column > 268 and column< 271)) then

      --"   "11000110", -- 4 **   **
        green <= (others => '1');

      elsif(row = 125 and 264 < column and column < 267) then
        --"01100000", -- 5  **
        
        green <= (others => '1');
        
      elsif(row = 126 and 265 < column and column < 269) then

        --"00111000", -- 6   ***
        green <= (others => '1');

      elsif(row = 127 and 267 < column and column < 270) then

        --"00001100", -- 7     **
        green <= (others => '1');

      elsif(row = 128 and 268 < column and column < 271) then
      --   "00000110", -- 8      **
        green <= (others => '1');

      elsif((row = 129 and 264 <= column and column < 266) or (row = 129 and column > 268 and column< 271)) then
       --"11000110", -- 9 **   **
        
        green <= (others => '1');
     
      elsif((row = 130 and 264 <= column and column < 266) or (row = 130 and column > 268 and column< 271)) then
      --"   "11000110", -- a **   **


        green <= (others => '1');

      elsif(row = 131 and 264 < column and column < 270) then
      --"01111100", -- b  *****

        green <= (others => '1');

--------------------------------------------------------------------------------------------------------
--S  
-- Column Start -- 272
      elsif(row = 122 and 272 < column and column < 278) then
   --    "01111100", -- 2  *****
        green <= (others => '1');

      elsif((row = 123 and 272 <= column and column < 274) or (row = 123 and column > 276 and column< 279)) then

   --   "11000110", -- 3 **   **
        green <= (others => '1');

      elsif((row = 124 and 272 <= column and column < 274) or (row = 124 and column > 276 and column< 279)) then

      --"   "11000110", -- 4 **   **
        green <= (others => '1');

      elsif(row = 125 and 272 < column and column < 275) then
        --"01100000", -- 5  **
        green <= (others => '1');
        
      elsif(row = 126 and 273 < column and column < 277) then

        --"00111000", -- 6   ***
        green <= (others => '1');

      elsif(row = 127 and 275 < column and column < 278) then

        --"00001100", -- 7     **
        green <= (others => '1');

      elsif(row = 128 and 276 < column and column < 279) then
      --   "00000110", -- 8      **
        green <= (others => '1');

      elsif((row = 129 and 272 <= column and column < 274) or (row = 129 and column > 276 and column< 279)) then
       --"11000110", -- 9 **   **
        
        green <= (others => '1');
     
      elsif((row = 130 and 272 <= column and column < 274) or (row = 130 and column > 276 and column< 279)) then
      --"   "11000110", -- a **   **


        green <= (others => '1');

      elsif(row = 131 and 272 < column and column < 278) then
      --"01111100", -- b  *****

        green <= (others => '1');
-----------------------------------------------------------------------------------
---- T ----

-- Column Start -- 280
      elsif(row = 122 and 280 <= column and column <= 287) then
   --       "11111111", -- 2 ********
        green <= (others => '1');

      elsif((row = 123 and 280 <= column and column < 282) or (row = 123 and column > 285 and column <= 287) or (row = 123 and column > 282 and column < 285)) then
   --      "11011011", -- 3 ** ** **
        green <= (others => '1');

      elsif((row = 124 and column = 281) or (row = 124 and column = 287) or (row = 124 and column > 282 and column < 285)) then

      --   "10011001", -- 4 *  **  *
        green <= (others => '1');

      elsif(row = 125 and 282 < column and column < 285) then
           --"00011000", -- 5    **

        
        green <= (others => '1');
        
      elsif(row = 126 and 282 < column and column < 285) then

           --"00011000", -- 6    **

        green <= (others => '1');

      elsif(row = 127 and 282 < column and column < 285) then

            --"00011000", -- 7    **

        green <= (others => '1');

      elsif(row = 128 and 282 < column and column < 285) then
                 --"00011000", -- 8    **

        green <= (others => '1');

      elsif(row = 129 and 282 < column and column < 285) then
                  --"00011000", -- 9    **

        green <= (others => '1');
     
      elsif((row = 130 and 282 < column and column < 285)) then
                 --"00011000", -- a    **


        green <= (others => '1');

      elsif(row = 131 and 281 < column and column < 286) then
         --"00111100", -- b   ****


        green <= (others => '1');
--------------------------------------------------------------------------------
--w-
-- Column Start -- 296
 
      elsif((row = 125 and 296 <= column and column < 298) or (row = 125 and 301 < column and column <=303 )) then
           --"11000011", -- 5    **

        green <= (others => '1');
        
      elsif((row = 126 and 296 <= column and column < 298) or (row = 126 and 301 < column and column <= 303)) then

           --"11000011", -- 6    **

        green <= (others => '1');

      elsif((row = 127 and 296 <= column and column < 298) or (row = 127 and 301 < column and column <= 303)) then

            --"11000011", -- 7    **

        green <= (others => '1');

      elsif((row = 128 and 296 <= column and column < 298) or (row = 128 and 301 < column and column <= 303) or (row = 128 and 298 < column and column < 301)) then
                 --"11011011", -- 8    **

        green <= (others => '1');

      elsif((row = 129 and 296 <= column and column < 298) or (row = 129 and 301 < column and column <= 303) or (row = 129 and 298 < column and column < 301)) then
                  --"11011011", -- 9    **

        green <= (others => '1');
     
      elsif((row = 130 and 296 <= column and column <= 303)) then
                 --"11111111", -- a    **
        green <= (others => '1');

      elsif((row = 131 and 296 < column and column < 299) or (row = 131 and 300 < column and column < 303)) then
         --"01100110", -- b   ****
        green <= (others => '1');
--------------------------------------------------------------------------------------------------------------------------------------
--a--
-- Column Start -- 304
 
      elsif(row = 125 and 304 < column and column < 309) then
           --"01111000", -- 5    **

        green <= (others => '1');
        
      elsif(row = 126 and 307 < column and column < 310) then

           --"00001100", -- 6    **

        green <= (others => '1');

      elsif(row = 127 and 304 < column and column < 310) then

            --"01111100", -- 7    **

        green <= (others => '1');

      elsif((row = 128 and 304 <= column and column < 306) or (row = 128 and 307 < column and column < 310)) then
                 --"11001100", -- 8    **

        green <= (others => '1');

      elsif((row = 129 and 304 <= column and column < 306) or (row = 129 and 307 < column and column < 310)) then
                  --"11001100", -- 9    **

        green <= (others => '1');
     
      elsif((row = 130 and 304 <= column and column < 306) or (row = 130 and 307 < column and column < 310)) then
                 --"11001100", -- a    **
        green <= (others => '1');

      elsif((row = 131 and 304 < column and column < 308) or (row = 131 and 309 < column and column < 311)) then
         --"01110110", -- b   ****
        green <= (others => '1');

-----------------------------------------------------------------------------------------------------------------------------------
--s--
--column start 312

     elsif(row = 122 and 312 <= column and column <= 319) then
   --       "00000000", -- 2 ********
        green <= (others => '0');

      elsif(row = 123 and 312 <= column and column <= 319) then
   --      "00000000", -- 3 ** ** **
        green <= (others => '0');

      elsif(row = 124 and 312 <= column and column <= 319) then

      --   "00000000", -- 4 *  **  *
        green <= (others => '0');

      elsif(row = 125 and 312 < column and column < 318) then
           --"01111100", -- 5    **

        green <= (others => '1');
        
      elsif((row = 126 and 312 <= column and column < 314) or (row = 126 and 316 < column and column < 318 )) then
           --"11000110", -- 6    **

        green <= (others => '1');

      elsif(row = 127 and 312 < column and column < 315) then

            --"01100000", -- 7    **

        green <= (others => '1');

      elsif(row = 128 and 313 < column and column < 317) then
                 --"00111000", -- 8    **

        green <= (others => '1');

      elsif(row = 129 and 315 < column and column < 318) then
                  --"00001100", -- 9    **

        green <= (others => '1');
     
      elsif((row = 130 and 312 <= column and column < 314) or (row = 130 and 316 < column and column < 319)) then
                 --"11000110", -- a    **
        green <= (others => '1');

      elsif(row = 131 and 312 < column and column < 317) then
         --"01111100", -- b   ****
        green <= (others => '1');
--------------------------------------------------------------------------------------------------------------------------
--column start 328
-- h--
     elsif(row = 122 and 328 <= column and column < 331) then
   --       "11100000", -- 2 ********
        green <= (others => '1');

      elsif(row = 123 and 328 < column and column < 331) then
   --      "01100000", -- 3 ** ** **
        green <= (others => '1');

      elsif(row = 124 and 328 < column and column < 331) then

      --   "001100000", -- 4 *  **  *
        green <= (others => '1');

      elsif((row = 125 and 328 < column and column < 331) or (row = 125 and 331 < column and column < 334))then
           --"01101100", -- 5    **

        green <= (others => '1');
        
      elsif((row = 126 and 328 < column and column < 332) or (row = 126 and 332 < column and column < 335 )) then
           --"01110110", -- 6    **

        green <= (others => '1');

      elsif((row = 127 and 328 < column and column < 331) or (row = 127 and 332 < column and column < 335)) then

            --"01100110", -- 7    **

        green <= (others => '1');

      elsif((row = 128 and 328 < column and column < 331) or ( row = 128 and 332 < column and column < 335)) then
                 --"01100110", -- 8    **

        green <= (others => '1');

      elsif((row = 129 and 328 < column and column < 331) or (row = 129 and 332 < column and column < 335)) then
                  --"01100110", -- 9    **

        green <= (others => '1');
     
      elsif((row = 130 and 328 < column and column < 331) or (row = 130 and 332 < column and column < 335)) then
                 --"01100110", -- a    **
        green <= (others => '1');

      elsif((row = 131 and 328 <= column and column < 331) or (row = 131 and 332 < column and column < 335)) then
         --"11100110", -- b   ****
        green <= (others => '1');
-----------------------------------------------------------------------------------------
-- e--
-- column start 336



      elsif(row = 125 and 336 < column and column < 342)then
           --"01111100", -- 5    **

        green <= (others => '1');
        
      elsif((row = 126 and 336 <= column and column < 338) or (row = 126 and 340 < column and column < 343 )) then
           --"11000110", -- 6    **

        green <= (others => '1');

      elsif(row = 127 and 336 <= column and column < 343) then

            --"11111110", -- 7    **

        green <= (others => '1');

      elsif(row = 128 and 336 <= column and column < 338) then
                 --"11000000", -- 8    **

        green <= (others => '1');

      elsif(row = 129 and 336 <= column and column < 338) then
                  --"11000000", -- 9    **

        green <= (others => '1');
     
      elsif((row = 130 and 336 <= column and column < 338) or (row = 125 and 340 < column and column < 343)) then
                 --"11000110", -- a    **
        green <= (others => '1');

      elsif(row = 131 and 336 < column and column < 342) then
         --"01111100", -- b   ****
        green <= (others => '1');
--------------------------------------------------------------------------------------------------
--r--
-- column start 344

      elsif((row = 125 and 344 <= column and column < 346) OR (row = 125 and 346 < column and column < 350))then
           --"11011100", -- 5    **

        green <= (others => '1');
        
      elsif((row = 126 and 344 < column and column < 348) or (row = 126 and 348 < column and column < 351)) then
           --"01110110", -- 6    **

        green <= (others => '1');

      elsif((row = 127 and 344 < column and column < 346) or (row = 127 and 348 < column and column < 351)) then

            --"01100110", -- 7    **

        green <= (others => '1');

      elsif(row = 128 and 344 < column and column < 346) then
                 --"01100000", -- 8    **

        green <= (others => '1');

      elsif(row = 129 and 344 < column and column < 346) then
                  --"01100000", -- 9    **

        green <= (others => '1');
     
      elsif(row = 130 and 344 < column and column < 346) then
                 --"01100000", -- a    **
        green <= (others => '1');

      elsif(row = 131 and 344 <= column and column < 348) then
         --"11110000", -- b   ****
        green <= (others => '1');
------------------------------------------------------------------------------
-- column start 352
-- e
    elsif(row = 122 and 352 <= column and column <=359) then
   --       "00000000", -- 2 ********
        green <= (others => '0');

      elsif(row = 123 and 352 <= column and column <= 359) then
   --      "00000000", -- 3 ** ** **
        green <= (others => '0');

      elsif(row = 124 and 352 <= column and column <= 359) then

      --   "00000000", -- 4 *  **  *
        green <= (others => '0');

      elsif(row = 125 and 352 < column and column < 359)then
           --"01111100", -- 5    **

        green <= (others => '1');
        
      elsif((row = 126 and 352 <= column and column < 354) or (row = 126 and 356 < column and column < 359 )) then
           --"11000110", -- 6    **

        green <= (others => '1');

      elsif(row = 127 and 352 <= column and column < 359) then

            --"11111110", -- 7    **

        green <= (others => '1');

      elsif(row = 128 and 352 <= column and column < 354) then
                 --"11000000", -- 8    **

        green <= (others => '1');

      elsif(row = 129 and 352 <= column and column < 354) then
                  --"11000000", -- 9    **

        green <= (others => '1');
     
      elsif((row = 130 and 352 <= column and column < 354) or (row = 125 and 356 < column and column < 359)) then
                 --"11000110", -- a    **
        green <= (others => '1');

      elsif(row = 131 and 352 < column and column < 358) then
         --"01111100", -- b   ****
        green <= (others => '1');

----------------------------------------------------------------------------
-- column start 368
-- > 
    elsif(row = 122 and 368 <= column and column <=375) then
   --       "00000000", -- 2 ********
        green <= (others => '0');

      elsif(row = 123 and 368 < column and column < 371) then
   --      "01100000", -- 3 ** ** **
        green <= (others => '1');

      elsif(row = 124 and 369 < column and column < 372) then

      --   "00110000", -- 4 *  **  *
        green <= (others => '1');

      elsif(row = 125 and 370 < column and column < 373)then
           --"000111000", -- 5    **

        green <= (others => '1');
        
      elsif(row = 126 and 371 < column and column < 374) then
           --"00001100", -- 6    **

        green <= (others => '1');

      elsif(row = 127 and 372 < column and column < 375) then

            --"00000110", -- 7    **

        green <= (others => '1');

      elsif(row = 128 and 371 < column and column < 374) then
                 --"00001100", -- 8    **

        green <= (others => '1');

      elsif(row = 129 and 370 < column and column < 373) then
                  --"00011000", -- 9    **

        green <= (others => '1');
     
      elsif(row = 130 and 369 < column and column < 372) then
                 --"00110000", -- a    **
        green <= (others => '1');

      elsif(row = 131 and 368 < column and column < 371) then
         --"01100000", -- b   ****
        green <= (others => '1');
-------------------------------------------------------------------
  -- column start 376
  -- _ --
      elsif(row = 133 and 376 <= column and column <= 383) then
         --"11111111", -- d   ****
        green <= (others => '1');
-----------------------------------------------------------------
-- column s tart 384
-- <
    elsif(row = 122 and 384 <= column and column <=391) then
   --       "00000000", -- 2 ********
        green <= (others => '0');

      elsif(row = 123 and 388 < column and column < 391) then
   --      "00000110", -- 3 ** ** **
        green <= (others => '1');

      elsif(row = 124 and 387 < column and column < 390) then

      --   "00001100", -- 4 *  **  *
        green <= (others => '1');

      elsif(row = 125 and 386 < column and column < 389)then
           --"00011000", -- 5    **

        green <= (others => '1');
        
      elsif(row = 126 and 385 < column and column < 388) then
           --"00110000", -- 6    **

        green <= (others => '1');

      elsif(row = 127 and 384 < column and column < 387) then

            --"01100000", -- 7    **

        green <= (others => '1');

      elsif(row = 128 and 385 < column and column < 388) then
                 --"00110000", -- 8    **

        green <= (others => '1');

      elsif(row = 129 and 386 < column and column < 389) then
                  --"00011000", -- 9    **

        green <= (others => '1');
     
      elsif(row = 130 and 387 < column and column < 390) then
                 --"00001100", -- a    **
        green <= (others => '1');

      elsif(row = 131 and 388 < column and column < 391) then
         --"00000110", -- b   ****
        green <= (others => '1');
-------------------------------------------------------------
--ENDING TWO LINES NEED TO BE CONSIDERED
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
END behv;
