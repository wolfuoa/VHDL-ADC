library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

package TdmaMinTypes is

    subtype tdma_min_addr is std_logic_vector(7 downto 0);
    subtype tdma_min_data is std_logic_vector(31 downto 0);
    subtype tdma_min_fifo is std_logic_vector(39 downto 0);

    type tdma_min_port is record
        addr : tdma_min_addr;
        data : tdma_min_data;
    end record;
end package;