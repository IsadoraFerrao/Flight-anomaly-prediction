with Ada.Strings.Unbounded;
with Input_Sources.File; use Input_Sources.File;
with Sax.Readers;        use Sax.Readers;
with DOM.Readers;        use DOM.Readers;
with DOM.Core;           use DOM.Core;
with DOM.Core.Documents; use DOM.Core.Documents;
with DOM.Core.Nodes;     use DOM.Core.Nodes;
with DOM.Core.Attrs;     use DOM.Core.Attrs;
with Ada.Text_IO;        use Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Containers; use Ada.Containers;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
--with Ada.Strings.Search; use Ada.Strings.Search;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings;       use Ada.Strings;
with Ada.Command_Line; use Ada.Command_Line;



procedure main is
   Input  : File_Input;
   Reader : Tree_Reader;
   Doc    : Document;
   List   : Node_List;
   N      : Node;
   Name   : Node;
   A      : Attr;



   ------
   function Str(int : Integer) return String is
   begin
      return Trim(Integer'Image(int),Ada.Strings.Left);
   end Str;



   -----

   --type Unbounded_String is new Unbounded_String;

   type Component_Type is (Router, Cpu, Undef);



   type Connection_SPW is record
      Component1_Type : Component_Type;
      Component1_Id : Integer;
      Component1_Port_Id : Integer;
      Component2_Type : Component_Type;
      Component2_Id : Integer;
      Component2_Port_Id : Integer;
   end record;

   --type Connection_SPW_List is array (Positive range <>) of Connection_SPW;
   package Connection_SPW_Vectors is new Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Connection_SPW);


   type Component_Cpu is record
      Cpu_Id : Integer;
      Connections_Cpu_Router : Connection_SPW_Vectors.Vector;
   end record;

   --type Integer_Array is array (Positive range <>) of Connection_SPW;
   package Integer_Vectors is new Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Integer);

   type Component_Router is record
      Router_Id : Integer;
      Connections_Router_Router : Connection_SPW_Vectors.Vector;
   end record;

   type Connections_Routers is record
      Connections_Router_Router : Connection_SPW_Vectors.Vector;
      Ids_Routers_Processed : Integer_Vectors.Vector;
   end record;

   --type Component_Cpu_List is array (Positive range <>) of Component_Cpu;
   package Component_Cpu_Vectors is new Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Component_Cpu);
   package Component_Router_Vectors is new Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Component_Router);




   function Extract_id (Name : Unbounded_String) return Integer is
      Id : Integer;
      --Elements : Text_I;
      Id_Str : Unbounded_String;
      Length : Integer;
      Search_Char : Character := '_';
   begin
      --Elements := Split(Str, '_');
      Id := 0;
      Length := Ada.Strings.Unbounded.Length(Name);
      for i in reverse 1..Length loop
         -- code to be executed in each iteration
         --Put_Line("char is : " & Element(Name, i));
         if Ada.Strings.Unbounded.Element(Name, i) = Search_Char then
            --Put_Line("Extract_id is : " & Slice(Name, i+1, Length));
            return  Integer'Value(Slice(Name, i+1, Length));
         end if;
      end loop;
      --Put_Line("Extract_id is : " & To_String(Id_Str));
      return Id;
   end Extract_id;



   function Get_Connections_From_Outputs (Outputs : Node_List; Component1_Type : Component_Type; Component1_Id : Integer) return  Connection_SPW_Vectors.Vector is
      Connections_Cpu_Router_var : Connection_SPW_Vectors.Vector;
      Connection_Output : Connection_SPW;
      Output_name, Other_Component_Port_Name : Unbounded_String;
      Name_Node, Connection_Node, Other_Component_Name_Node, Other_Component_Id_Node, Other_Component_Port_Name_Node : Node;
   begin

      for Index in 1 .. Length (Outputs) loop
         Name_Node := First_Child(Item (Outputs, Index - 1));
         Output_name :=  To_Unbounded_String(Node_Value(First_Child(Name_Node)));

         if Has_Child_Nodes(Next_Sibling(Name_Node))  then

            Connection_Node := First_Child(Next_Sibling(Name_Node));

            Other_Component_Name_Node := First_Child(Connection_Node);
            Other_Component_Id_Node := Next_Sibling(Other_Component_Name_Node);
            Other_Component_Port_Name_Node := Next_Sibling(Other_Component_Id_Node);
            Other_Component_Port_Name :=  To_Unbounded_String(Node_Value(First_Child(Other_Component_Port_Name_Node)));

            Connection_Output.Component1_Type := Component1_Type;
            Connection_Output.Component1_Id := Component1_Id;
            Connection_Output.Component1_Port_Id := Extract_id(Output_name);
            Connection_Output.Component2_Type := Router;
            Connection_Output.Component2_Id := Integer'Value(Value(First_Child(Other_Component_Id_Node)));
            Connection_Output.Component2_Port_Id := Extract_id(Other_Component_Port_Name);

            if Value(First_Child(Other_Component_Name_Node)) = "router_tb" then
               Connections_Cpu_Router_var.append(Connection_Output);
            end if;
         end if;
         --Put_Line("Output name is : " & Node_Value(First_Child(First_Child(Item (Outputs, Index - 1)))));
         --Put_Line("Extract_id is : " & Extract_id(Output_name)'Image);
         --Put_Line("Output name is : " & Node_Value(First_Child(First_Child(Item (Outputs, Index - 1)))));

      end loop;
      return Connections_Cpu_Router_var;
   end Get_Connections_From_Outputs;




   function Get_Connections_Cpu_Router (N : Node) return  Connection_SPW_Vectors.Vector is
      Connections_Cpu_Router_var : Connection_SPW_Vectors.Vector;
      Cpu_Outputs : Node_List;
      Cpu_Childs :Node_List;
   begin
      Cpu_Childs := Child_Nodes(N);
      for Index in 1 .. Length (Cpu_Childs) loop
         if  Node_Name(Item (Cpu_Childs, Index - 1)) = "outputs" then
            --Put_Line("The outputs node is finded :" & Node_Name(Item (Cpu_Childs, Index - 1)));
            Cpu_Outputs := Child_Nodes(Item (Cpu_Childs, Index - 1));
            Connections_Cpu_Router_var := Get_Connections_From_Outputs(Cpu_Outputs, Cpu, Integer'Value(Value(Get_Named_Item(Attributes (N), "id"))));
            return Connections_Cpu_Router_var;
         end if;
      end loop;
      return Connections_Cpu_Router_var;
   end Get_Connections_Cpu_Router;



   --function Get_Component_List (L : Node_List) return Integer is
   function Get_Cpu_Component_List (L : Node_List) return Component_Cpu_Vectors.Vector is
      Components_Cpu : Component_Cpu_Vectors.Vector;
      Connections_Cpu_Router_var : Connection_SPW_Vectors.Vector;
      New_Component : Component_Cpu ;--:= ( Connections_Cpu_Router => Connections_Cpu_Router_var);
   begin
      -- If the parameter is greater than 10, return a null variable


      --Components_Cpu(Components_CpuLength) := New_Component;
      --Put_Line ("Components_Cpu Length : " & Count_Type'Image(Components_Cpu.Length));

      for Index in 1 .. Length (L) loop
         N := Item (L, Index - 1);
         A := Get_Named_Item (Attributes (N), "id");
         Name := First_Child(N);
         if Node_Value (First_Child (Name)) = "cpu_tb" then
            --Put_Line ("Component Id : """ & Value (A) & """ and name is : " & Node_Value (First_Child (Name)));
            New_Component.Cpu_Id := Integer'Value(Value(A));
            New_Component.Connections_Cpu_Router := Get_Connections_Cpu_Router(N);
            Components_Cpu.append(New_Component);
            --Put_Line ("Components_Cpu  Id : " & Str(New_Component.Cpu_Id));
         end if;
      end loop;
      --Put_Line ("Components_Cpu Length : " & Count_Type'Image(Components_Cpu.Length));
      return Components_Cpu;
   end Get_Cpu_Component_List;

   function Convert_Vector_To_String_With_Delimiter(integer_vector : Integer_Vectors.Vector; delimiter : String) return Unbounded_String is
      String_Converted : Unbounded_String;
   begin
      for I in integer_vector.First_Index .. integer_vector.Last_Index loop
         if I = 0 then
            Append(String_Converted, Str(integer_vector(I)));
         else
            Append(String_Converted, delimiter);
            Append(String_Converted, Str(integer_vector(I)));
         end if;
      end loop;
       --To_Unbounded_String();
      return String_Converted;
   end Convert_Vector_To_String_With_Delimiter;

   function Get_Routers_Tb_Ids(Components_Router : Component_Router_Vectors.Vector) return Integer_Vectors.Vector is
      routers_tb_ids : Integer_Vectors.Vector;
   begin
      for I in Components_Router.First_Index .. Components_Router.Last_Index loop
         routers_tb_ids.Append(Components_Router(I).Router_Id);
      end loop;
      return routers_tb_ids;
   end Get_Routers_Tb_Ids;

   function Get_Cpus_String_To_Be_Inserted(Components_Cpu : Component_Cpu_Vectors.Vector; Components_Router : Component_Router_Vectors.Vector) return Unbounded_String is
      Cpus_String_To_Be_Inserted : Unbounded_String;
      routers_tb_ids : Integer_Vectors.Vector;

      interfaces_len : Integer := 0;
      routers_ids : Integer_Vectors.Vector;--for each interface
      port_ids : Integer_Vectors.Vector;--for each interface

      --processors_len : Integer
      cpu_ids : Integer_Vectors.Vector;-- for each processor
      cpu_interfaces_len : Integer_Vectors.Vector;-- for each processor
      cpu_interfaces_offsets : Integer_Vectors.Vector;-- for each processor

   begin
      routers_tb_ids := Get_Routers_Tb_Ids(Components_Router);
      --processors_len := Components_Cpu.Length;
      for I in Components_Cpu.First_Index .. Components_Cpu.Last_Index loop
         cpu_interfaces_offsets.append(interfaces_len+1);
         cpu_ids.Append(Components_Cpu(I).Connections_Cpu_Router(0).Component1_Id);
         for J in Components_Cpu(I).Connections_Cpu_Router.First_Index .. Components_Cpu(I).Connections_Cpu_Router.Last_Index loop
            --Put_Line(Integer'image(Components_Cpu(I).Connections_Cpu_Router(J).Component1_Port_Id));
            routers_ids.Append(routers_tb_ids.Find_Index(Components_Cpu(I).Connections_Cpu_Router(J).Component2_Id)+1);
            port_ids.Append(Components_Cpu(I).Connections_Cpu_Router(J).Component2_Port_Id);
            interfaces_len := interfaces_len +1;
         end loop;


         cpu_interfaces_len.Append(Integer(Components_Cpu(I).Connections_Cpu_Router.Length));

      end loop;
      Append(Cpus_String_To_Be_Inserted, "--Generated Code"&ASCII.LF);
      Append(Cpus_String_To_Be_Inserted, "constant interfaces_len : integer :="&Integer'Image(interfaces_len)&";"&ASCII.LF);
      Append(Cpus_String_To_Be_Inserted, "constant  router_ids : integer_array(1 to interfaces_len) := ("&To_String((Convert_Vector_To_String_With_Delimiter(routers_ids,", ")))&");"&ASCII.LF);
      Append(Cpus_String_To_Be_Inserted, "constant  port_ids : integer_array(1 to interfaces_len) := ("&To_String((Convert_Vector_To_String_With_Delimiter(port_ids,", ")))&");"&ASCII.LF);

      Append(Cpus_String_To_Be_Inserted, "constant processors_len : integer :="&Count_Type'Image(Components_Cpu.Length)&";"&ASCII.LF);
      Append(Cpus_String_To_Be_Inserted, "constant  cpu_ids : integer_array(1 to processors_len) := ("&To_String((Convert_Vector_To_String_With_Delimiter(cpu_ids,", ")))&");"&ASCII.LF);
      Append(Cpus_String_To_Be_Inserted, "constant  cpu_interfaces_len : integer_array(1 to processors_len) := ("&To_String((Convert_Vector_To_String_With_Delimiter(cpu_interfaces_len,", ")))&");"&ASCII.LF);
      Append(Cpus_String_To_Be_Inserted, "constant  cpu_interfaces_offsets : integer_array(1 to processors_len) := ("&To_String((Convert_Vector_To_String_With_Delimiter(cpu_interfaces_offsets,", ")))&");"&ASCII.LF);
      Append(Cpus_String_To_Be_Inserted, "--End Generated Code"&ASCII.LF);


      return Cpus_String_To_Be_Inserted;
   end Get_Cpus_String_To_Be_Inserted;

   ---------------- Router Router Connections Extract Functions ------------------


   function Get_Connections_Router_Router (N : Node) return  Connection_SPW_Vectors.Vector is
      Connections_Router_Router_var : Connection_SPW_Vectors.Vector;
      Router_Outputs : Node_List;
      Router_Childs :Node_List;
   begin
      Router_Childs := Child_Nodes(N);
      for Index in 1 .. Length (Router_Childs) loop
         if  Node_Name(Item (Router_Childs, Index - 1)) = "outputs" then
            --Put_Line("The outputs node is finded :" & Node_Name(Item (Router_Childs, Index - 1)));
            Router_Outputs := Child_Nodes(Item (Router_Childs, Index - 1));
            --Put_Line("The outputs node is finded :" & Node_Name(Item (Router_Childs, Index - 1)));
            Connections_Router_Router_var := Get_Connections_From_Outputs(Router_Outputs, Router, Integer'Value(Value(Get_Named_Item(Attributes (N), "id"))));
            return Connections_Router_Router_var;
         end if;
      end loop;
      return Connections_Router_Router_var;
   end Get_Connections_Router_Router;



   function Get_Router_Component_List (L : Node_List) return Component_Router_Vectors.Vector is
      Components_Router : Component_Router_Vectors.Vector;
      --Connections_Router_Router_var : Connection_SPW_Vectors.Vector;
      New_Component : Component_Router ;--:= ( Connections_Cpu_Router => Connections_Cpu_Router_var);
   begin
      for Index in 1 .. Length (L) loop
         N := Item (L, Index - 1);
         A := Get_Named_Item (Attributes (N), "id");
         Name := First_Child(N);
         if Node_Value (First_Child (Name)) = "router_tb" then
            --Put_Line ("Component Id : """ & Value (A) & """ and name is : " & Node_Value (First_Child (Name)));
            New_Component.Router_Id := Integer'Value(Value(A));
            --Put_Line("Router Id :" & Value (A));
            New_Component.Connections_Router_Router := Get_Connections_Router_Router(N);
            Components_Router.append(New_Component);
            --Put_Line ("Components_Cpu  Id : " & Str(New_Component.Cpu_Id));
         end if;
      end loop;
      --Put_Line ("Components_Cpu Length : " & Count_Type'Image(Components_Cpu.Length));
      return Components_Router;
   end Get_Router_Component_List;

   function Get_Router_Router_Connections_Without_Repitition (Components_Router : Component_Router_Vectors.Vector) return  Connection_SPW_Vectors.Vector is
      Ids_Routers_Processed : Integer_Vectors.Vector;
      Connections : Connection_SPW_Vectors.Vector;
      Connections_Temp_Var : Connection_SPW_Vectors.Vector;
   begin

      for I in Components_Router.First_Index .. Components_Router.Last_Index loop
         Connections_Temp_Var := Components_Router(I).Connections_Router_Router;
         for J in Connections_Temp_Var.First_Index .. Connections_Temp_Var.Last_Index loop
            if not Ids_Routers_Processed.Contains(Connections_Temp_Var(J).Component1_Id) and not Ids_Routers_Processed.Contains(Connections_Temp_Var(J).Component2_Id) then
              Connections.Append(Connections_Temp_Var(J));
            end if;
         end loop;
         Ids_Routers_Processed.Append(Components_Router(I).Router_Id);
      end loop;
      return Connections;
   end Get_Router_Router_Connections_Without_Repitition;




   function Get_Routers_String_To_Be_Inserted(Components_Router : Component_Router_Vectors.Vector) return Unbounded_String is
      Routers_String_To_Be_Inserted : Unbounded_String;
      Connections : Connection_SPW_Vectors.Vector;
      routers_tb_ids : Integer_Vectors.Vector;
   begin
      routers_tb_ids := Get_Routers_Tb_Ids(Components_Router);

      Append(Routers_String_To_Be_Inserted, "--Generated Code"&ASCII.LF);
      Append(Routers_String_To_Be_Inserted, "constant routers_len : integer := "&Count_Type'Image(routers_tb_ids.Length)&";"&ASCII.LF);
      if routers_tb_ids.Length<2 then
         --routers_tb_ids.Append(1);
	Append(Routers_String_To_Be_Inserted, "constant  router_tb_ids : integer_array(1 to"&Count_Type'Image(routers_tb_ids.Length)&") := (others => "&Str(routers_tb_ids(0))&");"&ASCII.LF);
      else 
      Append(Routers_String_To_Be_Inserted, "constant  router_tb_ids : integer_array(1 to"&Count_Type'Image(routers_tb_ids.Length)&") := ("&To_String((Convert_Vector_To_String_With_Delimiter(routers_tb_ids,", ")))&");"&ASCII.LF);
      end if;
      Append(Routers_String_To_Be_Inserted, "--End Generated Code"&ASCII.LF);
      return Routers_String_To_Be_Inserted;
   end Get_Routers_String_To_Be_Inserted;


   function Get_Routers_Connections_String_To_Be_Inserted(Components_Router : Component_Router_Vectors.Vector) return Unbounded_String is
      Routers_Connections_String_To_Be_Inserted : Unbounded_String;
      Connections : Connection_SPW_Vectors.Vector;
      routers_tb_ids : Integer_Vectors.Vector;
      Router1_Id : Integer;
      Router1_Port_Id : Integer;
      Router2_Id : Integer;
      Router2_Port_Id : Integer;
   begin
      routers_tb_ids := Get_Routers_Tb_Ids(Components_Router);
      Connections := Get_Router_Router_Connections_Without_Repitition(Components_Router);

      for I in Connections.First_Index .. Connections.Last_Index loop

         Router1_Id := routers_tb_ids.Find_Index(Connections(I).Component1_Id)+1;
         Router1_Port_Id := Connections(I).Component1_Port_Id;
         Router2_Id := routers_tb_ids.Find_Index(Connections(I).Component2_Id)+1;
         Router2_Port_Id := Connections(I).Component2_Port_Id;

         Append(Routers_Connections_String_To_Be_Inserted, "--Generated Code"&ASCII.LF);
         Append(Routers_Connections_String_To_Be_Inserted, "routerslinksIn("&Str(Router1_Id)&")("&Str(Router1_Port_Id)&") <= routerslinksOut("&Str(Router2_Id)&")("&Str(Router2_Port_Id)&");"&ASCII.LF);
         Append(Routers_Connections_String_To_Be_Inserted, "routerslinksIn("&Str(Router2_Id)&")("&Str(Router2_Port_Id)&") <= routerslinksOut("&Str(Router1_Id)&")("&Str(Router1_Port_Id)&");"&ASCII.LF);
	 Append(Routers_Connections_String_To_Be_Inserted, "--End Generated Code"&ASCII.LF);
      end loop;

      return Routers_Connections_String_To_Be_Inserted;
   end Get_Routers_Connections_String_To_Be_Inserted;

   ------------------ Test functions ----------------------------------
   procedure Print_Connection(conn :Connection_SPW) is
   begin
      Put_Line("Component1_Type : " & Component_Type'Image(conn.Component1_Type));
      Put_Line("Component1_Id : " & Str(conn.Component1_Id));
      Put_Line("Component1_Port_Id : " & Str(conn.Component1_Port_Id));
      Put_Line("Component2_Type : " & Component_Type'Image(conn.Component2_Type));
      Put_Line("Component2_Id : " & Str(conn.Component2_Id));
      Put_Line("Component2_Port_Id : " & Str(conn.Component2_Port_Id));
   end Print_Connection;

   procedure Print_Connections(connections_vector :Connection_SPW_Vectors.Vector) is
   begin
      for I in connections_vector.First_Index .. connections_vector.Last_Index loop
         Put_Line("------Connection Number " & Str(I));
         Print_Connection(connections_vector(I));
      end loop;

   end Print_Connections;

   procedure Print_Cpus(cpus_vector :Component_Cpu_Vectors.Vector) is
   begin
      for I in cpus_vector.First_Index .. cpus_vector.Last_Index loop
         Put_Line("********Cpu Id " & Str(cpus_vector(I).Cpu_Id));
         Print_Connections(cpus_vector(I).Connections_Cpu_Router);
      end loop;

   end Print_Cpus;

   procedure Print_Routers(routers_vector :Component_Router_Vectors.Vector) is
   begin
      for I in routers_vector.First_Index .. routers_vector.Last_Index loop
         Put_Line("********Router Id " & Str(routers_vector(I).Router_Id));
         Print_Connections(routers_vector(I).Connections_Router_Router);
      end loop;
   end Print_Routers;

   ---------------- File Operations and Formatting ---------------
   type Replace_Record is record
      From : Unbounded_String;
      To : Unbounded_String;
   end record;
   package Replace_Records is new Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Replace_Record);
   procedure Show_Simple_Text_File_IO(File_Name:String; replace_records_var : Replace_Records.Vector) is
      F         : File_Type;
   begin
      Create (F, Out_File, File_Name);
      Put_Line (F, "Hello World #1");
      Put_Line (F, "Hello World #2");
      Put_Line (F, "Hello World #3");
      Close (F);

      Open (F, In_File, File_Name);
      while not End_Of_File (F) loop
         Put_Line (Get_Line (F));
      end loop;
      Close (F);
   end Show_Simple_Text_File_IO;


   procedure Format_Template_File_IO(File_Name_In:String; File_Name_Out:String; replace_records_var : Replace_Records.Vector) is

      File_In         : File_Type;
      File_Out         : File_Type;
      Current_Line : Unbounded_String;
      Current_Line_Is_To_Replace : Boolean := False;
      Code : Character := Character'Val(13);
      --File_Name : constant String := "simple.txt";
   begin

      Open (File_In, In_File, File_Name_In);
      Create (File_Out, Out_File, File_Name_Out);
      while not End_Of_File (File_In) loop
         Current_Line := To_Unbounded_String(Get_Line (File_In)) ;
	 --Put_Line(To_String(Current_Line));
	 --Put_Line("{code_to_be_inserted}");
	 --Put_Line(Natural'Image(Length(Current_Line)));
	 --Put_Line(Natural'Image(Length(To_Unbounded_String("{code_to_be_inserted}"))));
         for I in replace_records_var.First_Index .. replace_records_var.Last_Index loop
            if To_String(replace_records_var(I).From)&Code = Trim(Trim(To_String(Current_Line), Ada.Strings.Right),  Ada.Strings.Left) then
               Put_Line (File_Out, To_String(replace_records_var(I).To));
               Current_Line_Is_To_Replace := True;
            end if;
         end loop;

         if not Current_Line_Is_To_Replace then
            Put_Line (File_Out, To_String(Current_Line));
         end if;
         Current_Line_Is_To_Replace := False;
         --Put_Line (Get_Line (File_In));
      end loop;
      Close (File_In);
      Close (File_Out);

   end Format_Template_File_IO;

   -------------------



   ------------ Generate a Cheddar.txt example ------------
   -- this is used only for test --

   procedure Generate_Example_Cheddar_Txt(Components_Cpu : Component_Cpu_Vectors.Vector; dest_node_id : Integer; File_Name_Out : String) is
      Cheddar_task_id_ref : Integer:=102;
      File_Out : File_Type;
   begin
      Create (File_Out, Out_File, File_Name_Out);
      for I in Components_Cpu.First_Index .. Components_Cpu.Last_Index loop
         Put_Line (File_Out, Str(Cheddar_task_id_ref)&" "&Str(Components_Cpu(I).Cpu_Id)&" "&Str(dest_node_id)& " 50");
         Cheddar_task_id_ref := Cheddar_task_id_ref + 1;
      end loop;
      Close (File_Out);
   end Generate_Example_Cheddar_Txt;

   --------------------------------------------------------


   Components_Cpu : Component_Cpu_Vectors.Vector;
   Cpus_String_To_Be_Inserted : Unbounded_String;
   Routers_String_To_Be_Inserted : Unbounded_String;
   Routers_Connections_String_To_Be_Inserted : Unbounded_String;
   Components_Router : Component_Router_Vectors.Vector;
   --Connections_Router_Router_Without_Repitition : Connection_SPW_Vectors.Vector;

   replace_records_var : Replace_Records.Vector;
   File_Name_In : constant String := "TbSpaceWireNetwork_Template.vhd";
   File_Name_Out : constant String := "TbSpaceWireNetwork.vhd";
   replace_recod_var : Replace_Record;

   XmlFile_Path : Unbounded_String := To_Unbounded_String(Argument(1));
   DirectoryPathOfGeneratedFiles_Path : Unbounded_String := To_Unbounded_String(Argument(2));

begin


   Set_Public_Id (Input, "file");
   Open (To_String(XmlFile_Path), Input);

   Set_Feature (Reader, Validation_Feature, False);
   Set_Feature (Reader, Namespace_Feature, False);

   Parse (Reader, Input);
   Close (Input);

   Doc := Get_Tree (Reader);

   List := Get_Elements_By_Tag_Name (Doc, "component");

   Components_Router := Get_Router_Component_List(List);

   Components_Cpu := Get_Cpu_Component_List(List);
   --Print_Cpus(Components_Cpu);
   Cpus_String_To_Be_Inserted := Get_Cpus_String_To_Be_Inserted(Components_Cpu, Components_Router);
   Put_Line(To_String(Cpus_String_To_Be_Inserted));

   --Print_Routers(Components_Router);
   --Print_Connections(Components_Router(0).Connections_Router_Router);
   --Connections_Router_Router_Without_Repitition := Get_Router_Router_Connections_Without_Repitition(Components_Router);
   --Print_Connections(Connections_Router_Router_Without_Repitition);
   Routers_String_To_Be_Inserted := Get_Routers_String_To_Be_Inserted(Components_Router);
   Put_Line(To_String(Routers_String_To_Be_Inserted));

   Routers_Connections_String_To_Be_Inserted := Get_Routers_Connections_String_To_Be_Inserted(Components_Router);
   Put_Line(To_String(Routers_Connections_String_To_Be_Inserted));

   replace_recod_var.From := To_Unbounded_String("{code_to_be_inserted}");
   replace_recod_var.To := Cpus_String_To_Be_Inserted;
   replace_records_var.Append(replace_recod_var);

   replace_recod_var.From := To_Unbounded_String("{code_to_be_inserted}");
   replace_recod_var.To := Routers_String_To_Be_Inserted;
   replace_records_var.Append(replace_recod_var);

   replace_recod_var.From := To_Unbounded_String("{connection_to_be_inserted}");
   replace_recod_var.To := Routers_Connections_String_To_Be_Inserted;
   replace_records_var.Append(replace_recod_var);

   Format_Template_File_IO(File_Name_In, To_String(DirectoryPathOfGeneratedFiles_Path)&File_Name_Out, replace_records_var);

   --Generate_Example_Cheddar_Txt(Components_Cpu, 1, "cheddar.txt");

   Free (List);
   Free (Reader);
end main;
