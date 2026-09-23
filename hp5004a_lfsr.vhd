library ieee;
use ieee.std_logic_1164.all;

entity hp5004a_lfsr is -- same as Lab 11
    port(
        clk      : in  std_logic;
        rst_bar  : in  std_logic;
        gate     : in  std_logic;
        clock_in : in  std_logic;
        data_in  : in  std_logic;
        clear    : in  std_logic;
        sig_out  : out std_logic_vector(15 downto 0)
    );
end hp5004a_lfsr;

architecture behavioral of hp5004a_lfsr is

    signal reg : std_logic_vector(15 downto 0);

begin

    process(clk)

        variable temp : std_logic;

    begin

        if rising_edge(clk) then

            if rst_bar = '0' then

                reg <= (others => '0');

            elsif clear = '1' then

                reg <= (others => '0');

            elsif gate = '1' and clock_in = '1' then

                temp := reg(15) xor data_in;

                reg(15 downto 1) <= reg(14 downto 0);

                reg(12) <= reg(11) xor temp;
                reg(9)  <= reg(8) xor temp;
                reg(7)  <= reg(6) xor temp;

                reg(0) <= temp;

            end if;

        end if;

    end process;

    sig_out <= reg;

end behavioral;
