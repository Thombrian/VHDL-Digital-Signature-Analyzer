library ieee;
use ieee.std_logic_1164.all;

entity multiplexed_display_driver is -- same as Lab 11
    port(
        clk       : in  std_logic;
        rst_bar   : in  std_logic;
        signature : in  std_logic_vector(15 downto 0);
        segs      : out std_logic_vector(6 downto 0);
        digs      : out std_logic_vector(3 downto 0)
    );
end multiplexed_display_driver;

architecture structural of multiplexed_display_driver is

    signal sel : std_logic_vector(1 downto 0);

    signal mux_out : std_logic_vector(3 downto 0);

begin

    -- Port map showing connections of all the parts
    -- for structural style

    u_counter : entity work.digit_counter
        port map(
            rst_bar => rst_bar,
            clk     => clk,
            sel     => sel
        );

    u_mux : entity work.mux_4x_2to1
        port map(
            s1 => sel(1),
            s0 => sel(0),

            in_vector_0 => signature(3 downto 0),
            in_vector_1 => signature(7 downto 4),
            in_vector_2 => signature(11 downto 8),
            in_vector_3 => signature(15 downto 12),

            out_vector => mux_out
        );

    u_hex : entity work.funnyhex_seven
        port map(
            fhex     => mux_out,
            segments => segs
        );

    u_decoder : entity work.decoder_1of4
        port map(
            s1           => sel(1),
            s0           => sel(0),
            digit_driver => digs
        );

end structural;
