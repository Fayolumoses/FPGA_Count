library ieee;
use ieee.std_logic_1164.all;

entity Segment is
port(
	determinator,com: in std_logic;
	bus_in: in std_logic_vector(3 downto 0);
	abus_out: out std_logic_vector(6 downto 0)
);
end Segment;

architecture s of Segment is
signal bus_out: std_logic_vector(6 downto 0);
signal cbus : std_logic_vector(3 downto 0);

begin

with com select
	cbus<= bus_in when '1',
			"1010" when others;

 with cbus select
  bus_out <= "0111111" when "0000",
			 "0000110" when "0001",
			 "1011011" when "0010",
			 "1001111" when "0011",
			 "1100110" when "0100",
			 "1101101" when "0101",
			 "1111101" when "0110",
			 "0000111" when "0111",
			 "1111111" when "1000",
			 "1101111" when "1001",
			 "0000000" when others;
	
	with determinator select
		abus_out <= bus_out  when '1',
					not(bus_out)  when others;
			 
end s;
