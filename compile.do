puts {
  *****************************
  BIGLARI-COMPILER FOR MODELSIM
  *****************************
}

set library_file_list {
                           design_library {
                                src/vhdl/memory/RegisterBuffer.vhd
                                src/vhdl/memory/ROM.vhd
                                src/vhdl/TdmaMin/TdmaMinTypes.vhd
                                src/vhdl/FilePaths.vhd
                                src/vhdl/TopLevelAdcAsp.vhd
                           }

                           test_library   {
                                test/TestBenchAdcAsp.vhd
                           }
}


#Does this installation support Tk?
set tk_ok 1
if [catch {package require Tk}] {set tk_ok 0}

catch {
  vlib work
}

foreach {library file_list} $library_file_list {
  vlib $library
  vmap $library work
  foreach file $file_list {
    if [regexp {.vhdl?$} $file] {
    vcom -93 $file
    } else {
    vlog $file
    }
  }
}

puts {
  *************************************************************************************************
  All files successfully compiled. You may now run the .do scripts that are prefixed with 'run_test' 
  *************************************************************************************************

  Q: wHaT iS rEc0P?????
  A: You asking questions that make NO SENSE

}