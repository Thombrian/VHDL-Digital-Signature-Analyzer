library ieee;
use ieee.std_logic_1164.all;

entity prescalar is
    port(
        rst_bar : in  std_logic;
        clk     : in  std_logic;
        pout    : out std_logic
    );
end prescalar;

architecture behavioral of prescalar is

    signal count : integer range 0 to 9999;

begin

    process(clk)
    begin

        if rising_edge(clk) then

            if rst_bar = '0' then
                count <= 0;
                pout  <= '0';

            elsif count = 9998 then
                count <= 9999;
                pout  <= '1';

            elsif count = 9999 then
                count <= 0;
                pout  <= '0';

            else
                count <= count + 1;

            end if;

        end if;

    end process;

end behavioral;
