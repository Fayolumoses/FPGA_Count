library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity SevSegController is
port(
	bus_in: in std_logic_vector(7 downto 0);
	bus_out: out std_logic_vector(15 downto 0)
);

end SevSegController;

architecture arch of SevSegController is
 signal mBus0,mBus1,mBus2,mBus3: std_logic_vector(3 downto 0) := "0000";
 signal address: std_logic_vector(2 downto 0):= "000";
begin
	address<= bus_in(6 downto 4);
	process(bus_in(7),address)
		begin
		if(falling_edge(bus_in(7))) then
			
			if(address = "001") then
				mBus0 <= bus_in(3 downto 0);
			elsif (address = "010") then
				mBus1 <= bus_in(3 downto 0);
			elsif(address = "011") then
				mBus2 <= bus_in(3 downto 0);
			elsif (address = "100") then
				mBus3 <= bus_in(3 downto 0);
			end if;
		end if;
	end process;

	bus_out( 3 downto 0) <= mBus0;
	bus_out( 7 downto 4) <= mBus1;
	bus_out( 11 downto 8) <= mBus2;
	bus_out( 15 downto 12) <= mBus3;
end arch; 