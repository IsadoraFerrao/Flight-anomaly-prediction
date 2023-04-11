 #!/bin/sh
 
 #!==============ANALYSIS========================================
 #!==============================================================
 #! package
 ghdl -a -fexplicit --ieee=synopsys spacewirecodecippackage.vhdl
 
 #! composants de Link Interface
 ghdl -a -fexplicit --ieee=synopsys SpaceWireCODECIPReceiverSynchronize.vhdl
 ghdl -a -fexplicit --ieee=synopsys SpaceWireCODECIPTransmitter.vhdl
 ghdl -a -fexplicit --ieee=synopsys SpaceWireCODECIPStateMachine.vhdl
 ghdl -a -fexplicit --ieee=synopsys SpaceWireCODECIPTimer.vhdl
 ghdl -a -fexplicit --ieee=synopsys SpaceWireCODECIPStatisticalInformationCount.vhdl
 ghdl -a -fexplicit --ieee=synopsys SpaceWireCODECIPTimeCodeControl.vhdl
 ghdl -a -fexplicit --ieee=synopsys SpaceWireCODECIPLinkInterface.vhdl
 
 #! composants pour CODECIP
 ghdl -a -fexplicit --ieee=synopsys SpaceWireCODECIPFIFO9x64.vhdl
 ghdl -a -fexplicit --ieee=synopsys SpaceWireCODECIPSynchronizeOnePulse.vhdl
 ghdl -a -fexplicit --ieee=synopsys SpaceWireCODECIP.vhdl

 #! ===========ELABORATE=========================================
 #! =============================================================
 #!ghdl -e -fexplicit --ieee=synopsys SpaceWireCODECIP
 
 #! ===========RUN===============================================
 #! =============================================================
 #!ghdl -r -fexplicit --ieee=synopsys SpaceWireCODECIP
 
 exit 0
