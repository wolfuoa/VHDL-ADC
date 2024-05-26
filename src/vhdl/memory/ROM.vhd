-- megafunction wizard: %ROM: 1-PORT%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: altsyncram 
-- ============================================================
-- File Name: prog_mem.vhd
-- Megafunction Name(s):
-- 			altsyncram
--
-- Simulation Library Files(s):
-- 			altera_mf
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 13.0.1 Build 232 06/12/2013 SP 1 SJ Web Edition
-- ************************************************************
--Copyright (C) 1991-2013 Altera Corporation
--Your use of Altera Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Altera Program License 
--Subscription Agreement, Altera MegaCore Function License 
--Agreement, or other applicable license agreement, including, 
--without limitation, that your use is for the sole purpose of 
--programming logic devices manufactured by Altera and sold by 
--Altera or its authorized distributors.  Please refer to the 
--applicable agreement for further details.
-- Zoran Salcic

library ieee;
use ieee.std_logic_1164.all;

library altera_mf;
use altera_mf.all;

entity viktor_rom is
    generic (
        program_file_path : string
    );
    port (
        address : in  std_logic_vector(15 downto 0);
        clock   : in  std_logic := '1';
        q       : out std_logic_vector(31 downto 0)
    );
end entity;

architecture SYN of viktor_rom is

    signal sub_wire0 : std_logic_vector(31 downto 0);

    component altsyncram
        generic (
            clock_enable_input_a   : string;
            clock_enable_output_a  : string;
            init_file              : string;
            intended_device_family : string;
            lpm_hint               : string;
            lpm_type               : string;
            maximum_depth          : natural;
            numwords_a             : natural;
            operation_mode         : string;
            outdata_aclr_a         : string;
            outdata_reg_a          : string;
            ram_block_type         : string;
            widthad_a              : natural;
            width_a                : natural;
            width_byteena_a        : natural
        );
        port (
            address_a : in  std_logic_vector(15 downto 0);
            clock0    : in  std_logic;
            q_a       : out std_logic_vector(31 downto 0)
        );
    end component;

begin
    q <= sub_wire0;

    altsyncram_component : altsyncram
    generic map(
        clock_enable_input_a   => "BYPASS",
        clock_enable_output_a  => "BYPASS",
        init_file              => program_file_path, -- Replace with absolute path in modelsim
        intended_device_family => "Cyclone II",
        lpm_hint               => "ENABLE_RUNTIME_MOD=NO",
        lpm_type               => "altsyncram",
        maximum_depth          => 4096,
        numwords_a             => 65536,
        operation_mode         => "ROM",
        outdata_aclr_a         => "NONE",
        outdata_reg_a          => "UNREGISTERED",
        ram_block_type         => "M4K",
        widthad_a              => 16,
        width_a                => 32,
        width_byteena_a        => 1
    )
    port map(
        address_a => address,
        clock0    => clock,
        q_a       => sub_wire0
    );

end architecture;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
-- Retrieval info: PRIVATE: AclrAddr NUMERIC "0"
-- Retrieval info: PRIVATE: AclrByte NUMERIC "0"
-- Retrieval info: PRIVATE: AclrOutput NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_ENABLE NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
-- Retrieval info: PRIVATE: BlankMemory NUMERIC "0"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "0"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "0"
-- Retrieval info: PRIVATE: Clken NUMERIC "0"
-- Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
-- Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_A"
-- Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
-- Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "0"
-- Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
-- Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "4096"
-- Retrieval info: PRIVATE: MIFfilename STRING "../../../../../../../Dev/Code/CS701/Recop/rawOutput.mif"
-- Retrieval info: PRIVATE: NUMWORDS_A NUMERIC "32768"
-- Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "2"
-- Retrieval info: PRIVATE: RegAddr NUMERIC "1"
-- Retrieval info: PRIVATE: RegOutput NUMERIC "0"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: SingleClock NUMERIC "1"
-- Retrieval info: PRIVATE: UseDQRAM NUMERIC "0"
-- Retrieval info: PRIVATE: WidthAddr NUMERIC "15"
-- Retrieval info: PRIVATE: WidthData NUMERIC "16"
-- Retrieval info: PRIVATE: rden NUMERIC "0"
-- Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
-- Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_A STRING "BYPASS"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_A STRING "BYPASS"
-- Retrieval info: CONSTANT: INIT_FILE STRING "../../../../../../../Dev/Code/CS701/Recop/rawOutput.mif"
-- Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
-- Retrieval info: CONSTANT: LPM_HINT STRING "ENABLE_RUNTIME_MOD=NO"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
-- Retrieval info: CONSTANT: MAXIMUM_DEPTH NUMERIC "4096"
-- Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "32768"
-- Retrieval info: CONSTANT: OPERATION_MODE STRING "ROM"
-- Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "NONE"
-- Retrieval info: CONSTANT: OUTDATA_REG_A STRING "UNREGISTERED"
-- Retrieval info: CONSTANT: RAM_BLOCK_TYPE STRING "M4K"
-- Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "15"
-- Retrieval info: CONSTANT: WIDTH_A NUMERIC "16"
-- Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
-- Retrieval info: USED_PORT: address 0 0 15 0 INPUT NODEFVAL "address[14..0]"
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT VCC "clock"
-- Retrieval info: USED_PORT: q 0 0 16 0 OUTPUT NODEFVAL "q[15..0]"
-- Retrieval info: CONNECT: @address_a 0 0 15 0 address 0 0 15 0
-- Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
-- Retrieval info: CONNECT: q 0 0 16 0 @q_a 0 0 16 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL prog_mem.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL prog_mem.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL prog_mem.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL prog_mem.bsf TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL prog_mem_inst.vhd FALSE
-- Retrieval info: LIB_FILE: altera_mf