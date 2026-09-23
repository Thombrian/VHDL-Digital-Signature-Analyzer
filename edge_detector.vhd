library ieee;
use ieee.std_logic_1164.all;

entity posedge is
    port(
        rst_bar : in  std_logic;
        clk     : in  std_logic; -- positive edge
        a       : in  std_logic;
        a_pe    : out std_logic
    );
end posedge;

architecture behavioral of posedge is

    signal delay : std_logic;

begin

    process(clk)
    begin

        if rising_edge(clk) then

            if rst_bar = '0' then
                delay <= '0';
            else
                delay <= a;
            end if;

        end if;

    end process;

    a_pe <= a and not delay;

end behavioral;


library ieee;
use ieee.std_logic_1164.all;

entity negedge is
    port(
        rst_bar : in  std_logic;
        clk     : in  std_logic; -- negative edge
        a       : in  std_logic;
        a_ne    : out std_logic
    );
end negedge;

architecture behavioral of negedge is

    signal delay : std_logic;

begin

    process(clk)
    begin

        if rising_edge(clk) then

            if rst_bar = '0' then
                delay <= '0';
            else
                delay <= a;
            end if;

        end if;

    end process;

    a_ne <= not a and delay;

end behavioral;


library ieee;
use ieee.std_logic_1164.all;

entity select_edge is
    port(
        a             : in  std_logic;
        pos_neg       : in  std_logic;
        selected_edge : out std_logic;
        rst_bar       : in  std_logic;
        clk           : in  std_logic
    );
end select_edge;

architecture structural of select_edge is

    signal a_pe, a_ne : std_logic;

begin

    -- Structural style showing which positive or negative
    -- edge is selected

    u0 : entity work.posedge
        port map(
            rst_bar => rst_bar,
            clk     => clk,
            a       => a,
            a_pe    => a_pe
        );

    u1 : entity work.negedge
        port map(
            rst_bar => rst_bar,
            clk     => clk,
            a       => a,
            a_ne    => a_ne
        );

    selected_edge <= (a_pe and pos_neg) or
                     (a_ne and not pos_neg);

end structural;
