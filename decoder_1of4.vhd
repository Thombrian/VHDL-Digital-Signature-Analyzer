library ieee;
use ieee.std_logic_1164.all;

entity decoder_1of4 is -- same as decoder
    port(
        s1           : in  std_logic;
        s0           : in  std_logic;
        digit_driver : out std_logic_vector(3 downto 0)
    );
end decoder_1of4;

architecture dataflow of decoder_1of4 is

    signal temp : std_logic_vector(1 downto 0);

begin

    temp <= s1 & s0;

    process(temp)
    begin

        case temp is -- process statement that goes through all the cases

            when "00" =>
                digit_driver <= "0001";

            when "01" =>
                digit_driver <= "0010";

            when "10" =>
                digit_driver <= "0100";

            when "11" =>
                digit_driver <= "1000";

            when others =>
                digit_driver <= "0000";

        end case;

    end process;

end dataflow;
