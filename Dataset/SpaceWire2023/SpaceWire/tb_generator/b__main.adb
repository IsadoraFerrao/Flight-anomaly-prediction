pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is

   E073 : Short_Integer; pragma Import (Ada, E073, "system__os_lib_E");
   E011 : Short_Integer; pragma Import (Ada, E011, "system__soft_links_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__exception_table_E");
   E068 : Short_Integer; pragma Import (Ada, E068, "ada__io_exceptions_E");
   E053 : Short_Integer; pragma Import (Ada, E053, "ada__strings_E");
   E036 : Short_Integer; pragma Import (Ada, E036, "ada__containers_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "system__exceptions_E");
   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links__initialize_E");
   E055 : Short_Integer; pragma Import (Ada, E055, "ada__strings__maps_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__strings__maps__constants_E");
   E041 : Short_Integer; pragma Import (Ada, E041, "interfaces__c_E");
   E079 : Short_Integer; pragma Import (Ada, E079, "system__object_reader_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "system__dwarf_lines_E");
   E035 : Short_Integer; pragma Import (Ada, E035, "system__traceback__symbolic_E");
   E104 : Short_Integer; pragma Import (Ada, E104, "ada__tags_E");
   E102 : Short_Integer; pragma Import (Ada, E102, "ada__streams_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "system__file_control_block_E");
   E110 : Short_Integer; pragma Import (Ada, E110, "system__finalization_root_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "ada__finalization_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "system__file_io_E");
   E189 : Short_Integer; pragma Import (Ada, E189, "ada__streams__stream_io_E");
   E130 : Short_Integer; pragma Import (Ada, E130, "system__storage_pools_E");
   E126 : Short_Integer; pragma Import (Ada, E126, "system__finalization_masters_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "system__storage_pools__subpools_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "ada__strings__unbounded_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "ada__text_io_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "ada__text_io__text_streams_E");
   E237 : Short_Integer; pragma Import (Ada, E237, "gnat__directory_operations_E");
   E175 : Short_Integer; pragma Import (Ada, E175, "system__pool_global_E");
   E148 : Short_Integer; pragma Import (Ada, E148, "unicode_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "sax__htable_E");
   E173 : Short_Integer; pragma Import (Ada, E173, "sax__pointers_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "unicode__ccs_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "unicode__ccs__iso_8859_1_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "unicode__ccs__iso_8859_15_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "unicode__ccs__iso_8859_2_E");
   E205 : Short_Integer; pragma Import (Ada, E205, "unicode__ccs__iso_8859_3_E");
   E207 : Short_Integer; pragma Import (Ada, E207, "unicode__ccs__iso_8859_4_E");
   E209 : Short_Integer; pragma Import (Ada, E209, "unicode__ccs__windows_1251_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "unicode__ccs__windows_1252_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "unicode__ces_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "sax__symbols_E");
   E235 : Short_Integer; pragma Import (Ada, E235, "sax__locators_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "sax__exceptions_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "unicode__ces__utf32_E");
   E217 : Short_Integer; pragma Import (Ada, E217, "unicode__ces__basic_8bit_E");
   E219 : Short_Integer; pragma Import (Ada, E219, "unicode__ces__utf16_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "unicode__ces__utf8_E");
   E231 : Short_Integer; pragma Import (Ada, E231, "sax__models_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "sax__attributes_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "sax__utils_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "dom__core_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "unicode__encodings_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "dom__core__nodes_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "dom__core__attrs_E");
   E227 : Short_Integer; pragma Import (Ada, E227, "dom__core__character_datas_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "dom__core__documents_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "dom__core__elements_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "input_sources_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "input_sources__file_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "input_sources__strings_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "sax__readers_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "dom__readers_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E225 := E225 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "dom__readers__finalize_spec");
      begin
         F1;
      end;
      E240 := E240 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "sax__readers__finalize_spec");
      begin
         F2;
      end;
      E246 := E246 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "input_sources__strings__finalize_spec");
      begin
         F3;
      end;
      E244 := E244 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "input_sources__file__finalize_spec");
      begin
         F4;
      end;
      E242 := E242 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "input_sources__finalize_spec");
      begin
         F5;
      end;
      E144 := E144 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "dom__core__finalize_spec");
      begin
         F6;
      end;
      E179 := E179 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "sax__utils__finalize_spec");
      begin
         F7;
      end;
      E229 := E229 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "sax__attributes__finalize_spec");
      begin
         F8;
      end;
      E233 := E233 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "sax__exceptions__finalize_spec");
      begin
         F9;
      end;
      E167 := E167 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "sax__symbols__finalize_spec");
      begin
         F10;
      end;
      E173 := E173 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "sax__pointers__finalize_spec");
      begin
         F11;
      end;
      E175 := E175 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "system__pool_global__finalize_spec");
      begin
         F12;
      end;
      E136 := E136 - 1;
      declare
         procedure F13;
         pragma Import (Ada, F13, "ada__text_io__finalize_spec");
      begin
         F13;
      end;
      E118 := E118 - 1;
      declare
         procedure F14;
         pragma Import (Ada, F14, "ada__strings__unbounded__finalize_spec");
      begin
         F14;
      end;
      E124 := E124 - 1;
      declare
         procedure F15;
         pragma Import (Ada, F15, "system__storage_pools__subpools__finalize_spec");
      begin
         F15;
      end;
      E126 := E126 - 1;
      declare
         procedure F16;
         pragma Import (Ada, F16, "system__finalization_masters__finalize_spec");
      begin
         F16;
      end;
      E189 := E189 - 1;
      declare
         procedure F17;
         pragma Import (Ada, F17, "ada__streams__stream_io__finalize_spec");
      begin
         F17;
      end;
      declare
         procedure F18;
         pragma Import (Ada, F18, "system__file_io__finalize_body");
      begin
         E140 := E140 - 1;
         F18;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E019 := E019 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E068 := E068 + 1;
      Ada.Strings'Elab_Spec;
      E053 := E053 + 1;
      Ada.Containers'Elab_Spec;
      E036 := E036 + 1;
      System.Exceptions'Elab_Spec;
      E021 := E021 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E013 := E013 + 1;
      E011 := E011 + 1;
      System.Os_Lib'Elab_Body;
      E073 := E073 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E059 := E059 + 1;
      Interfaces.C'Elab_Spec;
      E055 := E055 + 1;
      E041 := E041 + 1;
      System.Object_Reader'Elab_Spec;
      System.Dwarf_Lines'Elab_Spec;
      E048 := E048 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E035 := E035 + 1;
      E079 := E079 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E104 := E104 + 1;
      Ada.Streams'Elab_Spec;
      E102 := E102 + 1;
      System.File_Control_Block'Elab_Spec;
      E141 := E141 + 1;
      System.Finalization_Root'Elab_Spec;
      E110 := E110 + 1;
      Ada.Finalization'Elab_Spec;
      E100 := E100 + 1;
      System.File_Io'Elab_Body;
      E140 := E140 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E189 := E189 + 1;
      System.Storage_Pools'Elab_Spec;
      E130 := E130 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E126 := E126 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E124 := E124 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E118 := E118 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E136 := E136 + 1;
      Ada.Text_Io.Text_Streams'Elab_Spec;
      E185 := E185 + 1;
      Gnat.Directory_Operations'Elab_Spec;
      Gnat.Directory_Operations'Elab_Body;
      E237 := E237 + 1;
      System.Pool_Global'Elab_Spec;
      E175 := E175 + 1;
      Unicode'Elab_Body;
      E148 := E148 + 1;
      E165 := E165 + 1;
      Sax.Pointers'Elab_Spec;
      Sax.Pointers'Elab_Body;
      E173 := E173 + 1;
      Unicode.Ccs'Elab_Spec;
      E161 := E161 + 1;
      E195 := E195 + 1;
      E197 := E197 + 1;
      E202 := E202 + 1;
      E205 := E205 + 1;
      E207 := E207 + 1;
      E209 := E209 + 1;
      E214 := E214 + 1;
      Unicode.Ces'Elab_Spec;
      E157 := E157 + 1;
      Sax.Symbols'Elab_Spec;
      Sax.Symbols'Elab_Body;
      E167 := E167 + 1;
      E235 := E235 + 1;
      Sax.Exceptions'Elab_Spec;
      Sax.Exceptions'Elab_Body;
      E233 := E233 + 1;
      E159 := E159 + 1;
      E217 := E217 + 1;
      E219 := E219 + 1;
      E163 := E163 + 1;
      Sax.Models'Elab_Spec;
      E231 := E231 + 1;
      Sax.Attributes'Elab_Spec;
      Sax.Attributes'Elab_Body;
      E229 := E229 + 1;
      Sax.Utils'Elab_Spec;
      Sax.Utils'Elab_Body;
      E179 := E179 + 1;
      DOM.CORE'ELAB_SPEC;
      E144 := E144 + 1;
      E193 := E193 + 1;
      E183 := E183 + 1;
      E181 := E181 + 1;
      E227 := E227 + 1;
      E223 := E223 + 1;
      E221 := E221 + 1;
      Input_Sources'Elab_Spec;
      Input_Sources'Elab_Body;
      E242 := E242 + 1;
      Input_Sources.File'Elab_Spec;
      Input_Sources.File'Elab_Body;
      E244 := E244 + 1;
      Input_Sources.Strings'Elab_Spec;
      Input_Sources.Strings'Elab_Body;
      E246 := E246 + 1;
      Sax.Readers'Elab_Spec;
      Sax.Readers'Elab_Body;
      E240 := E240 + 1;
      DOM.READERS'ELAB_SPEC;
      DOM.READERS'ELAB_BODY;
      E225 := E225 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /home/test/Desktop/SpaceWire/tb_generator/main.o
   --   -L/home/test/Desktop/SpaceWire/tb_generator/
   --   -L/home/test/Desktop/SpaceWire/tb_generator/
   --   -L/usr/local/lib/xmlada/xmlada_unicode.static/
   --   -L/usr/local/lib/xmlada/xmlada_schema.static/
   --   -L/usr/local/lib/xmlada/xmlada_sax.static/
   --   -L/usr/local/lib/xmlada/xmlada_input.static/
   --   -L/usr/local/lib/xmlada/xmlada_dom.static/
   --   -L/usr/lib/gcc/x86_64-linux-gnu/8/adalib/
   --   -shared
   --   -lgnat-8
   --   -ldl
--  END Object file/option list   

end ada_main;
