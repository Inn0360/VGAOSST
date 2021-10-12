--Binary Bit to Integer Conversion

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conversion is 
	port(
		bit_in    :in   std_logic_vector(7 downto 0);
		integer_out:out  integer
	);
end conversion;

architecture arch of conversion is
begin

	integer_out <= to_integer(signed(bit_in));
	
end arch;