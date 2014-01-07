#!/usr/bin/perl -w
use warnings;
print "Make ConTeXt project -- 2002-05-17\n";
print "copyleft 2002 Henning Hraban Ramm\n";
print "Thankfully adopted by Markus Gattol, Mai 2008\n\n";


@Level       = ("environment", "project", "product", "component");
@Prefix      = ("envi_", "proj_", "prod_", "comp_"); # file prefixes
$Suffix      = ".tex";                               # ending
$IniSuffix   = ".ini";                               # ending for defaults files

$Command     = $ARGV[0];
if (!$Command) {$Command=".";}
$validCommand = 0;
$ProjectPath = ".";     # default path = actual path


if ($Command =~ m/^--/) {               # if first parameter starts with --
        $Command =~ s/^--//;            # delete --
        ($Command eq "help") && help(); # show help, if wanted
        if ($Command =~ m/[0-3]/) { $Command = $Level[$Command]; } # if --0 etc.
        for ($count=@Level-1; $count>0; $count--) { # iterate all levels
                if ($Command eq $Level[$count]) { # if command matches level
                        unless ($ARGV[1]) { # if no second command line parameter
                                my $missname = $Level[$count-1];
                                if ($missname eq $Level[0]) { $missname = $Level[1]; }
                                help("$missname name is missing!");
                        } # if no second parameter
                        if (($count>1) and (!$ARGV[2])) { # with level 2 we need 2 parameters
                                help($Level[$count]." name is missing!");
                        } # if no third parameter
                        $validCommand=1;        # ok, print no help
                        print "making ".$Level[$count]."...\n";
                        MakeFile($count, $ARGV[1], $ARGV[2]);
                } # if
        } # for
        ($Command eq "all") && help("option --all is not yet implemented.\n");
        ($validCommand) && exit(0); # exit without error
} # if --parameter

help("Don't know what to do!"); # help function ends with exit

### END

###
sub MakeFile { # gets level number and two other args (project/product or product/component)
###
        my $ActLev = $_[0];
        my $ProjectName=$_[1];
        my $ProductName=$_[2];
        my $InKey="";
        my $ProjectLine="";
        if ($ProjectName =~ m/^.*[\/\\:]/) { # look for folder delimiters
                $ProjectName = $';      # '
                chop($ProjectPath = $&);
                $ProjectPath =~ tr$\:\/\\$/$;   # change all delimiters to UNIX slashes
        } # if
        if (ProductName =~ m/^.*[\/\\:]/) { # delete other path
                $ProductName = $';      # '
        }
        if (!$ProductName) { $ProductName=$ProjectName; }
        unless (-d $ProjectPath) { # test path
                (-f $ProjectPath) && die "$ProjectPath is a file!\n";
                print("making $ProjectPath...");
                mkdir($ProjectPath) or die "Cannot make dir $ProjectPath: $!";
        } # if no path
        $FileName = $ProjectPath."/".$Prefix[$ActLev].$ProductName.$Suffix;
        (-d $FileName) && die "$FileName is a directory!\n";



# Insert entry in next level file
        if ($ActLev > 1) { # insert product and component into next level
                my @FileList = ();
                my $Count = 0;
                $ProjectFileName = $ProjectPath."/".$Prefix[$ActLev-1].$ProjectName.$Suffix;
                print "Inserting ".$Prefix[$ActLev].$ProductName." into ".$Level[$ActLev-1]." ".$ProjectFileName."...\n";
                open (myFILE, $ProjectFileName) or warn "Cannot open $ProjectFileName: $!";
                while (<myFILE>) {
                        $FileList[$Count] = $_;
                        if (($ActLev==3) && (m/\\project/)) { # if component
                                $ProjectLine = $_;
                        } # if component and project line in product file
                        if (m/\\stop$Level[$ActLev-1]/) { $StopPos = $Count; }
                        if (m/$Prefix[$ActLev]$ProductName/) {
                                $Exist = 1;
                                print "Entry exists already.\n";
                        }
                        $Count++;
                } # while myFILE
                close (myFILE);
                if (!$Exist) {
                        open (myFILE, ">".$ProjectFileName) or warn "Cannot open $ProjectFileName: $!";
                        for ($Count=0; $Count < @FileList; $Count++) {
                                if ($Count == $StopPos) {
                                        print myFILE "\t\\".$Level[$ActLev]." ".$Prefix[$ActLev].$ProductName."\n";
                                } # if StopPos
                                print myFILE $FileList[$Count];
                        } # for
                        close (myFILE);
                }
        } # insert product and component into next level



# Make this level file
        if (-f $FileName) {
                print "$FileName exists. May I overwrite it? (YJ/N, Return)\n";
                while ($InKey !~ m/[JYN]/i) {
                        $InKey= "";
                        print "?";
                        $InKey = getc;
                } # while
        } # if file exists
        $IniFile = $Level[$ActLev].$IniSuffix; # defaults for every level

        if ($InKey !~ m/N/i) {
                print "Making $FileName...\n";
                open (myFILE, ">".$FileName) or die "Cannot make $FileName: $!";

                ($ActLev == 1) && print myFILE "% output=pdf interface=en\n";
                print myFILE "\\start".$Level[$ActLev]." ".$Prefix[$ActLev].$ProductName."\n";
                if (!$ActLev) { $tempLev=1; } else { $tempLev=$ActLev-1; }
                print myFILE "\\$Level[$tempLev] ".$Prefix[$tempLev].$ProjectName."\n";
                ($ProjectLine) && print myFILE $ProjectLine;
                print myFILE "\n";
                if ($ActLev==1) {
                        print myFILE "%  \\showlayout\n";
                        print myFILE "%  \\showgrid\n";
                        print myFILE "%  \\showbodyfontenvironment\n";
                } # if project
                if (-f $IniFile) { # look for .ini file in script dir
                        open (iniFILE, $IniFile) or warn "Cannot open $IniFile: $!";
                        print "inserting $IniFile into $FileName...\n";
                        while (<iniFILE>) { print myFILE;} # while
                        close (iniFILE) or warn "Cannot close $IniFile: $!";
                }
                $IniFile = $ProjectPath."/".$IniFile;
                if ((-f $IniFile) && ($ProjectPath ne ".")) { # look for .ini file in project dir
                        open (iniFILE, $IniFile) or warn "Cannot open $IniFile: $!";
                        print "inserting $IniFile into $FileName...\n";
                        while (<iniFILE>) { print myFILE;} # while
                        close (iniFILE) or warn "Cannot close $IniFile: $!";
                }
                print myFILE "\n";
                print myFILE "\\stop$Level[$ActLev]\n";
                print myFILE "\n";

                close (myFILE) or die "Cannot close $FileName: $!";

        } # if InKey not N
        ($ActLev == 1) && MakeFile(0,$ProjectPath."/".$ProjectName,$ProductName); # project makes environment

} # sub MakeFile



###
sub help {
###
        ($_[0]) && print "ERROR: $_[0]\n\n";
        print "Syntax: makeproject --help\n";
        print "        will give this help\n\n";
        print "......: makeproject --project <projectname>\n";
        print "        will make $Prefix[1]<projectname>$Suffix and $Prefix[0]<projectname>$Suffix\n\n";
        print "......: makeproject --product <projectname> <productname>\n";
        print "        will make $Prefix[2]<productname>$Suffix and add it to $Prefix[1]<projectname>$Suffix\n\n";
        print "......: makeproject --component <productname> <componentname>\n";
        print "        will make $Prefix[3]<componentname>$Suffix and add it to $Prefix[2]<productname>$Suffix\n\n";
#       print "......: makeproject --all <productname>\n";
#       print "        will make all of the files, asks after names\n";
        print "Path should be only in first name!\n";
        exit(1);
} # sub help
