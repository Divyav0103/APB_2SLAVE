QuestaSim vlog 10.6c Compiler 2017.07 Jul 25 2017
Start time: 16:06:42 on Jun 06,2025
vlog -sv "+acc" "+cover" "+fcover" -l apb_top.apb_top.sv 
Usage: vlog [options] files
Options:
  -help              Print this message
  -version           Print the version of the compiler
  -32                Run in 32-bit mode
  -64                Run in 64-bit mode
  -work <path>       Specify library WORK
  -fatal <msgNumber>[,<msgNumber>...]
                     Report the listed messages as fatal
  -error <msgNumber>[,<msgNumber>...]
                     Report the listed messages as errors
  -warning <msgNumber>[,<msgNumber>...]
                     Report the listed messages as warnings
  -warning error     Report all warnings as errors
  -note <msgNumber>[,<msgNumber>...]
                     Report the listed message as notes
  -suppress <msgNumber>[,<msgNumber>...]
                     Suppress the listed messages
  -msglimit [all,|none,][-|+]<msgNumber>[,[-|+]<msgNumber>...]
                     Limit the reporting of listed messages to default count
  -msglimitcount <limit_value> -msglimit [all,|none,][-|+]<msgNumber>[,[-|+]<msgNumber>...]
                     Limit the reporting of listed messages to user defined count
  -msgsingleline     Display the messages in a single line.
  -svfilesuffix=<extension>[,<extension>...]
                     filename extensions for SystemVerilog code
  -93                Preserve the case of Verilog module (and parameter
                     and port) names in the equivalent VHDL entity by using
                     VHDL-1993 extended identifiers; this may be useful
                     in mixed-language designs
  -afs_check         Dump XML information from compilation unit scope
  -ams               Enable AMS wreal extensions
  -wireasinterconnect               Convert qualifying nets from wire to interconnect.
  -wireasinterconnectverbose       Identify which nets have been converted from wire to interconnect.
  -addpragmaprefix <prefix>
                     Enable recognition of synthesis and coverage pragmas with
                     a user specified prefix.
  --------  Access Control and Debug Options  --------
      These options help maximize simulation performance while retaining access
      to objects of interest. The effect of this option is limited only to
      those design units being compiled in the current vlog session.
  +acc[=<spec>]
                     <spec> consists of one or more of the following letter codes:
                        m (module, program, and interface instances)
                        n (nets)
                        p (ports)
                        r (variables and parameters)
                        t (task and function scopes)
  -assertdebug       Allow to debug SVA/PSL objects, with vsim -assertdebug
  -bitscalars        Preserve access to net bits
  -cellaccess        Preserve access to cell internal objects
  -fsmdebug          Finite state machine recognition and debugging
  -floatparameters   Don't lock down parameter values during optimization.
                     This enables use of the vsim -g/G options on the affected
                     parameters.
  -linedebug         line debugging
  -nosparse          Instructs the tool not to mark memories as sparse
                     by default.
  -primitiveaccess   Preserve access to primitive instances
  -randmetastable    Inject 0/1 randomly if timing violation occurs
  -systfoverride     Enable override of built-in system tasks
  --------
  -compat            Disable optimizations that result in different event ordering
                     than Verilog-XL (at expense of performance).
  -ccflags "opts"
                     Specify in quotes all the C/C++ compiler options for vlog/qverilog
  -dpicpppath <path_to_gcc>
                     Specify desired GCC path for DPI compilation
  -dpicppinstall <[gcc|g++] version>
                     Specify the version of the desired GNU compiler supported 
                     and distributed by Mentor for the DPI compilation
  -ccwarn [on|off|verbose|strict]
                     Enable additional error/warning gcc flags with C/C++ files compilation
                     Options are:
                        on (default): compiles with -Wreturn-type, -Wimplicit, 
                            -Wuninitialized,  -Wmissing-declarations gcc options
                        off: compiles without any warning options
                        verbose: compiles with the -Wall gcc option
                        strict: compiles with the -Werror gcc option
  -compile_uselibs[=<directory_name>]
                     Use the `uselib directive to find verilog source files
                     and compile them into automatically created libraries
  -cuname <compilation_unit_name>
                     Explicitly name the compilation unit package. The option
                     can only be used with -mfcu. The <compilation_unit_name>
                     can be top design unit name at vsim and vopt commandline
  -cuautoname=[file|du]
                     Select method for naming $unit library entries.
                     file - base the name of the first file on the command line (default)
                     du   - base the name on the first design unit following items
                            found in the $unit scope
  -createlib[=compress]
                     Create libraries that do not exist.
                     The =compress modifier creates compressed libraries.
  -nocreatelib       Do not create libraries that do not exist.
  +cover[=<spec>]
                     <spec> is used to enable code coverage metrics for certain
                     kinds of constructs.
                     <spec> consists of one or more of the following letter codes:
                        s (statement)
                        b (branch)
                        c (condition)
                        e (expression)
                        f (finite state machine)
                        t (toggle)
                        x (extended toggle)
                     If no <spec> characters are given, sbceft is the default.
  -coverenhanced     Enables functionality which may change the appearance or content of coverage
                     metrics. A detailed list of these changes can be found by searching in the
                     release notes for 'coverenhanced'. This option only takes meaningful effect in
                     letter releases (e.g. 10.2b). It has no effect in initial major releases (e.g. 10.2).
  -coveropt <i>      Specify a digit for code coverage optimization level: 1 through 4.
  -coverexcludedefault Automatically exclude case default clauses.
  -coverfec          Enable Focused Expression Coverage analysis for conditions and expressions.
  -nocoverfec        Disable Focused Expression Coverage analysis for conditions and expressions.
  -coverrec          Enable Rapid Expression Coverage mode of FEC for conditions and expressions.
  -nocoverrec        Disable Rapid Expression Coverage mode of FEC for conditions and expressions.
  -coverudp          Enable UDP Coverage analysis for conditions and expressions.
  -nocoverudp        Disable UDP Coverage analysis for conditions and expressions.
  -nocovershort      Disable short circuiting of expressions/condition when coverage is enabled.
  -coverexpandrdpfx  Bit-blast multi-bit operands of reduction prefix expressions for expression/condition coverage.
  -nocoverexpandrdpfx Don't bit-blast multi-bit operands of reduction prefix expressions for expression/condition coverage.
  -nocoverexcludedefault Don't automatically exclude case default clauses.
  -covercells        Enable code coverage options in cells.
  -nocovercells      Disable code coverage options in cells.
  -covercebi         Enable collapse of else-begin-if to an 'elsif' equivalent for coverage.
  -nocovercebi       Disable collapse of else-begin-if to an 'elsif' equivalent for coverage.
  -constimmedassert  Show constant immediate assertions in GUI/UCDB/reports etc.
  -togglecountlimit n Quit collecting toggle info after count n is reached.
  -togglewidthlimit n Don't collect toggle data on reg's or arrays wider than n.
  -extendedtogglemode [1|2|3]
                     Change the level of support for extended toggles.
                     The levels of support are:
                     1 - 0L->1H & 1H->0L & any one 'Z' transition (to/from 'Z')
                     2 - 0L->1H & 1H->0L & one transition to 'Z' & one transition from 'Z'
                     3 - 0L->1H & 1H->0L & all 'Z' transitions
  -toggleportsonly   Enable toggle statistics collection only for ports.
  -maxudprows n      Max number of rows allowed in UDP tables for code coverage.
  -maxfecrows n      Max number of input patterns allowed in FEC table for code coverage.
  -fecudpeffort n    Limit the size of expressions and conditions considered for expr/cond coverage.
                     Levels supported are:
                     1 - (low) Only small expressions and conditions considered for coverage.
                     2 - (medium) Bigger expressions and conditions considered for coverage.
                     3 - (high) Very large expressions and conditions considered for coverage.
  -coverreportcancelled Report coverage items that have been optimized away.
  -coverdeglitch <period> Report only the last execution of non-clocked processes/continuous assignments
                     within time greater than <period>, where <period> is 0 or
                     a time string with units
  -define <macro_name>[=<macro_text>]
                     Alternative to +define+ that allows + symbol in macros.
  +define+<macro_name>[=<macro_text>]
                     Same as compiler directive: `define macro_name macro_text
  -deglitchalways    Make always blocks insensitive to variable
                     glitches, potentially breaking zero delay oscillations
                     among combinatorial always blocks. (default)
  -nodeglitchalways  Disable -deglitchalways behavior.
  +delay_mode_distributed
                     Use structural delays and ignore path delays
  +delay_mode_path   Set structural delays to zero and use path delays
  +delay_mode_unit   Set non-zero structural delays to one
  +delay_mode_zero   Set structural delays to zero
  -dpiforceheader    Force generation of dpi header file even when
                     empty of function prototypes
  -dpiheader <filename>
                     Save the generated declarations of SystemVerilog DPI
                     tasks and functions into <filename>
  -E <filename>      Write preprocessed Verilog and SystemVerilog into <filename>
  -Epretty <filename>
                     Write pretty preprocessed Verilog and SystemVerilog into <filename>
  -Edebug <filename>
                     Write debugable preprocessed Verilog and SystemVerilog into <filename>
  -enumfirstinit     Initialize an enum using its first elem.
  -f <filename>      Specify a file containing more command line arguments
  -F <filename>      Specify a file containing more command line arguments. Prefixes relative
                     file names within the arguments file with the absolute path of arguments file,
                     if lookup with relative path fails.
  -outf <filename>   Specify a file to save the final list of options after recursively expanding
                     all -f, -file and -F files.
  -force_refresh     Force a refresh of the library image from .dat file(s)
                     even if there are dependency errors
  -optionset <optionset_name>
                     Calls an option set in modelsim.ini.
  -nofsmresettrans   Disable recognition of implicit asynchronous reset transitions for FSMs
  -fsmresettrans     Enable recognition of implicit asynchronous reset transitions for FSMs
  -nofsmsingle       Disable recognition FSMs having single bit current state variable
  -fsmsingle         Enable recognition FSMs having single bit current state variable
  -fsmimplicittrans  Enable recognition of implicit transitions in FSMs
  -nofsmimplicittrans Disable recognition of implicit transitions in FSMs
  -fsmmultitrans     Enable recognition of Multi-state transitions in FSMs
  -fsmverbose [b|t|w]
                     Provides information about FSMs recognized, including state reachability analysis.
                     There are three detail levels that can be set with this option.
                        b (displays only basic information)
                        t (displays a transition table in addition to the basic information)
                        w (displays any warning messages in addition to the basic information)
                     If no character is specified, btw is the default.
  -nofsmxassign      Disable recognition of FSMs containing x assignment
  -fsmxassign        Enable recognition of FSMs containing x assignment
  -gen_xml <entity> <output>
                     Output (into a file) the interface definition of the
                     specified design unit in XML format
  -gen_xmlstruct <entity> <output>
                     Similar to -gen_xml, but also output the structural definition
                     of the specified design unit in XML format
  -ignorepragmaprefix <prefix>
                     Ignore synthesis and coverage pragmas with specified prefix
  -immedalways       Run combinatorial always blocks with the same high priority as
                     continuous assignments and primitives in order to miminize the
                     effect of optimizations on race dependent results.
  -noimmedalways     Disable -immedalways behavior. (default)
  -hazards           Enable run-time hazard checking code
  +incdir+<dir>      Search directory for files included with
                     `include "filename"
  -incr              Enable incremental compilation
  +initmem[=<spec>][+0|1|X|Z]
                     Initialize fixed-size arrays of type indicated by <spec>.
  +initreg[=<spec>][+0|1|X|Z]
                     Initialize variables of type indicated by <spec>.
                     Valid values of <spec> are:
                        r (4-state integral types)
                        b (2-state integral types)
                        e (enum types)
                        u (udp types)
                     If no <spec> is given, all these types are enabled.
                     If 0|1|X|Z is specified, all the bits in the variable
                     are intialized to that value.  Otherwise, these variables
                     are prepared for randomization during vsim.
  +initwire[+0|1|X|Z]
                     Initialize unconnected wires with given value.
                     If no value is given, unconnected wires are initialized with 0.
  +iterevaluation    Enable an iterative evaluation mechanism on optimized gate-level
                     cells with feedback loops.
  -L <libname>       Search library for design units needed when optimizing
  -Lf <libname>      Same as -L, but libraries are searched before `uselib
  -Ldir <dirname>    Specify the container folder for libraries passed with -L & -Lf options.
  -libverbose[=libmap]
                     Verbose messaging about library mappings, search and resolution.
                     The =libmap modifier prints library map pattern matching information.
  -l <filename>      Write compilation log to <filename>
  +libext+<suffix>   Specify suffix of files in library directory
  -libmap <path>     Specify Verilog 2001 library map file
  +librescan         Scan libraries in command line order for all
                     unresolved module references
  -line <lineNum>    Specify a starting line number
  -lint              Perform lint-style checks
  -lowercasepragma   Allow only lower case pragmas
  -lowercasepslpragma   Allow only lower case PSL pragmas
  -modelsimini <modelsim.ini>
                     Specify path to the modelsim.ini file
  +maxdelays         Use maximum timing from min:typ:max expressions
  -mfcu[=macro]      Multi-file compilation unit, all files in command line make up a compilation unit.
                     The =macro modifier only enables the visibility of macro definitions across different files.
                     The default is to have each file be a separate compilation unit (-sfcu mode).
  +mindelays         Use minimum timing from min:typ:max expressions
  -mixedansiports    Enables mixing of ANSI-style and non-ANSI-style declarations
  -nodebug[=ports][=pli][=ports+pli]
                     Do not put symbolic debugging information into the library
  -nodbgsym
                     Do not generate symbols debugging database
  -smartdbgsym
                     Generate symbols debugging database for only some special cases
  -noexcludeternary <design_unit>
                     Disables exclusion of ternary expressions in UCDB.
  -noForceUnsignedToVhdlInteger
                     Prevents conversion of untyped parameters to integer.
  -noincr            Forces complete analysis and code generation, effectively turning
                     off incremental compilation
  +nolibcell         Do not automatically define library modules as cells(default)
  +libcell           Define library modules (found with -v|-y search) as cells
  -nologo            Disable startup banner
  -[w]prof=<filename> Enables CPU (-prof) or WALL (-wprof) time based profiling
                      and saves the profile data to the given filename.
  -proftick=<integer> Set the time interval between the profile data collection.
                      Default value is 10.
  -nooverrideundef <macro_name>
                     Do not ignore `undef if the macro is defined using +define option
  -nopsl             Disable embedded PSL language parsing
  -novopt            Do not run the "vopt" compiler before simulation
  +nospecify         Disable specify path delays and timing checks
  +notimingchecks    Disable timing checks
  -nowarn <number>   Disable specified category of warning messages; verror 1907 to see them
  +nowarn<CODE>      Disable specified warning message
  +num_opt_cell_conds+<value> 
                     Restricts gate-level optimization capacity for accepting cells with
                     I/O path and timing check conditions.
                     <value> integer between 32 and 1023, inclusive. where the default 
                     value is 1023.
  -noconstimmedassert  Do not show constant immediate assertions in GUI/UCDB/reports etc.
  -O0                Disable optimizations
  -O1                Enable some optimizations
  -O4                Enable most optimizations (default)
  -O5                Enable additional compiler optimizations
  -pedanticerrors    Enforce strict language checks
  -permissive        Relax some language error checks to warnings.
  -printinfilenames[=<filename>]
                     Print path names for all source files opened during compilation.
  +protect[=<file>]  Enable protection/encryption-related compiler directives
  -pslext            Enable PSL LTL/Universal operators
  -pslfile <file>    Compile and bind PSL vunits specified by <file>
  -quiet             Disable 'Loading' messages
  -R [<simargs>]     Cause vsim to be invoked with <simargs> and top-level
                     modules; simargs consists of the rest of the arguments
                     or until a single-character dash is encountered
  -                  Indicate end of optional -R <simargs>
  -refresh           Refresh the library image from .dat file(s)
  -scdpiheader <filename>
                     Save the generated declarations of SystemVerilog SystemC DPI
                     tasks and functions into <filename>
  -sfcu              Single-file compilation unit (default),
                     each file in command line is a separate compilation unit
  -skipprotected     Ignore protected regions
  -skipprotectedmodule Ignore modules containing protected regions
  -skipsynthoffregion Ignore all constructs within synthesis_off or translate_off pragma regions.
  -source            Print the source line with error messages
  -stats[=[+-]<args>] Enables compiler statistics
                     <args> are all,none,time,cmd,msg,perf,verbose,list,kb
  -sv                Enable SystemVerilog features and keywords
  -sv_pragma         Compiles SystemVerilog code that follows sv_pragma keyword in a single line or multi-line comment.
  -sv05compat        Ensure compatibility with IEEE standard 1800-2005
  -sv09compat        Ensure compatibility with IEEE standard 1800-2009
  -sv12compat        Ensure compatibility with IEEE standard 1800-2012
  -svinputport=net|var|relaxed
                     Select the default kind for an input port that is
                     declared with a type, but without the var keyword.
                     Select 'net' for strict LRM compliance, where the
                     kind always defaults to wire. Select 'var' for
                     non-compliant behavior, where the kind always defaults
                     to var. The default is 'relaxed', where only a
                     type that is a 4-state scalar or 4-state single
                     dimension vector type defaults to wire.
  -svext[=[+|-]<extension>[,[+|-]<extension>]*]
                     Enable SystemVerilog language extensions.
                     Valid extensions are:
                     acum  - Assignment Compatible Untyped Mailbox.
                     ared  - Iterate over innermost array elements for array reduction methods.
                     arif  - Allow ref args in fork.
                     arraymode - Consider rand_mode of unpacked array field independently from its elements.
                     aswe  - Allow symmetric wild equality operator.
                     atpi  - Allow Types in Port Identifiers.
                     bstr  - Allow usage of string builtin method bittostr.
                     catx  - Concat extensions.
                     ctlc  - Cast time literal in constraint context to time datatype.
                     ddup  - Drive default unconnected port.
                     defervda - Defer variable declaration assignments until after top-blocking always are sensitized.
                     dmsbw - Drive MSB unconnected bits of the wider hiconn (output) or the wider loconn (input) in an otherwise collapsible port connection.
                     evdactor - Do early variable declaration assignments in constructors.
                     evis  - Expand Environment Variables within Include String literals.
                     alltsic - Allow local lookup of this & super in inline constraints.
                     feci  - Treat constant expressions in foreach loop variable indices as constant.
                     fin0  - $finish() system call works as $finish(0), prints no diagnostic information.
                     hiercross1 - Allow hierarchical cross feature.
                     hiercross2 - Allow an alternate hierarchical cross feature.
                     ias   - Iterate on always @* evaluations until inputs settle.
                     idcl  - Pass import DPI call location as implicit scope.
                     iddp  - Ignore DPI disable protocol check.
                     altdpiheader - Alternative style function signature generated in DPI header.
                     mewq  - Allow macro expansion within quotes for string literals.
                     mttd  - Within macro expansion treat ``" as `".
                     noexptc  - ignore DPI export SV type name overloading check
                     ifca  - Iterate on feedback continuous assignment until inputs settle.
                     sffi  - Allow same function and formal identifier in case of functions with void return type.
                     islm  - Ignore String Literals within Macros.
                     mtdl  - Macro expansion treats `" more like a string literal.
                     ncref - Ref formal in covergroup new is not treated as constant ref.
                     scref - Ref formal in covergroup sample is treated as constant ref.
                     pae1  - Automatically export all symbols imported(referenced or not) in a package.
                     pae   - Automatically export all symbols imported and referenced in a package.
                     pctap - Promote Concat To Assignment Pattern using heuristics such as presence of unsized literals.
                     qcat  - Allow use of an assignment pattern for concatenating onto a queue.
                     realrand - Support randomize() with real variables and constraints (Default).
                     sas   - Strict LRM @* implicit sensitivity (whole variable and net identifiers rather than longest static prefix).
                     sccts - String concatenation convert to string.
                     sceq  - Allow string comparison with case equality operator.
                     spsl  - Search for packages in source libraries specified with -y and +libext.
                     stop0 - $stop() system call works as $stop(0), prints no diagnostic information.
                     substr1 - Allow one argument in substr() builtin method. Second argument will be end of string.
                     tzas  - Run a top-blocking always @* at time zero, same as is done for an always_comb.
                     ubdic - Allows the use of a variable in a SystemVerilog class before it is defined.
                     udm0  - UnDefined Macro is assume to be defined as the value 1'b0.
                     uslt  - Promote unused design units to top-level design units.
                     vmctor- Honor virtual method calls in class constructor.
  -tbxhvllint[=<fileName>][+ignorepkgs[=[[<lib1>.]<pkg1>]...[,[<libN>.]<pkgN>]]]
                     The -tbxhvllint switch causes the compiler to warn about delays found in the source
                     code that may cause synchronization issues in Veloce TBX.
                     NOTE: If you plan to use vsim's -tbxhvllint switch to extract run time delay
                     ----- information then you must use this switch with the compiler.
                     - The #delay warnings may be captured in the optional file <fileName>.
                     - Additionally, the switch '+ignorepkgs' allows you to suppress #delay warnings from
                       imported packages. The '+ignorepkgs' without any arguments will suppress warnings
                       related to all #delays found in all the imported packages. You may fine tune the
                       message suppression by specifying package names (with optional library names). For
                       example '-tbxhvllint+ignorepkgs=uvm_pkg' will cause messages related to #delays
                       found in any package named 'uvm_pkg' (regardless of the library). Specifying
                       '-tbxhvllint+ignorepkgs=mylib.mypkg' will suppress #delay messages related to
                       imported package 'mypkg' from library 'mylib'.
                     - Multiple '-tbxhvllint' switches are allowed.
  -timescale[=]<timescale>
                     Specify the default timescale for modules not having an
                     explicit timescale. The format of <timescale> is the same
                     as that of the `timescale directive.
                     For example, -timescale "1 ns / 1 ps".
  -override_timescale[=]<timescale>
                     Override the timescale specified in the source code.
  -override_precision
                     Override the precision of timescale specified in the source code.
  +typdelays         Use typical timing from min:typ:max expressions
  -s                 Do not load the std package.
  -u                 Convert regular Verilog identifiers to uppercase
  -v <path>          Specify Verilog source library file
  -vv                Print auto C/C++ compile/link subprocess command line information
  -vlog95compat      Ensure compatibility with Std 1364-1995
  -vlog01compat      Ensure compatibility with Std 1364-2001
  -convertallparams  Enables converting parameters not defined in ANSI style
                     to VHDL generics of type std_logic_vector, bit_vector,
                     std_logic and bit.
  -mixedsvvh [b | s | v] [packedstruct]
                     Facilitates using SV packages at the SV-VHDL mixed-language boundary.
                        b - treat scalars/vectors in package as bit/bit_vector
                        s - treat scalars/vectors in package as std_logic/std_logic_vector
                        v - treat scalars/vectors in package as vl_logic/vl_logic_vector
                        packedstruct - treat packed structures as VHDL arrays of equivalent size
  -vopt              Run the "vopt" compiler before simulation
  -y <path>          Specify Verilog source library directory
  -vmake             Collects complete list of command line args and files processed for use by vmake.
  -writetoplevels <fileName>
                     Writes complete list of toplevels into <fileName> (also includes the name specified
                     with -cuname). The file <fileName> can be used with vopt command's -f switch.
