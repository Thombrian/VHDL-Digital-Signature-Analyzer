library ieee;
use ieee.std_logic_1164.all;

entity hp5004a is
    -- Structural style which includes all the entities
    -- connected together as the block diagram

    port(
        rst_bar, clk : in std_logic;

        start, starte : in std_logic;
        stop, stope   : in std_logic;
        clock, clocke : in std_logic;

        data : in std_logic;

        segs : out std_logic_vector(6 downto 0);
        digs : out std_logic_vector(3 downto 0)
    );

end hp5004a;

architecture structural of hp5004a is

    signal start_edge, stop_edge, clock_edge : std_logic;

    signal gate, buff_ld_en : std_logic;

    signal sig_out, buffer_out : std_logic_vector(15 downto 0);

    signal prescalar_out : std_logic;

begin

    -- Select edge for start signal
    u0 : entity work.select_edge
        port map(
            a             => start,
            pos_neg       => starte,
            rst_bar       => rst_bar,
            clk           => clk,
            selected_edge => start_edge
        );

    -- Select edge for stop signal
    u1 : entity work.select_edge
        port map(
            a             => stop,
            pos_neg       => stope,
            rst_bar       => rst_bar,
            clk           => clk,
            selected_edge => stop_edge
        );

    -- Select edge for clock signal
    u2 : entity work.select_edge
        port map(
            a             => clock,
            pos_neg       => clocke,
            rst_bar       => rst_bar,
            clk           => clk,
            selected_edge => clock_edge
        );

    -- Gate generator
    u3 : entity work.gate_gen
        port map(
            rst_bar    => rst_bar,
            clk        => clk,
            start      => start_edge,
            stop       => stop_edge,
            gate       => gate,
            buff_ld_en => buff_ld_en
        );

    -- LFSR signature generator
    u4 : entity work.hp5004a_lfsr
        port map(
            clk      => clk,
            rst_bar  => rst_bar,
            gate     => gate,
            clock_in => clock_edge,
            data_in  => data,
            clear    => buff_ld_en,
            sig_out  => sig_out
        );

    -- Buffer register
    u5 : entity work.buffer_reg
        port map(
            rst_bar  => rst_bar,
            clk      => clk,
            enable   => buff_ld_en,
            data_in  => sig_out,
            data_out => buffer_out
        );

    -- Prescaler
    u7 : entity work.prescalar
        port map(
            rst_bar => rst_bar,
            clk     => clk,
            pout    => prescalar_out
        );

    -- Multiplexed display driver
    u8 : entity work.multiplexed_display_driver
        port map(
            clk       => prescalar_out,
            rst_bar   => rst_bar,
            signature => buffer_out,
            segs      => segs,
            digs      => digs
        );

end structural;
