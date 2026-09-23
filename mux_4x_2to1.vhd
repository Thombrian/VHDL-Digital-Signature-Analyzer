library ieee; -- libraries
use ieee.std_logic_1164.all;

entity mux_4x_2to1 is -- same as Lab 10
    port(
        s1          : in  std_logic;
        s0          : in  std_logic;
        in_vector_0 : in  std_logic_vector(3 downto 0);
        in_vector_1 : in  std_logic_vector(3 downto 0);
        in_vector_2 : in  std_logic_vector(3 downto 0);
        in_vector_3 : in  std_logic_vector(3 downto 0);
        out_vector  : out std_logic_vector(3 downto 0)
    );
end mux_4x_2to1;

architecture behavioral of mux_4x_2to1 is

    signal temp : std_logic_vector(1 downto 0);
    -- signal for storing select values

begin

    temp <= s1 & s0;
    -- setting temp equal to select values

    process(temp, in_vector_0, in_vector_1, in_vector_2, in_vector_3)
    begin

        case temp is -- case statement

            when "00" =>
                out_vector <= in_vector_0;

            when "01" =>
                out_vector <= in_vector_1;

            when "10" =>
                out_vector <= in_vector_2;

            when others =>
                out_vector <= in_vector_3;

        end case;

    end process;

end behavioral;
