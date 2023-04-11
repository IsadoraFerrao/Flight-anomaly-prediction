with Ada.Text_IO;
use Ada.Text_IO;
with Xml.Dom;
with Xml.Dom.Reader;
--with xml_tag;                  use xml_tag;

--with XMLAda.SAX;
--use XMLAda.SAX;

procedure Parse_XML_With_SAX is
   procedure Start_Element_Handler (Name : String) is
   begin
      Put_Line ("Start element: " & Name);
   end Start_Element_Handler;

   procedure End_Element_Handler (Name : String) is
   begin
      Put_Line ("End element: " & Name);
   end End_Element_Handler;

   procedure Character_Data_Handler (Data : String) is
   begin
      Put_Line ("Character data: " & Data);
   end Character_Data_Handler;

begin
   Parse (File => "file.xml", 
          Start_Element => Start_Element_Handler, 
          End_Element => End_Element_Handler, 
          Character_Data => Character_Data_Handler);
end Parse_XML_With_SAX;

