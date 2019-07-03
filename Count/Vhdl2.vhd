library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Vhdl2 is
port(
	clk,deter: in std_logic;
	data_in: in std_logic_vector(7 downto 0);
	seg_out0,seg_out1,seg_out2,seg_out3: buffer std_logic_vector(6 downto 0);
	comBus : out std_logic_vector(6 downto 0);
	ccOut: out std_logic_vector(3 downto 0)
);
end Vhdl2;

architecture a of Vhdl2 is
signal common: std_logic_vector(3 downto 0);
signal data: std_logic_vector(15 downto 0);

--component declaration.
component SevSegController
	port(
	bus_in: in std_logic_vector(7 downto 0);
	bus_out: out std_logic_vector(15 downto 0)
);
end component;
component clk_div
	port(
	clk_in: in std_logic;
	clk_out: out std_logic_vector(3 downto 0)
);
end component;

component Segment
	port(
	determinator,com: in std_logic;
	bus_in: in std_logic_vector(3 downto 0);
	abus_out: out std_logic_vector(6 downto 0)
);
end component;

begin
Mem:SevSegController
port map( bus_in=> data_in, bus_out=> data);
mClk1:clk_div
port map(clk_in => clk, clk_out => common);
Seg0:Segment
port map(determinator=>deter, com => common(0), bus_in => data(3 downto 0), abus_out => seg_out0);
Seg1:Segment
port map(determinator=>deter, com => common(1), bus_in => data(7 downto 4), abus_out => seg_out1);
Seg2:Segment
port map(determinator=>deter, com => common(2), bus_in => data(11 downto 8), abus_out => seg_out2);
Seg3:Segment
port map(determinator=>deter, com => common(3), bus_in => data(15 downto 12), abus_out => seg_out3);

comBus <=seg_out0 or seg_out1 or seg_out2 or seg_out3;
ccOut <= common;
end a;