library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.TdmaMinTypes;
use work.AdcFilePaths;

library altera_mf;
use altera_mf.all;

entity TopLevelAdcAsp is
    port (
        clock  : in  std_logic;
        reset  : in  std_logic;
        enable : in  std_logic;

        recv   : in  TdmaMinTypes.tdma_min_port;
        send   : out TdmaMinTypes.tdma_min_port
    );
end TopLevelAdcAsp;

architecture bhv of TopLevelAdcAsp is
    constant data_depth                 : integer                       := 1600;

    signal config_address               : std_logic_vector(3 downto 0)  := "0000";
    signal config_rate                  : std_logic_vector(1 downto 0)  := "00";
    signal config_enable                : std_logic_vector(0 downto 0)  := "0";
    signal config_resolution            : std_logic_vector(1 downto 0)  := "00";

    signal registered_config_address    : std_logic_vector(3 downto 0)  := "0000";
    signal registered_config_rate       : std_logic_vector(1 downto 0)  := "00";
    signal registered_config_enable     : std_logic_vector(0 downto 0)  := "0";
    signal registered_config_resolution : std_logic_vector(1 downto 0)  := "00";

    signal config_register_write_enable : std_logic                     := '0';

    signal data_address                 : integer                       := 0;
    signal converted_data_address       : std_logic_vector(15 downto 0) := x"0000";
    signal adc_data_in                  : std_logic_vector(11 downto 0) := x"000";
    signal rom12_data_out               : std_logic_vector(31 downto 0) := x"00000000";
begin

    converted_data_address <= std_logic_vector(to_unsigned(data_address, 16));

    -- ADC CONFIG REGS
    address_register : entity work.register_buffer
        generic map(
            width => 4
        )
        port map(
            clock        => clock,
            reset        => reset,
            write_enable => config_register_write_enable,
            data_in      => config_address,
            data_out     => registered_config_address
        );

    rate_register : entity work.register_buffer
        generic map(
            width => 2
        )
        port map(
            clock        => clock,
            reset        => reset,
            write_enable => config_register_write_enable,
            data_in      => config_rate,
            data_out     => registered_config_rate
        );

    resolution_register : entity work.register_buffer
        generic map(
            width => 2
        )
        port map(
            clock        => clock,
            reset        => reset,
            write_enable => config_register_write_enable,
            data_in      => config_resolution,
            data_out     => registered_config_resolution
        );

    enable_register : entity work.register_buffer
        generic map(
            width => 1
        )
        port map(
            clock        => clock,
            reset        => reset,
            write_enable => config_register_write_enable,
            data_in      => config_enable,
            data_out     => registered_config_enable
        );

    rom12 : entity work.viktor_rom
        generic map(
            program_file_path => AdcFilePaths.rom_12_file_path
        )
        port map(
            address => converted_data_address,
            clock   => clock,
            q       => rom12_data_out
        );

    config_address               <= recv.data(23 downto 20);
    config_rate                  <= recv.data(19 downto 18);
    config_enable(0)             <= recv.data(17);
    config_resolution            <= recv.data(15 downto 14);

    config_register_write_enable <= '1' when recv.data(31 downto 28) = "1010" else
                                    '0';
    with registered_config_resolution select adc_data_in <=
                                                           "0000" & rom12_data_out(11 downto 4) when "00",
                                                           "00" & rom12_data_out(11 downto 2) when "01", -- 
                                                           rom12_data_out(11 downto 0) when others;

    process (clock, reset)
        variable tick : unsigned(7 downto 0) := x"00";
    begin
        if reset = '1' then
            data_address <= 0;
            send.data    <= (others => '0');
            send.addr    <= (others => '0');
        elsif rising_edge(clock) then
            if registered_config_enable(0) = '1' then
                if to_integer(tick) /= 0 then
                    tick := tick - 1;
                    send.addr    <= (others => '0');
                    send.data    <= (others => '0');
                    data_address <= data_address;
                else
                    case registered_config_rate is
                        when "11"   => tick   := x"ff";
                        when "10"   => tick   := x"0f";
                        when "01"   => tick   := x"03";
                        when others => tick := x"00";
                    end case;
                    send.addr <= "0000" & registered_config_address;
                    send.data <= "1000000000000000" & "0000" & adc_data_in;
                    if (data_address = data_depth - 1) then
                        data_address <= 0;
                    else
                        data_address <= data_address + 1;
                    end if;
                end if;
            else
                send.addr    <= (others => '0');
                send.data    <= (others => '0');
                data_address <= data_address;
            end if;
        end if;
    end process;
end bhv;