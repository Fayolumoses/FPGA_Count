library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Count is 
port(
	clk_in: in std_logic;
	seg0,seg1,seg2,seg3: buffer std_logic_vector(6 downto 0);
	comBus : out std_logic_vector(6 downto 0);
	ccOut: out std_logic_vector(3 downto 0)
);
end Count;

architecture b of Count is
signal myVal: integer range 0 to 10000 := 0;
signal clkDiv: integer range 0 to 25000000:=0;
signal clkOut,determinant: std_logic:= '0';
signal myData: std_logic_vector(7 downto 0):= "00000000";
signal com: std_logic_vector( 6 downto 0);
signal temp1,temp2,temp3,temp4: std_logic_vector(3 downto 0):= "0000";
signal t1,t2,t3,t4: integer range 0 to 9;
signal cycle: integer range 0 to 10:= 0;
component Vhdl2
	port(
	clk,deter: in std_logic;
	data_in: in std_logic_vector(7 downto 0);
	seg_out0,seg_out1,seg_out2,seg_out3: buffer std_logic_vector(6 downto 0);
	comBus : out std_logic_vector(6 downto 0);
	ccOut: out std_logic_vector(3 downto 0)
);
end component;

begin
Multiplexer:Vhdl2
 port map(clk => clk_in, deter => determinant, data_in=> myData,seg_out0=> seg0,seg_out1=> seg1,seg_out2=> seg2,seg_out3=> seg3, comBus=> com);

process(clk_in)
	begin 
	if(rising_edge(clk_in)) then
		if (clkDiv = 2000000) then
			clkDiv <= 0;
			clkOut <= not(clkOut);
		else
			clkDiv<= clkDiv + 1;
		end if;
	end if;
	end process;
	
process (clkOut,myVal)
begin
	if(falling_edge(clkOut)) then
		if(myVal = 10000) then
		myVal <= 0;
		else
		myVal <= myVal + 1;
		end if;
	end if;
end process;

t1 <= myVal mod 10;
t2 <= (myVal/10) mod 10;
t3 <= (myVal/100) mod 10;
t4 <= (myVal /1000) mod 10;

with t1 select
 temp1 <= "0000" when 0,
			"0001" when 1,
			"0010" when 2,
			"0011" when 3,
			"0100" when 4,
			"0101" when 5,
			"0110" when 6,
			"0111" when 7,
			"1000" when 8,
			"1001" when 9,
			"0000" when others;
			
with t2 select
 temp2 <= "0000" when 0,
			"0001" when 1,
			"0010" when 2,
			"0011" when 3,
			"0100" when 4,
			"0101" when 5,
			"0110" when 6,
			"0111" when 7,
			"1000" when 8,
			"1001" when 9,
			"0000" when others;
with t3 select
 temp3 <= "0000" when 0,
			"0001" when 1,
			"0010" when 2,
			"0011" when 3,
			"0100" when 4,
			"0101" when 5,
			"0110" when 6,
			"0111" when 7,
			"1000" when 8,
			"1001" when 9,
			"0000" when others;
with t4 select
 temp4 <= "0000" when 0,
			"0001" when 1,
			"0010" when 2,
			"0011" when 3,
			"0100" when 4,
			"0101" when 5,
			"0110" when 6,
			"0111" when 7,
			"1000" when 8,
			"1001" when 9,
			"0000" when others;


process(cycle,clk_in)
begin
	if(rising_edge(clk_in)) then
		if( cycle = 0) then
			myData( 3 downto 0) <= temp1;
			myData (6 downto 4) <= "001";
			myData(7) <= '1';
			cycle<= cycle + 1;
		elsif( cycle = 1) then
			myData(7) <= '0';
			cycle<= cycle + 1;
		elsif( cycle = 2) then
			myData( 3 downto 0) <= temp2;
			myData (6 downto 4) <= "010";
			myData(7) <= '1';
			cycle<= cycle + 1;
		elsif( cycle = 3) then
			myData(7) <= '0';
			cycle<= cycle + 1;
		elsif( cycle = 4) then
			myData( 3 downto 0) <= temp3;
			myData (6 downto 4) <= "011";
			myData(7) <= '1';
			cycle<= cycle + 1;
		elsif( cycle = 5) then
			myData(7) <= '0';
			cycle<= cycle + 1;
		elsif( cycle = 6) then
			myData( 3 downto 0) <= temp4;
			myData (6 downto 4) <= "100";
			myData(7) <= '1';
			cycle<= cycle + 1;
		elsif( cycle = 7) then
			myData(7) <= '0';
			cycle<= cycle + 1;
		else
			cycle <= 0;
		end if;
	end if;
end process;


end b;

