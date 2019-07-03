library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clk_div is
port(
	clk_in: in std_logic;
	clk_out: out std_logic_vector(3 downto 0)
);
end clk_div;

architecture a of clk_div is
signal count: integer range 0 to 25000000:= 0;
signal myClk:integer range 0 to 5:= 0;
begin
process(clk_in)
	begin
		if(rising_edge(clk_in)) then
			if(count = 110000) then
				count<= 0;
				if(myClk = 4) then
					myClk <= 0;
				else
					myClk<= myClk + 1;
				end if;
				else
			count<= count + 1;
			end if;
			
			
		end if;
	end process;
	
	with myClk select
	clk_out<= "0001" when 0,
				"0010" when 1,
				"0100" when 2,
				"1000" when 3,
				"0000" when others;
end a;
