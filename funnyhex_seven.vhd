library ieee;
use ieee.std_logic_1164.all;

entity funnyhex_seven is -- same as Lab 10
    port(
        fhex     : in  std_logic_vector(3 downto 0);
        segments : out std_logic_vector(6 downto 0)
    );
end funnyhex_seven;

architecture sel of funnyhex_seven is

begin

    with fhex select -- select case for funny hex

        segments <=
            "0111111" when "0000",
            "0000110" when "0001",
            "1011011" when "0010",
            "1001111" when "0011",
            "1100110" when "0100",
            "1101101" when "0101",
            "1111101" when "0110",
            "0000111" when "0111",
            "1111111" when "1000",
            "1101111" when "1001",
            "1110111" when "1010",
            "0111001" when "1011",
            "1110001" when "1100",
            "1110110" when "1101",
            "1110011" when "1110",
            "0111110" when "1111",
            "0000000" when others;

end sel;
