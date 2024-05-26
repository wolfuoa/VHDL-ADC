library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.TdmaMinTypes;

entity TestBenchAdcAsp is
end entity;

architecture test of TestBenchAdcAsp is

    signal t_clock  : std_logic;
    signal t_reset  : std_logic;
    signal t_enable : std_logic := '1';
    signal t_recv   : TdmaMinTypes.tdma_min_port;
    signal t_send   : TdmaMinTypes.tdma_min_port;

begin

    DUT : entity work.TopLevelAdcAsp
        port map(
            clock  => t_clock,
            reset  => t_reset,
            enable => t_enable,
            recv   => t_recv,
            send   => t_send
        );

    emulate_tdmamin : process
    begin
        t_recv.data <= x"A0020000"; -- Config Message b10100000000000100000000000000000
        wait until rising_edge(t_clock);
        t_recv.data <= x"00000000";
        wait;
    end process;

    clock : process
    begin
        t_clock <= '1';
        wait for 10 ns;
        t_clock <= '0';
        wait for 10 ns;
    end process clock;
end architecture;