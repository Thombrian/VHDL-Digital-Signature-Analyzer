library ieee;
use ieee.std_logic_1164.all;

entity buffer_reg is
    port(
        rst_bar  : in  std_logic;
        clk      : in  std_logic;
        enable   : in  std_logic;
        data_in  : in  std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0)
    );
end buffer_reg;

architecture behavioral of buffer_reg is

    signal reg : std_logic_vector(15 downto 0);

begin

    process(clk)
    begin

        if rising_edge(clk) then

            if rst_bar = '0' then
                reg <= (others => '0');

            elsif enable = '1' then
                reg <= data_in;

            end if;

        end if;

    end process;

    data_out <= reg;

end behavioral;
