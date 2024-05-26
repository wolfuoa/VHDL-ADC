LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.TdmaMinTypes.ALL;

ENTITY AspAdc IS
	PORT (
		clock : IN STD_LOGIC;
		empty : IN STD_LOGIC;
		get : OUT STD_LOGIC;
		data : IN STD_LOGIC_VECTOR(16 DOWNTO 0);

		send : OUT tdma_min_port;
		recv : IN tdma_min_port
	);
END ENTITY;

ARCHITECTURE rtl OF AspAdc IS

	SIGNAL addr_0 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";
	SIGNAL addr_1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";
	SIGNAL rate_0 : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	SIGNAL rate_1 : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	SIGNAL enable_0 : STD_LOGIC := '0';
	SIGNAL enable_1 : STD_LOGIC := '0';

BEGIN

	get <= NOT empty;

	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN

			IF recv.data(31 DOWNTO 28) = "1010" THEN
				IF recv.data(16) = '0' THEN
					addr_0 <= recv.data(23 DOWNTO 20);
					rate_0 <= recv.data(19 DOWNTO 18);
					enable_0 <= recv.data(17);
				ELSE
					addr_1 <= recv.data(23 DOWNTO 20);
					rate_1 <= recv.data(19 DOWNTO 18);
					enable_1 <= recv.data(17);
				END IF;
			END IF;

		END IF;
	END PROCESS;

	PROCESS (clock)
		VARIABLE new_data : BOOLEAN;
		VARIABLE tick_0 : unsigned(7 DOWNTO 0) := x"00";
		VARIABLE tick_1 : unsigned(7 DOWNTO 0) := x"00";
	BEGIN
		IF rising_edge(clock) THEN

			IF new_data AND data(16) = '0' AND enable_0 = '1' THEN
				IF tick_0 /= 0 THEN
					tick_0 := tick_0 - 1;
					send.addr <= (OTHERS => '0');
					send.data <= (OTHERS => '0');
				ELSE
					CASE rate_0 IS
						WHEN "11" => tick_0 := x"ff";
						WHEN "10" => tick_0 := x"0f";
						WHEN "01" => tick_0 := x"03";
						WHEN OTHERS => tick_0 := x"00";
					END CASE;
					send.addr <= "0000" & addr_0;
					send.data <= "100000000000000" & data;
				END IF;
			ELSIF new_data AND data(16) = '1' AND enable_1 = '1' THEN
				IF tick_1 /= 0 THEN
					tick_1 := tick_1 - 1;
					send.addr <= (OTHERS => '0');
					send.data <= (OTHERS => '0');
				ELSE
					CASE rate_1 IS
						WHEN "11" => tick_1 := x"ff";
						WHEN "10" => tick_1 := x"0f";
						WHEN "01" => tick_1 := x"03";
						WHEN OTHERS => tick_1 := x"00";
					END CASE;
					send.addr <= "0000" & addr_1;
					send.data <= "100000000000000" & data;
				END IF;
			ELSE
				send.addr <= (OTHERS => '0');
				send.data <= (OTHERS => '0');
			END IF;

			new_data := empty = '0';
		END IF;
	END PROCESS;

END ARCHITECTURE;