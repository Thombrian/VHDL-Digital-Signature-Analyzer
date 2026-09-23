library ieee;
use ieee.std_logic_1164.all;

entity gate_gen is -- entity gate_gen
    port(
        rst_bar    : in  std_logic;
        clk        : in  std_logic;
        start      : in  std_logic;
        stop       : in  std_logic;
        gate       : out std_logic;
        buff_ld_en : out std_logic
    );
end gate_gen; -- end gate_gen

architecture behavioral of gate_gen is
    -- architecture that dictates the way the function works

    type state_type is (s0, s1, s2, s3);
    signal ps, ns : state_type;

begin

    process(clk)
    begin

        if rising_edge(clk) then

            if rst_bar = '0' then
                ps <= s0;
            else
                ps <= ns;
            end if;

        end if;

    end process;


    process(ps, start, stop)
    begin

        case ps is

            when s0 =>
                if start = '1' then
                    ns <= s1;
                else
                    ns <= s0;
                end if;

            when s1 =>
                if stop = '1' then
                    ns <= s2;
                else
                    ns <= s1;
                end if;

            when s2 =>
                ns <= s3;

            when s3 =>
                ns <= s0;

            when others =>
                ns <= s0;

        end case;

    end process;


    process(ps)
    begin

        gate       <= '0';
        buff_ld_en <= '0';

        case ps is

            when s0 =>
                gate       <= '0';
                buff_ld_en <= '0';

            when s1 =>
                gate       <= '1';
                buff_ld_en <= '0';

            when s2 =>
                gate       <= '0';
                buff_ld_en <= '1';

            when s3 =>
                gate       <= '0';
                buff_ld_en <= '0';

            when others =>
                gate       <= '0';
                buff_ld_en <= '0';

        end case;

    end process;

end behavioral;
