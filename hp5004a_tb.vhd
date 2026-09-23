-- Kenneth Short 5/4/26

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity hp5004a_tb is
end hp5004a_tb;

architecture tb_architecture of hp5004a_tb is

    -- Stimulus signals
    signal rst_bar : std_logic;
    signal clk     : std_logic := '0';

    signal start  : std_logic := '0';
    signal starte : std_logic := '1';

    signal stop  : std_logic := '0';
    signal stope : std_logic := '1';

    signal clock  : std_logic := '0';
    signal clocke : std_logic := '1';

    signal data : std_logic := '0';

    -- Observed signals
    signal segs : std_logic_vector(6 downto 0);
    signal digs : std_logic_vector(3 downto 0);

    -- Signal to end simulation
    signal end_sim : boolean := false;

    -- System clock is 10 times data clock
    constant period     : time := 250 ns;
    constant dut_period : time := 2.5 us;

    -- Data stream value - you can change this
    constant data_stream : std_logic_vector(15 downto 0) :=
        "1000000000000000";

begin

    -- Unit under test port map
    uut : entity hp5004a
        port map(
            rst_bar => rst_bar,
            clk     => clk,
            start   => start,
            starte  => starte,
            stop    => stop,
            stope   => stope,
            clock   => clock,
            clocke  => clocke,
            data    => data,
            segs    => segs,
            digs    => digs
        );

    -- System reset
    rst_bar <= '0', '1' after 2 * period;


    -- System clock
    clk_process : process
    begin

        loop

            wait for period / 2;
            clk <= not clk;

            exit when end_sim = true;

        end loop;

        std.env.finish;

    end process;


    -- DUT clock
    dut_clock_process : process
    begin

        loop

            wait for dut_period / 2;
            clock <= not clock;

            exit when end_sim = true;

        end loop;

        std.env.finish;

    end process;


    -- Repeated generation of start, data stream and stop
    data_process : process
    begin

        for i in 0 to 3 loop

            wait for 4 * dut_period;
            wait until falling_edge(clock);

            start <= '1';
            data  <= data_stream(15);

            wait until falling_edge(clock);

            start <= '0';

            for i in 14 downto 0 loop

                data <= data_stream(i);

                wait until falling_edge(clock);

            end loop;

            stop <= '1';

            wait until falling_edge(clock);

            stop <= '0';

        end loop;

        wait for 4 * dut_period;

        end_sim <= true;

        std.env.finish;

    end process;

end tb_architecture;
