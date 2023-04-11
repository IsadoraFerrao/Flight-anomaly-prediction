-- S. Rubini, A. Le boudec

-- library
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
USE ieee.numeric_std.all;

library work;
use work.SpaceWireCODECIPPackage.all;
--use work.SpaceWireRouterIPPackage.all;
use std.textio.all;
use work.TbSpaceWireTypes.all;

entity TbSpaceWireNetwork is
end TbSpaceWireNetwork;

architecture struct of TbSpaceWireNetwork is
	component tbCpu is
		generic(
			CPU_NUMBER		: integer;
			cpu_interfaces_len : integer;
			CHEDDAR_TIME_UNIT       : time    := 1 us;
		    RCV_TRACE_FILE          : String  := "message.txt";
			SEND_TRACE_FILE		: String  := "cheddar.txt"
		);
		port (
			networkReady	: in std_logic;
			clock		: in std_logic;
			receiveClock	: in std_logic;
			dataOut         : out FifoData(1 to cpu_interfaces_len); 
			writeEnable     : out std_logic_vector(1 to cpu_interfaces_len); 
			dataIn          : in  FifoData(1 to cpu_interfaces_len); 
			readEnable      : out std_logic_vector(1 to cpu_interfaces_len); 
			newdataIn	: in std_logic_vector(1 to cpu_interfaces_len); 
			NIstart        : out std_logic_vector(1 to cpu_interfaces_len)
		);
	end component tbCpu;

	component TbSpaceWireSixPortRouter is 
		generic (
			ROUTING_TABLE_FILE : String
		);
		port (
			signal reset            : std_logic;
			signal linksIn		: in  SpwLinks(1 to 6);
			signal linksOut		: out SpwLinks(1 to 6)
		);
	end component TbSpaceWireSixPortRouter;

	component SpaceWireCODECIP is
	    port (
	            clock                       : in  std_logic;
	            transmitClock               : in  std_logic;
	            receiveClock                : in  std_logic;
	            reset                       : in  std_logic;
	    --
	            transmitFIFOWriteEnable     : in  std_logic;
	            transmitFIFODataIn          : in  std_logic_vector(8 downto 0);
	            transmitFIFOFull            : out std_logic;
	            transmitFIFODataCount       : out std_logic_vector(5 downto 0);
	            receiveFIFOReadEnable       : in  std_logic;
	            receiveFIFODataOut          : out std_logic_vector(8 downto 0);
	            receiveFIFOFull             : out std_logic;
	            receiveFIFOEmpty            : out std_logic;
	            receiveFIFODataCount        : out std_logic_vector(5 downto 0);
	    --
	            tickIn                      : in  std_logic;
	            timeIn                      : in  std_logic_vector(5 downto 0);
	            controlFlagsIn              : in  std_logic_vector(1 downto 0);
	            tickOut                     : out std_logic;
	            timeOut                     : out std_logic_vector(5 downto 0);
	            controlFlagsOut             : out std_logic_vector(1 downto 0);
	    --
	            linkStart                   : in  std_logic;
	            linkDisable                 : in  std_logic;
	            autoStart                   : in  std_logic;
	            linkStatus                  : out std_logic_vector(15 downto 0);
	            errorStatus                 : out std_logic_vector(7 downto 0);
	            transmitClockDivideValue    : in  std_logic_vector(5 downto 0);
	            creditCount                 : out std_logic_vector(5 downto 0);
	            outstandingCount            : out std_logic_vector(5 downto 0);
	    --
	            transmitActivity            : out std_logic;
	            receiveActivity             : out std_logic;
	    --
	            spaceWireDataOut            : out std_logic;
	            spaceWireStrobeOut          : out std_logic;
	            spaceWireDataIn             : in  std_logic;
	            spaceWireStrobeIn           : in  std_logic;
	    --                
	            statisticalInformationClear : in  std_logic;
	            statisticalInformation      : out bit32X8Array
	    );
	end component SpaceWireCODECIP;

	--type   FifoData is array (natural range <>) of std_logic_vector(8 downto 0);
	type   Count    is array (natural range <>) of std_logic_vector(5 downto 0);
	type   ControlFlags    is array (natural range <>) of std_logic_vector(1 downto 0);
	type   Status    is array (natural range <>) of std_logic_vector(15 downto 0);
	type   Errors    is array (natural range <>) of std_logic_vector(7 downto 0);
	type   Statistics    is array (natural range <>) of bit32X8array;
	
	
	-- added code by jaafar
	type   RoutersLinks is array (natural range <>) of SpwLinks(1 to 6);
	type integer_array is array (natural range <>) of integer;
--Generated Code
constant interfaces_len : integer := 6;
constant  router_ids : integer_array(1 to interfaces_len) := (1, 1, 1, 1, 1, 1);
constant  port_ids : integer_array(1 to interfaces_len) := (5, 1, 3, 6, 2, 4);
constant processors_len : integer := 6;
constant  cpu_ids : integer_array(1 to processors_len) := (12, 13, 10, 14, 16, 11);
constant  cpu_interfaces_len : integer_array(1 to processors_len) := (1, 1, 1, 1, 1, 1);
constant  cpu_interfaces_offsets : integer_array(1 to processors_len) := (1, 2, 3, 4, 5, 6);
--End Generated Code

--Generated Code
constant routers_len : integer :=  1;
constant  router_tb_ids : integer_array(1 to 1) := (others => 9);
--End Generated Code

	signal clock 		   	: std_logic;
	signal transmitClock 		: std_logic;
	signal receiveClock 		: std_logic;
	signal reset 		   	: std_logic;
	-- codec fifos
	signal transmitFIFOWriteEnable	: std_logic_vector(1 to interfaces_len);
	signal transmitFIFODataIn	: FifoData(1 to interfaces_len);
	signal receiveFIFOReadEnable 	: std_logic_vector(1 to interfaces_len);
	
	-- links routers 
	signal routerslinksIn		: RoutersLinks(1 to routers_len);
	signal routerslinksOut		: RoutersLinks(1 to routers_len);
	
	
	-- links router 1
	--signal router1linksIn		: SpwLinks(1 to 6);
	--signal router1linksOut		: SpwLinks(1 to 6);
	-- time code in
	signal tickIn 			: std_logic;
	signal timeIn 			: Count(1 to interfaces_len);
	signal controlFlagsIn  		: ControlFlags(1 to interfaces_len);
	-- link control and status  in
	signal linkStart		: std_logic_vector(1 to interfaces_len);
	signal linkDisable		: std_logic_vector(1 to interfaces_len);
	signal autoStart		: std_logic;
	signal transmitClockDivideValue : std_logic_vector(5 downto 0);
	-- statistical in
	signal statisticalInformationClear : std_logic;

	signal transmitFIFOFull		: std_logic_vector(1 to interfaces_len);
	signal transmitFIFODataCount 	: Count(1 to interfaces_len);
	signal receiveFIFODataOut 	: FifoData(1 to interfaces_len);
	signal receiveFIFOFull		: std_logic_vector(1 to interfaces_len);
	signal receiveFIFOEmpty 	: std_logic_vector(1 to interfaces_len);
	signal newDataOut	 	: std_logic_vector(1 to interfaces_len);
	signal receiveFIFODataCount 	: Count(1 to interfaces_len);
	-- time code out
	signal tickOut			: std_logic_vector(1 to interfaces_len);
	signal timeOut			: Count(1 to interfaces_len);
	signal controlFlagsOut  	: ControlFlags(1 to interfaces_len);
	--link status control out
	signal linkStatus		: Status(1 to interfaces_len);
	signal errorStatus		: Errors(1 to interfaces_len);
	signal outstandingCount		: Count(1 to interfaces_len);
					-- credit count out
	signal creditCount 		: Count(1 to interfaces_len);
					-- read or write enable
	signal transmitActivity		: std_logic_vector(1 to interfaces_len);
	signal receiveActivity		: std_logic_vector(1 to interfaces_len);

	signal statisticalInformation	: Statistics(1 to interfaces_len);

	-- simulation
	signal spaceWireReady		: std_logic := '0';

	begin




		init : process
		begin
			reset <= '1';
			wait for 20 us;
			reset <= '0';
			wait for 10 us;
			spaceWireReady <= '1';
			wait;
		end process;


		routers : for router in 1 to routers_len generate
		begin
		
			router1 : entity work.TbSpaceWireSixPortRouter(struct)
				generic map (
					ROUTING_TABLE_FILE => "router_tb_"& integer'image(router_tb_ids(router))
				)
				port map (
					reset 		=> reset,
					linksIn 	=> routerslinksIn(router),
					linksOut	=> routerslinksOut(router)
				);		
		end generate;
		
	
		
		processors : for processor in 1 to processors_len generate			
		begin
			cpu : entity work.tbCpu(test) 
				generic map (
					
				    CPU_NUMBER	=> cpu_ids(processor),
					cpu_interfaces_len => cpu_interfaces_len(processor)
				)
				port map(
					networkReady	=> spaceWireReady,
					clock		=> clock,
					
					dataOut         => transmitFIFODataIn(cpu_interfaces_offsets(processor) to cpu_interfaces_offsets(processor)-1+cpu_interfaces_len(processor)),					
					writeEnable     => transmitFIFOWriteEnable(cpu_interfaces_offsets(processor) to cpu_interfaces_offsets(processor)-1+cpu_interfaces_len(processor)),   
					readEnable 	=> receiveFIFOReadEnable(cpu_interfaces_offsets(processor) to cpu_interfaces_offsets(processor)-1+cpu_interfaces_len(processor)),
					dataIn 		=> receiveFIFODataOut(cpu_interfaces_offsets(processor) to cpu_interfaces_offsets(processor)-1+cpu_interfaces_len(processor)),
					newDataIn 	=> newDataOut(cpu_interfaces_offsets(processor) to cpu_interfaces_offsets(processor)-1+cpu_interfaces_len(processor)),
					NIstart		=> linkStart(cpu_interfaces_offsets(processor) to cpu_interfaces_offsets(processor)-1+cpu_interfaces_len(processor))
	
			);
		
		end generate;

		
		
			
			

		-- global signal default values
		autoStart <='0';
		tickIn <= '0';
		transmitClockDivideValue <= "001001";   -- cf gInitializeTansmitClockDivideValue
		statisticalInformationClear <= '0';

		interfaces : for interface in 1 to interfaces_len generate
		begin	
			-- per interface default values
			linkDisable(interface) <= '0';
			timeIn(interface) <= "000000";
			controlFlagsIn(interface) <= "00";
			newDataOut(interface) <= '1' when receiveFIFOEmpty(interface)  ='0' else '0';
			
			networkInterface : entity work.SpaceWireCODECIP(Behavioral)
				port map(
					-- system clock, transmit and receive
					clock 		=> clock,                       
					transmitClock 	=> transmitClock,           
					receiveClock 	=> receiveClock,               
					reset 		=> reset,                       
					-- transmit data in
					transmitFIFOWriteEnable => transmitFIFOWriteEnable(interface),   
					transmitFIFODataIn      => transmitFIFODataIn(interface),         
					-- receive data in
					receiveFIFOReadEnable 	=> receiveFIFOReadEnable(interface),
					-- time code in
					tickIn 		=> tickIn,
					timeIn 		=> timeIn(interface),
					controlFlagsIn  => controlFlagsIn(interface),
					-- link control and status  in
					linkStart 	=> linkStart(interface),
					linkDisable 	=> linkDisable(interface),
					autoStart	=> autoStart,
					transmitClockDivideValue => transmitClockDivideValue,
					-- data and strobe in
					spaceWireDataIn   => routerslinksOut(router_ids(interface))(port_ids(interface)).data,
					spaceWireStrobeIn => routerslinksOut(router_ids(interface))(port_ids(interface)).strobe,
					-- statistical in
					statisticalInformationClear => statisticalInformationClear,

					-- transmit data out
					transmitFIFOFull 	=> transmitFIFOFull(interface),
					transmitFIFODataCount 	=> transmitFIFODataCount(interface),
					-- receive data out
					receiveFIFODataOut 	=> receiveFIFODataOut(interface),
					receiveFIFOFull     	=> receiveFIFOFull(interface),
					receiveFIFOEmpty    	=> receiveFIFOEmpty(interface),
					receiveFIFODataCount 	=> receiveFIFODataCount(interface),
					-- time code out
					tickOut 	=> tickOut(interface),
					timeOut 	=> timeOut(interface),
					controlFlagsOut => controlFlagsOut(interface),
					--link status control out
					linkStatus       => linkStatus(interface),
					errorStatus      => errorStatus(interface),
					outstandingCount => outstandingCount(interface),
					-- credit count out
					creditCount 	=> creditCount(interface),
					-- read or write enable
					transmitActivity => transmitActivity(interface),
					receiveActivity  => receiveActivity(interface),
					--data and strob out
					spaceWireDataOut   => routerslinksIn(router_ids(interface))(port_ids(interface)).data,
					spaceWireStrobeOut => routerslinksIn(router_ids(interface))(port_ids(interface)).strobe,
					-- statistical out               
					statisticalInformation => statisticalInformation(interface)
			); 
			

			-- error reports
			errorReport : process( transmitFIFOFull(interface), receiveFIFOFull(interface) )
			begin
				if transmitFIFOFull(interface) = '1' and reset='0' then
					report "Network Interface: Transmit FIFO full";
				end if;
				if receiveFIFOFull(interface) = '1' and reset='0' then
					report "Network Interface: Receive FIFO full";
				end if;

			end process errorReport;

	end generate;

	--=========clock 50 mhz=========
	--==============================	
	clocktime : process
	begin
		clock <= '0';
		wait for 10 ns;
		clock <= '1';
		wait for 10 ns;
	end process clocktime;


        --======transmitclock 100 mhz=====
        --================================
	transmitclockprocess : process
	begin
		transmitClock <= '0';
		wait for 5 ns;
		transmitClock <= '1';
		wait for 5 ns;
         end process transmitclockprocess;

         --=======receiveclock 166 mhz======
         --=================================
         receiveclockprocess : process
         begin
		receiveClock <= '0';
		wait for 3 ns;
              	receiveClock <= '1';
		wait for 3 ns;
         end process receiveclockprocess;

end struct;
        
        
        
        
        
        
        
