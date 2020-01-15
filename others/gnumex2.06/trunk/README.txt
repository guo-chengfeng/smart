SUMMARY OF GNUMEX USAGE

For more information see the detailed guidelines in [1].  Gnumex enables mex files
for C, C++ and Fortran to be created with gcc, and subsequently called from
Matlab. The following steps are involved:

INSTALL COMPILER:
	See [1].

 RUN GNUMEX. Cd to the folder where Gnumex is installed and type "gnumex"
   at the Matlab prompt. This brings up a GUI-window. Make appropriate choices
   (see [1]) and select "Make opts".

   If easy switching between compilers (or other Gnumex options) is desired
   it may be easier to add the Gnumex folder to the Matlab search path and
   use Gnumex in batch mode. Issue "gnumex usage" for a quick help.

   This will create libraries of mex-, mx- and mat-functions ready to be called
   from C or Fortran programs (in Matlab 7.4 and later a preliminary step is
   the creation of .def-files in the Gnumex folder). Gnumex will also create a
   configuration file for the Matlab mex-command, called "options.bat" by
   default. The configuration file sets gcc to be the compiler, and a
   perl-script, linkmex.pl, that is part of Gnumex to be the linker. It also
   points to the libraries, and sets appropriate options for the compilation
   and linking.

   There are two sensible choices for the configuration file, in the Matlab
   "prefdir" folder (e.g. "C:\Documents and Settings\jonasson\Application
   Data\MathWorks\MATLAB\R2007a"; its location is returned by the Matlab
   prefdir command) or in the folder where the sources of the C (or Fortran)
   programs are.

WRITE A GATEWAY ROUTINE in C or Fortran which will be called from Matlab and
   calls the computational routines. The gateway routine must be named
   mexFunction. For details refer to the Matlab documentation.

TO CREATE MEX-FILES use the Matlab mex command. It will by default look for a
   config file named "mexopts.bat" in the current folder, and if not found
   there in the prefdir folder. One can also use a -f switch to point to a
   different config file. For details, see the Matlab documentation on "mex",
   and the link therein to "mex script switches" (note for instance that it is
   possible to override the default flags from Gnumex with commands such as
   "mex -c OPTIMFLAGS='$OPTIMFLAGS -o2 yprime.c" -- before version 7.3 or 7.2
   one must use # instead of =). Mex compiles and links C or Fortran programs
   and creates mex-files with the extension .mexw32 (.dll in Matlab 7.0 and
   earlier) callable from Matlab. With a -c switch, mex compiles only and
   creates files with extension .obj -- .obj files are valid inputs for
   subsequent mex-commands.

EXAMPLE C MEXING: See example in Examples\GCC.

ACCOMPANYING DOCUMENTATION AND EXAMPLE FILES:
	EXAMPLES			Folder of examples for various compilers
	README              This file
	changes.txt         Lists changes after Gnumex version 1.11
	TODO				List of things that needs done
	

ERROR IN MEX.PL IN MATLAB 7.10 AND 7.11
   There is a bug in the file [matlabroot '/bin/mex.pl']: Line 809 should be:
       $IMPLICIT_LIBS = getValidInputLinkLibraries();
   (the brackets are missing---many thanks to "anonymous" and "Simon" for
   finding this error). The error caused mex to fail because it ended up
   thinking that getValidInputLinkLibraries was a library. I was not able to
   find a way around the error, so I ended up having gnumex automatically
   correcting the Matlab distribution. This correction may fail if mex.pl is
   not writeable. Gnumex issues a warning if this happens. If the file cannot
   be made writeable, a possible workaround is to copy the m-file mex_helper.m
   and the mex.pl file from the Matlab distribution to a local folder, make sure
   that folder is early in the the Matlab search path, correct the bug in mex.pl
   manually, and edit mex_helper.m to make matlab_bin_location point to the
   location of mex.pl. The error has been reported to Mathworks.

HOW TO CHECK GNUMEX OUT-FROM/IN-TO SVN REPOSITORY AND RELEASE
   The following Unix command will check out gnumex from the sourceforge svn
   repository to a folder gnumex in the current folder:
     svn co https://gnumex.svn.sourceforge.net/svnroot/gnumex/trunk .
   Developers can check in by issuing (from the gnumex folder):
     svn commit -m 'Description-of-change'
   Developer k10 can release using:
     scp gnumex.zip k10,gnumex@frs.sourceforge.net:/home/frs/project/g/gn/gnumex/gnumex-X.YY.zip
   Developer k10 can login to repository with:
     ssh -t k10,gnumex@shell.sourceforge.net create
   
REFERENCES
   [1] http://gnumex.sourceforge.net

Kristjan Jonasson, September 2007 (jonasson@hi.is)
Jason Nicholson, March 2014	jashale@yahoo.com