library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
package AdcFilePaths is
    constant rom_8_file_path       : string := "C:\Users\AKLbc\Desktop\Development\VHDL-ADC\src\MIFs\8_bit_rom.mif";
    constant rom_10_file_path      : string := "C:\Users\AKLbc\Desktop\Development\VHDL-ADC\src\MIFs\10_bit_rom.mif";
    constant rom_12_file_path      : string := "C:\Users\AKLbc\Desktop\Development\VHDL-ADC\src\MIFs\12_bit_rom.mif";

    constant rom_8_file_path_wolf  : string := "H:\Documents\GitHub\VHDL-ADC\701-ADC\src\MIFs\8_bit_rom.mif";
    constant rom_10_file_path_wolf : string := "H:\Documents\GitHub\VHDL-ADC\src\MIFs\10_bit_rom.mif";
    constant rom_12_file_path_wolf : string := "H:\Documents\GitHub\VHDL-ADC\src\MIFs\12_bit_rom.mif";
end package;