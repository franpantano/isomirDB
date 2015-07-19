#!/bin/sh
# the next line restarts using wish\
exec wish "$0" "$@" 

if {![info exists vTcl(sourcing)]} {
    switch $tcl_platform(platform) {
	windows {
	}
	default {
	    option add *Scrollbar.width 10
	}
    }
    
}
#############################################################################
# Visual Tcl v1.51 Project
#

#################################
# VTCL LIBRARY PROCEDURES
#

if {![info exists vTcl(sourcing)]} {
proc Window {args} {
    global vTcl
    set cmd     [lindex $args 0]
    set name    [lindex $args 1]
    set newname [lindex $args 2]
    set rest    [lrange $args 3 end]
    if {$name == "" || $cmd == ""} { return }
    if {$newname == ""} { set newname $name }
    if {$name == "."} { wm withdraw $name; return }
    set exists [winfo exists $newname]
    switch $cmd {
        show {
            if {$exists} {
                wm deiconify $newname
            } elseif {[info procs vTclWindow$name] != ""} {
                eval "vTclWindow$name $newname $rest"
            }
            if {[wm state $newname] == "normal"} {
                vTcl:FireEvent $newname <<Show>>
            }
        }
        hide    {
            if {$exists} {
                wm withdraw $newname
                vTcl:FireEvent $newname <<Hide>>
                return}
        }
        iconify { if $exists {wm iconify $newname; return} }
        destroy { if $exists {destroy $newname; return} }
    }
}
}

if {![info exists vTcl(sourcing)]} {
proc {vTcl:DefineAlias} {target alias widgetProc top_or_alias cmdalias} {
    global widget

    set widget($alias) $target
    set widget(rev,$target) $alias

    if {$cmdalias} {
        interp alias {} $alias {} $widgetProc $target
    }

    if {$top_or_alias != ""} {
        set widget($top_or_alias,$alias) $target

        if {$cmdalias} {
            interp alias {} $top_or_alias.$alias {} $widgetProc $target
        }
    }
}

proc {vTcl:DoCmdOption} {target cmd} {
    ## menus are considered toplevel windows
    set parent $target
    while {[winfo class $parent] == "Menu"} {
        set parent [winfo parent $parent]
    }

    regsub -all {\%widget} $cmd $target cmd
    regsub -all {\%top} $cmd [winfo toplevel $parent] cmd

    uplevel #0 [list eval $cmd]
}

proc {vTcl:FireEvent} {target event} {
    foreach bindtag [bindtags $target] {
        set tag_events [bind $bindtag]
        set stop_processing 0
        foreach tag_event $tag_events {
            if {$tag_event == $event} {
                set bind_code [bind $bindtag $tag_event]
                regsub -all %W $bind_code $target bind_code
                set result [catch {uplevel #0 $bind_code} errortext]
                if {$result == 3} {
                    # break exception, stop processing
                    set stop_processing 1
                } elseif {$result != 0} {
                    bgerror $errortext
                }
                break
            }
        }
        if {$stop_processing} {break}
    }
}

proc {vTcl:Toplevel:WidgetProc} {w args} {
    if {[llength $args] == 0} {
        return -code error "wrong # args: should be \"$w option ?arg arg ...?\""
    }

    ## The first argument is a switch, they must be doing a configure.
    if {[string index $args 0] == "-"} {
        set command configure

        ## There's only one argument, must be a cget.
        if {[llength $args] == 1} {
            set command cget
        }
    } else {
        set command [lindex $args 0]
        set args [lrange $args 1 end]
    }

    switch -- $command {
        "hide" -
        "Hide" {
            Window hide $w
        }

        "show" -
        "Show" {
            Window show $w
        }

        "ShowModal" {
            Window show $w
            raise $w
            grab $w
            tkwait window $w
            grab release $w
        }

        default {
            eval $w $command $args
        }
    }
}

proc {vTcl:WidgetProc} {w args} {
    if {[llength $args] == 0} {
        return -code error "wrong # args: should be \"$w option ?arg arg ...?\""
    }

    ## The first argument is a switch, they must be doing a configure.
    if {[string index $args 0] == "-"} {
        set command configure

        ## There's only one argument, must be a cget.
        if {[llength $args] == 1} {
            set command cget
        }
    } else {
        set command [lindex $args 0]
        set args [lrange $args 1 end]
    }

    eval $w $command $args
}

proc {vTcl:toplevel} {args} {
    uplevel #0 eval toplevel $args
    set target [lindex $args 0]
    namespace eval ::$target {}
}
}

if {[info exists vTcl(sourcing)]} {
proc vTcl:project:info {} {
    namespace eval ::widgets::.top22 {
        array set save {}
    }
    namespace eval ::widgets::.top22.fra23 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top22.fra23.lab25 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top22.fra23.ent26 {
        array set save {-background 1 -borderwidth 1 -textvariable 1}
    }
    namespace eval ::widgets::.top22.fra23.but27 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top22.fra24 {
        array set save {-borderwidth 1 -width 1}
    }
    namespace eval ::widgets::.top22.fra24.01 {
        array set save {-command 1 -orient 1}
    }
    namespace eval ::widgets::.top22.fra24.02 {
        array set save {-command 1}
    }
    namespace eval ::widgets::.top22.fra24.03 {
        array set save {-background 1 -closeenough 1 -height 1 -width 1 -xscrollcommand 1 -yscrollcommand 1}
    }
    namespace eval ::widgets::.top23 {
        array set save {}
    }
    namespace eval ::widgets::.top23.fra24 {
        array set save {-borderwidth 1 -height 1 -relief 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra24.fra22 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra24.fra22.lab25 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra24.fra22.ent26 {
        array set save {-background 1 -borderwidth 1 -textvariable 1}
    }
    namespace eval ::widgets::.top23.fra24.fra22.but27 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra24.fra23 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra24.fra23.lab25 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra24.fra23.ent26 {
        array set save {-background 1 -borderwidth 1 -textvariable 1}
    }
    namespace eval ::widgets::.top23.fra24.fra23.but27 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28 {
        array set save {-borderwidth 1 -height 1 -relief 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra22 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra22.lab25 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra22.ent26 {
        array set save {-background 1 -borderwidth 1 -justify 1 -textvariable 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra22.lab30 {
        array set save {-anchor 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra22.ent32 {
        array set save {-background 1 -borderwidth 1 -justify 1 -textvariable 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra22.lab33 {
        array set save {-anchor 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra22.ent34 {
        array set save {-background 1 -borderwidth 1 -justify 1 -textvariable 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra22.but35 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra23 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra23.lab28 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra23.but29 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra23.but30 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra23.but31 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra23.but32 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra23.but36 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra23.but37 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra23.but22 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra24 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra24.lab25 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra24.lab30 {
        array set save {-anchor 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra24.ent32 {
        array set save {-background 1 -borderwidth 1 -justify 1 -textvariable 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra24.lab26 {
        array set save {-anchor 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra24.ent27 {
        array set save {-background 1 -borderwidth 1 -justify 1 -textvariable 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra24.lab28 {
        array set save {-anchor 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra24.ent29 {
        array set save {-background 1 -borderwidth 1 -justify 1 -textvariable 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra24.lab31 {
        array set save {-anchor 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra24.ent33 {
        array set save {-background 1 -borderwidth 1 -justify 1 -textvariable 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra24.but34 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra25 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra25.lab25 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.fra25.lab30 {
        array set save {-anchor 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.fra25.ent32 {
        array set save {-background 1 -borderwidth 1 -justify 1 -textvariable 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra36 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra36.lab25 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra36.but39 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra36.but22 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra36.but23 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra36.but24 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.cpd23 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top23.cpd23.01 {
        array set save {-command 1 -orient 1}
    }
    namespace eval ::widgets::.top23.cpd23.02 {
        array set save {-command 1}
    }
    namespace eval ::widgets::.top23.cpd23.03 {
        array set save {-background 1 -closeenough 1 -height 1 -width 1 -xscrollcommand 1 -yscrollcommand 1}
    }
    namespace eval ::widgets::.top23.fra22 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra22.lab25 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra22.ent26 {
        array set save {-background 1 -borderwidth 1 -textvariable 1}
    }
    namespace eval ::widgets::.top23.fra22.but27 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra22.lab24 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra22.ent25 {
        array set save {-background 1 -borderwidth 1 -textvariable 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra22.but26 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.lab23 {
        array set save {-anchor 1 -text 1 -textvariable 1}
    }
    namespace eval ::widgets_bindings {
        set tagslist {}
    }
}
}
#################################
# USER DEFINED PROCEDURES
#
###########################################################
## Procedure:  _fprsplit

proc {_fprsplit} {string lsep} {
set lret "FPR"
set ls [split $string $lsep]
foreach i $ls {
 if {$i != {}} {
  lappend lret $i
 }
}
return [lrange $lret 1 end]
}
###########################################################
## Procedure:  doFilter

proc {doFilter} {} {
global gVar

#set gVar(filter,mism) "*"
#set gVar(filter,add)  "*"
#set gVar(filter,t5)   "*"
#set gVar(filter,t3)   "*"

#set gVar(tTitles) {seq name mir start end mism add t5 t3 s5 s3 DB ambiguity}

set gVar(lldf) {}
foreach ld $gVar(lld) {
 set mism [lindex $ld 5]
 set add  [lindex $ld 6]
 set t5   [lindex $ld 7]
 set t3   [lindex $ld 8]

 if {([string match $gVar(filter,mism) $mism]) && ([string match $gVar(filter,add) $add]) && ([string match $gVar(filter,t5) $t5]) && ([string match $gVar(filter,t3) $t3])} {
  lappend gVar(lldf) $ld
 }

}
}
###########################################################
## Procedure:  doSearch

proc {doSearch} {} {
global gVar

set gVar(msg) "Searching process started..."


set lfn {}
set lf [glob -directory $gVar(resultPATH) *]
foreach n $lf {
 set fn [lindex [split $n "/"] end]
 
 set ext [lindex [split $fn "."] end]
 
 if {$ext == "mirna"} {
  lappend lfn $n
 }

}

if {[llength $lfn] == 0} {
 set gVar(msg) "ERROR: No Result files found in the folder..."
 return -1
}

set fn {}
foreach ifn $lfn {
 set ifnn [lindex [split $ifn "/"] end]
 
 set ifnn [join [lreplace [split $ifnn "."] end end] "."]
 
 set spe [lindex [split $ifnn "_"] end]
 
 if {$spe == $gVar(search,0)} {
  set fn $ifn
 }
 
}

if {$fn == {}} {
 set gVar(msg) "ERROR: No Result file for that specimen found..."
 return -1
}



###############################################################
set gVar(msg) "Reading .FAX file..."
update
 
set fnx [lindex [split $fn "/"] end]
set fnx [join [lreplace [split $fnx "."] end end "fax"] "."]

set fnx [join [list $gVar(fastaPATH) ${fnx}] "/"]

if {[file isfile $fnx] == 0} {
 set gVar(msg) "ERROR: No FASTAx file for that specimen found..."
 return -1
}

set fi [open $fnx r]

set i 0
while {![eof $fi]} {
 set l [gets $fi]
 if {[string length $l] > 0} {
 
  set datos [_fprsplit $l "\t"]

  set name [lindex $datos 0]
  set exp  [lindex $datos 1]
  set cnts [lindex $datos 2]

  if {[catch "set gVar(Exp,$name)"] == 0} {
   set found 0
   foreach ec $gVar(Exp,$name) {
    if {([lindex $ec 0] == $exp) && ([lindex $ec 1] == $cnts)} {
     set found 1
     break
    }
   }
   
   if {$found == 0} {
    #lappend gVar(Exp,$name) [list $exp $cnts]
    lappend gVar(Exp,$name) [lrange $datos 1 end]
   }
  } else {
   #lappend gVar(Exp,$name) [list $exp $cnts]
   lappend gVar(Exp,$name) [lrange $datos 1 end]
  }
 }

}

close $fi



###############################################################
set gVar(msg) "Reading .MIRNA file..."
update

set fi [open $fn r]

set gVar(lld) {}
set i 0
while {![eof $fi]} {
 set l [gets $fi]
 if {[string length $l] > 0} {

  set datos [_fprsplit $l " \t"]

  #set namex [lindex $datos 1]
  set name  [lindex $datos 2]

  if {$name == "$gVar(search,0)-$gVar(search,1)-$gVar(search,2)"} {
   #lappend datos [lindex $Tmp($namex) 0]
   #lappend datos [lindex $Tmp($namex) 1]

   lappend gVar(lld) $datos

   incr i
  }

 }
}
close $fi


###############################################################
set gVar(msg) "Sorting Seqs vertically..."
update

set minStart +1e9

foreach ld $gVar(lld) {
 set start [lindex $ld 3]
 
 if {$start < $minStart} {set minStart $start}
}

set i 0
foreach ld $gVar(lld) {
 set seq   [lindex $ld 0]
 set start [lindex $ld 3]

 set seqm $seq
 for {set j 0} {$j < [expr $start-$minStart]} {incr j} {
  set seqm " $seqm"
 }
 
 set ldm [lreplace $ld 0 0 $seqm]

 set gVar(lld) [lreplace $gVar(lld) $i $i $ldm] 
 
 incr i 
}


set gVar(lldf) $gVar(lld)

drawTable $gVar(wgetCNV) $gVar(tTitles) $gVar(lldf)

set gVar(msg) "Found $i Lines..."

return 1
}
###########################################################
## Procedure:  drawTable

proc {drawTable} {w h lld} {
$w delete all
set table [::DrawTable::drawntable $w -columnwidths {30 15 16 6 6 7 7 7 7 10 10 7 12} -headerfont "Courier 12 bold" -textfont "Courier 10" -numberfont "Courier 10"]
#seq	                      name	   mir	          start	end mism add t5	 t3  s5       s3       DB    ambiguity
#AAATGACACTGGTTATCTTTTCCATCGT MR0000105983 cel-miR-229-5p 7	34  1AC  0   u-C d-T CGGCAATG ATCGTGGA miRNA 1
$table headers {seq name mir start end mism add t5 t3 s5 s3 DB ambiguity}
$table hline


foreach ld $lld {
 $table addrow $ld
 $table hline
}


$table frame all

$w configure -scrollregion [$w bbox all]
}
###########################################################
## Procedure:  drawTableExp

proc {drawTableExp} {w h lld} {
$w delete all
set table [::DrawTable::drawntable $w -columnwidths {15 8 7 15 30 15} -headerfont "Courier 12 bold" -textfont "Courier 10" -numberfont "Courier 10"]
$table headers {experiment counts specie tissue technology link}
$table hline


foreach ld $lld {
 $table addrow $ld
 $table hline
}


$table frame all

$w configure -scrollregion [$w bbox all]
}
###########################################################
## Procedure:  itemClick

proc {itemClick} {w x y} {
global gVar

set ltags [$w gettags current]
set cell  [lindex $ltags 0]
set type  [$w type $cell]

#puts "itemClick: $type -> $ltags"

set lt [split $cell "_"]
if {($type == "text") && ([lindex $lt 0] == "cell")} {
 set row [lindex $lt 1]
 
 set ct "cell_${row}_1"
 
 set name [string trim [lindex [$w itemconfigure $ct -text] end]]
 
 #puts "itemClick: $cell -> $ct -> $name"
 
 Window show .top22
 Window show .top22
 set gVar(Exp,NAME) $name
 drawTableExp $gVar(wgetCNV2) {} $gVar(Exp,$gVar(Exp,NAME))
}

if {($type == "line") && ($cell == "item")} {
 set name [lindex $ltags 2]

 
 Window show .top22
 Window show .top22
 set gVar(Exp,NAME) $name
 drawTableExp $gVar(wgetCNV2) {} $gVar(Exp,$gVar(Exp,NAME))
}
}
###########################################################
## Procedure:  itemEnter

proc {itemEnter} {w} {
global gVar

$w delete balloon

set ltags [$w gettags current]
set trow [lindex $ltags 1]
set type [$w type $trow]

#puts "$type -> $ltags"

if {$type == "line"} {
 set bbox [$w bbox current]
 set xr [lindex $bbox 2]
 set yr [lindex $bbox 3]
 
 set row [lindex [split $trow "-"] 1]
 
 set yr [expr $yr + 10]

 $w create text $xr $yr -text [join [lindex $gVar(lldf) $row] "/"] -anchor w -tags [list balloon bt]
 set bbox [$w bbox bt]
 set xi [lindex $bbox 0]
 set yi [lindex $bbox 1]
 set xf [lindex $bbox 2]
 set yf [lindex $bbox 3]
 $w create rectangle $xi $yi $xf $yf -fill white -tags [list balloon bb]
 $w lower bb bt
 
}
}
###########################################################
## Procedure:  itemLeave

proc {itemLeave} {w} {
global gVar

$w delete balloon

#puts "\titemLeave"
}
###########################################################
## Procedure:  plotData

proc {plotData} {w lld} {
global gVar

$w delete all

######################################################
set x0 100
set y0 40

set sizeX 20
set sizeY 20

######################################################
#   A {set cl red}
#   T {set cl blue}
#   G {set cl chartreuse}
#   C {set cl yellow}
set xts [expr $x0 + 50 * $sizeX]
set xte [expr $x0 + 51 * $sizeX]
set xtt [expr $x0 + 52 * $sizeX]
set ytf [expr $y0 +  0 * $sizeY]
$w create text $xtt $ytf -text "A" -fill black
$w create line $xts $ytf $xte $ytf -width [expr $sizeY/3.0*2.0] -fill red
set ytf [expr $ytf + $sizeY]
$w create text $xtt $ytf -text "T" -fill black
$w create line $xts $ytf $xte $ytf -width [expr $sizeY/3.0*2.0] -fill blue
set ytf [expr $ytf + $sizeY]
$w create text $xtt $ytf -text "G" -fill black
$w create line $xts $ytf $xte $ytf -width [expr $sizeY/3.0*2.0] -fill chartreuse
set ytf [expr $ytf + $sizeY]
$w create text $xtt $ytf -text "C" -fill black
$w create line $xts $ytf $xte $ytf -width [expr $sizeY/3.0*2.0] -fill yellow

######################################################
set i 0
foreach ld $lld {
 set name [string trim [lindex $ld 1]]
 set sum 0
 set nexp 0
 foreach le $gVar(Exp,$name) {
  incr nexp
  set counts [lindex $le 1]
  set sum [expr $sum + $counts]
 }

 lappend ld $i
 lappend lldm [concat [list $sum $nexp] $ld]

 incr i
}
set lld [lsort -integer -index 0 -decreasing $lldm]
unset lldm


######################################################################
set yt [expr $y0 - $sizeY]

set xt [expr $x0 - 6 * $sizeX]
$w create text $xt $yt -text "counts" -fill black

set xt [expr $x0 - 2 * $sizeX]
$w create text $xt $yt -text "experim" -fill black

set xt [expr $x0 + 30 * $sizeX]
$w create text $xt $yt -text "mism" -fill black
set xt [expr $x0 + 33 * $sizeX]
$w create text $xt $yt -text "add"  -fill black
set xt [expr $x0 + 36 * $sizeX]
$w create text $xt $yt -text "t5"   -fill black
set xt [expr $x0 + 39 * $sizeX]
$w create text $xt $yt -text "t3"   -fill black


######################################################################

set y [expr $y0]

set nb 0
foreach ld $lld {
 set sum   [lindex $ld 0]
 
 if {$sum >= $gVar(plot,minCnts)} {
  incr nb
  
  set nexp  [lindex $ld 1]
  set seq   [lindex $ld 2]
  set name  [lindex $ld 3]
  set mism  [lindex $ld 7]
  set add   [lindex $ld 8]
  set t5    [lindex $ld 9]
  set t3    [lindex $ld 10]
  set row   [lindex $ld end]

  set x [expr $x0 + $sizeX / 2.0]

  for {set k 0} {$k < [string length $seq]} {incr k} {
   set c [string index $seq $k]
 
   #A=rojo, T=azul, G=verde, C=amarillo
   switch $c {
    A {set cl red}
    T {set cl blue}
    G {set cl chartreuse}
    C {set cl yellow}
    default {set cl black}
   }
 
   if {$c != " "} {
    set xi [expr $x - $sizeX/2.0]
    set xf [expr $x + $sizeX/2.0]
  
   
    $w create line $xi $y $xf $y -fill $cl -width [expr $sizeY/3.0*2.0] -tags [list item "row-$row" $name]
    #$w create line $x $y -text $c -fill $cl
   }
   set x [expr $x + $sizeX]
  }

  set yt $y

  set xt [expr $x0 - 6 * $sizeX]
  $w create text $xt $yt -text $sum -fill black

  set xt [expr $x0 - 2 * $sizeX]
  $w create text $xt $yt -text $nexp -fill black

  set xt [expr $x0 + 30 * $sizeX]
  $w create text $xt $yt -text $mism -fill black
  set xt [expr $x0 + 33 * $sizeX]
  $w create text $xt $yt -text $add  -fill black
  set xt [expr $x0 + 36 * $sizeX]
  $w create text $xt $yt -text $t5   -fill black
  set xt [expr $x0 + 39 * $sizeX]
  $w create text $xt $yt -text $t3   -fill black
 
  set y [expr $y + $sizeY]
 }
}

#####################################################################
set yt [expr $y0 - $sizeY]

#global minimum
set minStart 1e9
foreach ld $gVar(lld) {
 set start [lindex $ld 3]
 set end   [lindex $ld 4]
 
 if {$start < $minStart} {set minStart $start}
}
#sum  experim  seq	name	mir	start	end	mism	add	t5	t3	s5	s3	DB	ambiguity
set ld [lindex $lld 0]
set start [lindex $ld 5]
set end   [lindex $ld 6]
set t5    [lindex $ld 9]
set t3    [lindex $ld 10]

#puts "plotData: $start -> $minStart"

if {$t5 != 0} {
 set sp [split $t5 "-"]

 if {[lindex $sp 0] == "d"} {
  set op -1
 } else {
  #then is "u"
  set op +1
 } 

 set cnt [string length [lindex $sp 1]]

 set start [expr $start + $op * $cnt]
}

if {$t3 != 0} {
 set sp [split $t3 "-"]

 if {[lindex $sp 0] == "d"} {
  set op -1
 } else {
  #then is "u"
  set op +1
 } 

 set cnt [string length [lindex $sp 1]]

 set end [expr $end + $op * $cnt]
}

set xts [expr $x0 + ($start - $minStart) * $sizeX + $sizeX/2.0]
set xte [expr $x0 + ($end   - $minStart) * $sizeX + $sizeX/2.0]
set ytf [expr $y0 + $nb * $sizeY]

$w create text $xts $yt -text $start -fill black
$w create text $xte $yt -text $end   -fill black

$w create line [expr $xts - $sizeX/2] $yt [expr $xts - $sizeX/2] $ytf -fill black
$w create line [expr $xts + $sizeX/2] $yt [expr $xts + $sizeX/2] $ytf -fill black
$w create line [expr $xte - $sizeX/2] $yt [expr $xte - $sizeX/2] $ytf -fill black
$w create line [expr $xte + $sizeX/2] $yt [expr $xte + $sizeX/2] $ytf -fill black


######################################################
$w configure -scrollregion [$w bbox all]


$w bind item <Any-Enter> "itemEnter $w"
$w bind item <Any-Leave> "itemLeave $w"
}
###########################################################
## Procedure:  plotData_prv

proc {plotData_prv} {w lld} {
global gVar

$w delete all

######################################################
set x0 60
set y0 40

set sizeX 20
set sizeY 20

######################################################
#   A {set cl red}
#   T {set cl blue}
#   G {set cl chartreuse}
#   C {set cl yellow}
set xts [expr $x0 + 50 * $sizeX]
set xte [expr $x0 + 51 * $sizeX]
set xtt [expr $x0 + 52 * $sizeX]
set ytf [expr $y0 +  0 * $sizeY]
$w create text $xtt $ytf -text "A" -fill black
$w create line $xts $ytf $xte $ytf -width [expr $sizeY/3.0*2.0] -fill red
set ytf [expr $ytf + $sizeY]
$w create text $xtt $ytf -text "T" -fill black
$w create line $xts $ytf $xte $ytf -width [expr $sizeY/3.0*2.0] -fill blue
set ytf [expr $ytf + $sizeY]
$w create text $xtt $ytf -text "G" -fill black
$w create line $xts $ytf $xte $ytf -width [expr $sizeY/3.0*2.0] -fill chartreuse
set ytf [expr $ytf + $sizeY]
$w create text $xtt $ytf -text "C" -fill black
$w create line $xts $ytf $xte $ytf -width [expr $sizeY/3.0*2.0] -fill yellow

######################################################
set i 0
foreach ld $lld {
 set name [string trim [lindex $ld 1]]
 set sum 0
 foreach le $gVar(Exp,$name) {
  set counts [lindex $le 1]
  set sum [expr $sum + $counts]
 }

 lappend ld $i
 lappend lldm [concat [list $sum] $ld]

 incr i
}
set lld [lsort -integer -index 0 -decreasing $lldm]
unset lldm

######################################################
set yt [expr $y0 - $sizeY]

#global minimum
set minStart 1e9
foreach ld $gVar(lld) {
 set start [lindex $ld 3]
 set end   [lindex $ld 4]
 
 if {$start < $minStart} {set minStart $start}
}
#sum    seq	name	mir	start	end	mism	add	t5	t3	s5	s3	DB	ambiguity
set ld [lindex $lld 0]
set start [lindex $ld 4]
set end   [lindex $ld 5]
set t5    [lindex $ld 8]
set t3    [lindex $ld 9]

#puts "plotData: $start -> $minStart"

if {$t5 != 0} {
 set sp [split $t5 "-"]

 if {[lindex $sp 0] == "d"} {
  set op -1
 } else {
  #then is "u"
  set op +1
 } 

 set cnt [string length [lindex $sp 1]]

 set start [expr $start + $op * $cnt]
}

if {$t3 != 0} {
 set sp [split $t3 "-"]

 if {[lindex $sp 0] == "d"} {
  set op -1
 } else {
  #then is "u"
  set op +1
 } 

 set cnt [string length [lindex $sp 1]]

 set end [expr $end + $op * $cnt]
}

set xts [expr $x0 + ($start - $minStart) * $sizeX + $sizeX/2.0]
set xte [expr $x0 + ($end   - $minStart) * $sizeX + $sizeX/2.0]
set ytf [expr $y0 + [llength $lld] * $sizeY]

$w create text $xts $yt -text $start -fill black
$w create text $xte $yt -text $end   -fill black

$w create line [expr $xts - $sizeX/2] $yt [expr $xts - $sizeX/2] $ytf -fill black
$w create line [expr $xts + $sizeX/2] $yt [expr $xts + $sizeX/2] $ytf -fill black
$w create line [expr $xte - $sizeX/2] $yt [expr $xte - $sizeX/2] $ytf -fill black
$w create line [expr $xte + $sizeX/2] $yt [expr $xte + $sizeX/2] $ytf -fill black




set xt [expr $x0 - 2 * $sizeX]
$w create text $xt $yt -text "counts" -fill black

set xt [expr $x0 + 30 * $sizeX]
$w create text $xt $yt -text "mism" -fill black
set xt [expr $x0 + 33 * $sizeX]
$w create text $xt $yt -text "add"  -fill black
set xt [expr $x0 + 36 * $sizeX]
$w create text $xt $yt -text "t5"   -fill black
set xt [expr $x0 + 39 * $sizeX]
$w create text $xt $yt -text "t3"   -fill black


set y [expr $y0]

foreach ld $lld {
 set sum   [lindex $ld 0]
 set seq   [lindex $ld 1]
 set name  [lindex $ld 2]
 set mism  [lindex $ld 6]
 set add   [lindex $ld 7]
 set t5    [lindex $ld 8]
 set t3    [lindex $ld 9]
 set row   [lindex $ld end]

 set x [expr $x0 + $sizeX / 2.0]

 for {set k 0} {$k < [string length $seq]} {incr k} {
  set c [string index $seq $k]
 
  #A=rojo, T=azul, G=verde, C=amarillo
  switch $c {
   A {set cl red}
   T {set cl blue}
   G {set cl chartreuse}
   C {set cl yellow}
   default {set cl black}
  }
 
  if {$c != " "} {
   set xi [expr $x - $sizeX/2.0]
   set xf [expr $x + $sizeX/2.0]
  
   
   $w create line $xi $y $xf $y -fill $cl -width [expr $sizeY/3.0*2.0] -tags [list item "row-$row" $name]
   #$w create line $x $y -text $c -fill $cl
  }
  set x [expr $x + $sizeX]
 }

 set yt $y

 set xt [expr $x0 - 2 * $sizeX]
 $w create text $xt $yt -text $sum -fill black

 set xt [expr $x0 + 30 * $sizeX]
 $w create text $xt $yt -text $mism -fill black
 set xt [expr $x0 + 33 * $sizeX]
 $w create text $xt $yt -text $add  -fill black
 set xt [expr $x0 + 36 * $sizeX]
 $w create text $xt $yt -text $t5   -fill black
 set xt [expr $x0 + 39 * $sizeX]
 $w create text $xt $yt -text $t3   -fill black
 
 set y [expr $y + $sizeY]
}

$w configure -scrollregion [$w bbox all]


$w bind item <Any-Enter> "itemEnter $w"
$w bind item <Any-Leave> "itemLeave $w"
}
###########################################################
## Procedure:  init
###########################################################
## Procedure:  main

proc {main} {argc argv} {
global gVar
global vTcl

## This will clean up and call exit properly on Windows.
wm protocol .top23 WM_DELETE_WINDOW { exit }

## This will execute only in RUN mode
if {[catch "set vTcl(version)"] == 1} {
 source "$gVar(sysPath)/canvasTable.tcll"
}
}

proc init {argc argv} {
global gVar

if {[info script] == "vTcl-MIRNAadv.tcl"} {
 set gVar(sysPath) [pwd]
} else {
 set gVar(sysPath) [join [lreplace [split [info script] "/\\"] end end] "/"]
}


set gVar(fastaPATH)  "$gVar(sysPath)/data/mirna_read_count_by_experiment"
set gVar(resultPATH) "$gVar(sysPath)/results"
set gVar(postPATH)    $gVar(sysPath)

set gVar(postNAME) noName.ps

set gVar(search,0) cel
set gVar(search,1) miR-66
set gVar(search,2) 3p


set gVar(filter,mism) "*"
set gVar(filter,add)  "*"
set gVar(filter,t5)   "*"
set gVar(filter,t3)   "*"

set gVar(plot) table

set gVar(plot,minCnts) 0

set gVar(Exp,NAME) "MR0000105964"


set gVar(wgetCNV)  .top23.cpd23.03
set gVar(wgetCNV2) .top22.fra24.03

set gVar(msg) "Iniciando el programa..."

set gVar(tTitles) {seq name mir start end mism add t5 t3 s5 s3 DB ambiguity experiment counts}
}

init $argc $argv

#################################
# VTCL GENERATED GUI PROCEDURES
#

proc vTclWindow. {base {container 0}} {
    if {$base == ""} {
        set base .
    }
    ###################
    # CREATING WIDGETS
    ###################
    if {!$container} {
    wm focusmodel $base passive
    wm geometry $base 1x1+0+0; update
    wm maxsize $base 2945 1020
    wm minsize $base 1 1
    wm overrideredirect $base 0
    wm resizable $base 1 1
    wm withdraw $base
    wm title $base "vtcl.tcl"
    bindtags $base "$base Vtcl.tcl all"
    vTcl:FireEvent $base <<Create>>
    }
    ###################
    # SETTING GEOMETRY
    ###################

    vTcl:FireEvent $base <<Ready>>
}

proc vTclWindow.top22 {base {container 0}} {
    if {$base == ""} {
        set base .top22
    }
    if {[winfo exists $base] && (!$container)} {
        wm deiconify $base; return
    }

    global widget
    vTcl:DefineAlias "$base" "Toplevel2" vTcl:Toplevel:WidgetProc "" 1
    vTcl:DefineAlias "$base.fra23" "Frame11" vTcl:WidgetProc "Toplevel2" 1
    vTcl:DefineAlias "$base.fra23.but27" "Button33" vTcl:WidgetProc "Toplevel2" 1
    vTcl:DefineAlias "$base.fra23.ent26" "Entry19" vTcl:WidgetProc "Toplevel2" 1
    vTcl:DefineAlias "$base.fra23.lab25" "Label27" vTcl:WidgetProc "Toplevel2" 1
    vTcl:DefineAlias "$base.fra24" "Frame6" vTcl:WidgetProc "Toplevel2" 1
    vTcl:DefineAlias "$base.fra24.01" "Scrollbar3" vTcl:WidgetProc "Toplevel2" 1
    vTcl:DefineAlias "$base.fra24.02" "Scrollbar4" vTcl:WidgetProc "Toplevel2" 1
    vTcl:DefineAlias "$base.fra24.03" "Canvas1" vTcl:WidgetProc "Toplevel2" 1

    ###################
    # CREATING WIDGETS
    ###################
    if {!$container} {
    vTcl:toplevel $base -class Toplevel
    wm withdraw $base
    wm focusmodel $base passive
    wm geometry $base 799x289+563+509; update
    wm maxsize $base 2945 1020
    wm minsize $base 1 1
    wm overrideredirect $base 0
    wm resizable $base 1 1
    wm title $base "vTcl-MIRNAadv Experiment Information"
    vTcl:FireEvent $base <<Create>>
    }
    frame $base.fra23 \
        -borderwidth 1 -height 75 -width 125 
    label $base.fra23.lab25 \
        -anchor w -text {MIRNA Name} -width 15 
    entry $base.fra23.ent26 \
        -background white -borderwidth 1 -textvariable gVar(Exp,NAME) 
    button $base.fra23.but27 \
        -borderwidth 1 \
        -command {drawTableExp $gVar(wgetCNV2) {} $gVar(Exp,$gVar(Exp,NAME))} \
        -pady 0 -text Show 
    frame $base.fra24 \
        -borderwidth 1 -width 129 
    scrollbar $base.fra24.01 \
        -command "$base.fra24.03 xview" -orient horizontal 
    scrollbar $base.fra24.02 \
        -command "$base.fra24.03 yview" 
    canvas $base.fra24.03 \
        -background white -closeenough 1.0 -height 100 -width 100 \
        -xscrollcommand "$base.fra24.01 set" \
        -yscrollcommand "$base.fra24.02 set" 
    ###################
    # SETTING GEOMETRY
    ###################
    pack $base.fra23 \
        -in $base -anchor center -expand 0 -fill x -side top 
    pack $base.fra23.lab25 \
        -in $base.fra23 -anchor center -expand 0 -fill none -side left 
    pack $base.fra23.ent26 \
        -in $base.fra23 -anchor center -expand 0 -fill x -side left 
    pack $base.fra23.but27 \
        -in $base.fra23 -anchor center -expand 0 -fill y -side left 
    pack $base.fra24 \
        -in $base -anchor center -expand 1 -fill both -side top 
    grid columnconf $base.fra24 0 -weight 1
    grid rowconf $base.fra24 0 -weight 1
    grid $base.fra24.01 \
        -in $base.fra24 -column 0 -row 1 -columnspan 1 -rowspan 1 -sticky ew 
    grid $base.fra24.02 \
        -in $base.fra24 -column 1 -row 0 -columnspan 1 -rowspan 1 -sticky ns 
    grid $base.fra24.03 \
        -in $base.fra24 -column 0 -row 0 -columnspan 1 -rowspan 1 \
        -sticky nesw 

    vTcl:FireEvent $base <<Ready>>
}

proc vTclWindow.top23 {base {container 0}} {
    if {$base == ""} {
        set base .top23
    }
    if {[winfo exists $base] && (!$container)} {
        wm deiconify $base; return
    }

    global widget
    vTcl:DefineAlias "$base" "Toplevel1" vTcl:Toplevel:WidgetProc "" 1
    vTcl:DefineAlias "$base.cpd23" "Frame6" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.cpd23.01" "Scrollbar3" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.cpd23.02" "Scrollbar4" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.cpd23.03" "Canvas1" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra22" "Frame12" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra22.but26" "Button37" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra22.but27" "Button36" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra22.ent25" "Entry21" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra22.ent26" "Entry20" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra22.lab24" "Label29" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra22.lab25" "Label28" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24" "Frame1" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.fra22" "Frame10" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.fra22.but27" "Button32" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.fra22.ent26" "Entry18" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.fra22.lab25" "Label26" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.fra23" "Frame11" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.fra23.but27" "Button33" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.fra23.ent26" "Entry19" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.fra23.lab25" "Label27" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28" "Frame2" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra22" "Frame7" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra22.but35" "Button15" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra22.ent26" "Entry6" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra22.ent32" "Entry7" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra22.ent34" "Entry8" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra22.lab25" "Label12" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra22.lab30" "Label13" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra22.lab33" "Label14" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra23" "Frame8" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra23.but22" "Button30" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra23.but29" "Button24" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra23.but30" "Button25" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra23.but31" "Button26" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra23.but32" "Button27" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra23.but36" "Button28" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra23.but37" "Button29" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra23.lab28" "Label19" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra24" "Frame9" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra24.but34" "Button31" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra24.ent27" "Entry15" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra24.ent29" "Entry16" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra24.ent32" "Entry13" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra24.ent33" "Entry17" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra24.lab25" "Label20" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra24.lab26" "Label23" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra24.lab28" "Label24" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra24.lab30" "Label21" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra24.lab31" "Label25" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra25" "Frame13" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra25.ent32" "Entry22" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra25.lab25" "Label30" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.fra25.lab30" "Label31" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36" "Frame4" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36.but22" "Button13" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36.but23" "Button35" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36.but24" "Button34" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36.but39" "Button6" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36.lab25" "Label7" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.lab23" "Label10" vTcl:WidgetProc "Toplevel1" 1

    ###################
    # CREATING WIDGETS
    ###################
    if {!$container} {
    vTcl:toplevel $base -class Toplevel
    wm focusmodel $base passive
    wm geometry $base 1225x484+57+133; update
    wm maxsize $base 2964 1035
    wm minsize $base 104 1
    wm overrideredirect $base 0
    wm resizable $base 1 1
    wm deiconify $base
    wm title $base "vTclMIRNAadv (FPR 2015)"
    vTcl:FireEvent $base <<Create>>
    }
    frame $base.fra24 \
        -borderwidth 1 -relief groove -height 75 -width 125 
    frame $base.fra24.fra22 \
        -borderwidth 1 -height 75 -width 125 
    label $base.fra24.fra22.lab25 \
        -anchor w -text {FASTAx Folder} -width 15 
    entry $base.fra24.fra22.ent26 \
        -background white -borderwidth 1 -textvariable gVar(fastaPATH) 
    button $base.fra24.fra22.but27 \
        -borderwidth 1 \
        -command {set gVar(fastaPATH) [tk_chooseDirectory -parent .top23 -title "Select FASTA Folder" -mustexist 1 -initialdir $gVar(fastaPATH)]} \
        -pady 0 -text Browse 
    frame $base.fra24.fra23 \
        -borderwidth 1 -height 75 -width 125 
    label $base.fra24.fra23.lab25 \
        -anchor w -text {MIRNA Folder} -width 15 
    entry $base.fra24.fra23.ent26 \
        -background white -borderwidth 1 -textvariable gVar(resultPATH) 
    button $base.fra24.fra23.but27 \
        -borderwidth 1 \
        -command {set gVar(resultPATH) [tk_chooseDirectory -parent .top23 -title "Select Results Folder" -mustexist 1 -initialdir $gVar(resultPATH)]} \
        -pady 0 -text Browse 
    frame $base.fra28 \
        -borderwidth 1 -relief groove -height 75 -width 125 
    frame $base.fra28.fra22 \
        -borderwidth 1 -height 75 -width 125 
    label $base.fra28.fra22.lab25 \
        -anchor w -text {Search Option:} -width 15 
    entry $base.fra28.fra22.ent26 \
        -background white -borderwidth 1 -justify center \
        -textvariable gVar(search,0) -width 5 
    label $base.fra28.fra22.lab30 \
        -anchor w -text - 
    entry $base.fra28.fra22.ent32 \
        -background white -borderwidth 1 -justify center \
        -textvariable gVar(search,1) -width 10 
    label $base.fra28.fra22.lab33 \
        -anchor w -text - 
    entry $base.fra28.fra22.ent34 \
        -background white -borderwidth 1 -justify center \
        -textvariable gVar(search,2) -width 5 
    button $base.fra28.fra22.but35 \
        -borderwidth 1 \
        -command {set gVar(lld)  {}
set gVar(lldf) {}

set gVar(plot) table

doSearch} \
        -pady 0 -text Search 
    frame $base.fra28.fra23 \
        -borderwidth 1 -height 75 -width 125 
    label $base.fra28.fra23.lab28 \
        -anchor w -text {Sort Option:} -width 15 
    button $base.fra28.fra23.but29 \
        -borderwidth 1 \
        -command {set gVar(plot) table

drawTable $gVar(wgetCNV) $gVar(tTitles) [lsort -index 0 -increasing $gVar(lldf)]} \
        -pady 0 -text Seq. 
    button $base.fra28.fra23.but30 \
        -borderwidth 1 \
        -command {set gVar(plot) table

drawTable $gVar(wgetCNV) $gVar(tTitles) [lsort -index 1 -increasing $gVar(lldf)]} \
        -pady 0 -text name 
    button $base.fra28.fra23.but31 \
        -borderwidth 1 \
        -command {set gVar(plot) table

drawTable $gVar(wgetCNV) $gVar(tTitles) [lsort -index 5 -increasing $gVar(lldf)]} \
        -pady 0 -text mism 
    button $base.fra28.fra23.but32 \
        -borderwidth 1 \
        -command {set gVar(plot) table

drawTable $gVar(wgetCNV) $gVar(tTitles) [lsort -index 6 -increasing $gVar(lldf)]} \
        -pady 0 -text add 
    button $base.fra28.fra23.but36 \
        -borderwidth 1 \
        -command {set gVar(plot) table

drawTable $gVar(wgetCNV) $gVar(tTitles) [lsort -index 7 -increasing $gVar(lldf)]} \
        -pady 0 -text t5 
    button $base.fra28.fra23.but37 \
        -borderwidth 1 \
        -command {set gVar(plot) table

drawTable $gVar(wgetCNV) $gVar(tTitles) [lsort -index 8 -increasing $gVar(lldf)]} \
        -pady 0 -text t3 
    button $base.fra28.fra23.but22 \
        -borderwidth 1 \
        -command {set gVar(plot) table

drawTable $gVar(wgetCNV) $gVar(tTitles) $gVar(lldf)} \
        -pady 0 -text Original 
    frame $base.fra28.fra24 \
        -borderwidth 1 -height 75 -width 125 
    label $base.fra28.fra24.lab25 \
        -anchor w -text {Filter Option:} -width 15 
    label $base.fra28.fra24.lab30 \
        -anchor w -text mism 
    entry $base.fra28.fra24.ent32 \
        -background white -borderwidth 1 -justify center \
        -textvariable gVar(filter,mism) -width 10 
    label $base.fra28.fra24.lab26 \
        -anchor w -text add 
    entry $base.fra28.fra24.ent27 \
        -background white -borderwidth 1 -justify center \
        -textvariable gVar(filter,add) -width 10 
    label $base.fra28.fra24.lab28 \
        -anchor w -text t5 
    entry $base.fra28.fra24.ent29 \
        -background white -borderwidth 1 -justify center \
        -textvariable gVar(filter,t5) -width 10 
    label $base.fra28.fra24.lab31 \
        -anchor w -text t3 
    entry $base.fra28.fra24.ent33 \
        -background white -borderwidth 1 -justify center \
        -textvariable gVar(filter,t3) -width 10 
    button $base.fra28.fra24.but34 \
        -borderwidth 1 \
        -command {doFilter


if {$gVar(plot) == "table"} {
 drawTable $gVar(wgetCNV) $gVar(tTitles) $gVar(lldf)
} else {
 plotData $gVar(wgetCNV) $gVar(lldf)
}} \
        -pady 0 -text Filter 
    frame $base.fra28.fra25 \
        -borderwidth 1 -height 75 -width 125 
    label $base.fra28.fra25.lab25 \
        -anchor w -text {Plot Option:} -width 15 
    label $base.fra28.fra25.lab30 \
        -anchor w -text minCount 
    entry $base.fra28.fra25.ent32 \
        -background white -borderwidth 1 -justify center \
        -textvariable gVar(plot,minCnts) -width 10 
    frame $base.fra36 \
        -borderwidth 1 -height 75 -width 125 
    label $base.fra36.lab25 \
        -anchor w -text Results: -width 15 
    button $base.fra36.but39 \
        -borderwidth 1 -command {console show} -pady 0 -text Console 
    button $base.fra36.but22 \
        -borderwidth 1 \
        -command {set gVar(plot) data

plotData $gVar(wgetCNV) $gVar(lldf)} \
        -pady 0 -text PlotData 
    button $base.fra36.but23 \
        -borderwidth 1 \
        -command {set gVar(plot) table

drawTable $gVar(wgetCNV) $gVar(tTitles) $gVar(lldf)} \
        -pady 0 -text Table 
    button $base.fra36.but24 \
        -borderwidth 1 -command {Window show .top22
Window show .top22} \
        -pady 0 -text ShowExperimentInfo 
    frame $base.cpd23 \
        -borderwidth 1 -height 30 -width 30 
    scrollbar $base.cpd23.01 \
        -command "$base.cpd23.03 xview" -orient horizontal 
    scrollbar $base.cpd23.02 \
        -command "$base.cpd23.03 yview" 
    canvas $base.cpd23.03 \
        -background white -closeenough 1.0 -height 100 -width 100 \
        -xscrollcommand "$base.cpd23.01 set" \
        -yscrollcommand "$base.cpd23.02 set" 
    bind $base.cpd23.03 <Button-1> {
        itemClick %W %X %Y
    }
    frame $base.fra22 \
        -borderwidth 1 -height 75 -width 125 
    label $base.fra22.lab25 \
        -anchor w -text {Postcript Folder} -width 15 
    entry $base.fra22.ent26 \
        -background white -borderwidth 1 -textvariable gVar(postPATH) 
    button $base.fra22.but27 \
        -borderwidth 1 \
        -command {set gVar(postPATH) [tk_chooseDirectory -parent .top23 -title "Select Postscript Folder" -mustexist 1 -initialdir $gVar(postPATH)]} \
        -pady 0 -text Browse 
    label $base.fra22.lab24 \
        -anchor w -text {Postcript Name} -width 15 
    entry $base.fra22.ent25 \
        -background white -borderwidth 1 -textvariable gVar(postNAME) \
        -width 30 
    button $base.fra22.but26 \
        -borderwidth 1 \
        -command {$gVar(wgetCNV) postscript -file "$gVar(postPATH)/$gVar(postNAME)"

set gVar(msg) "Postscript file $gVar(postNAME) saved..."} \
        -pady 0 -text Save 
    label $base.lab23 \
        -anchor w -text {Iniciando el programa...} -textvariable gVar(msg) 
    ###################
    # SETTING GEOMETRY
    ###################
    pack $base.fra24 \
        -in $base -anchor center -expand 0 -fill x -side top 
    pack $base.fra24.fra22 \
        -in $base.fra24 -anchor center -expand 0 -fill x -side top 
    pack $base.fra24.fra22.lab25 \
        -in $base.fra24.fra22 -anchor center -expand 0 -fill none -side left 
    pack $base.fra24.fra22.ent26 \
        -in $base.fra24.fra22 -anchor center -expand 1 -fill x -side left 
    pack $base.fra24.fra22.but27 \
        -in $base.fra24.fra22 -anchor center -expand 0 -fill y -side left 
    pack $base.fra24.fra23 \
        -in $base.fra24 -anchor center -expand 0 -fill x -side top 
    pack $base.fra24.fra23.lab25 \
        -in $base.fra24.fra23 -anchor center -expand 0 -fill none -side left 
    pack $base.fra24.fra23.ent26 \
        -in $base.fra24.fra23 -anchor center -expand 1 -fill x -side left 
    pack $base.fra24.fra23.but27 \
        -in $base.fra24.fra23 -anchor center -expand 0 -fill y -side left 
    pack $base.fra28 \
        -in $base -anchor center -expand 0 -fill x -side top 
    pack $base.fra28.fra22 \
        -in $base.fra28 -anchor center -expand 0 -fill x -side top 
    pack $base.fra28.fra22.lab25 \
        -in $base.fra28.fra22 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra22.ent26 \
        -in $base.fra28.fra22 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra22.lab30 \
        -in $base.fra28.fra22 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra22.ent32 \
        -in $base.fra28.fra22 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra22.lab33 \
        -in $base.fra28.fra22 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra22.ent34 \
        -in $base.fra28.fra22 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra22.but35 \
        -in $base.fra28.fra22 -anchor center -expand 0 -fill y -side left 
    pack $base.fra28.fra23 \
        -in $base.fra28 -anchor center -expand 0 -fill x -side top 
    pack $base.fra28.fra23.lab28 \
        -in $base.fra28.fra23 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra23.but29 \
        -in $base.fra28.fra23 -anchor center -expand 0 -fill y -side left 
    pack $base.fra28.fra23.but30 \
        -in $base.fra28.fra23 -anchor center -expand 0 -fill y -side left 
    pack $base.fra28.fra23.but31 \
        -in $base.fra28.fra23 -anchor center -expand 0 -fill y -side left 
    pack $base.fra28.fra23.but32 \
        -in $base.fra28.fra23 -anchor center -expand 0 -fill y -side left 
    pack $base.fra28.fra23.but36 \
        -in $base.fra28.fra23 -anchor center -expand 0 -fill y -side left 
    pack $base.fra28.fra23.but37 \
        -in $base.fra28.fra23 -anchor center -expand 0 -fill y -side left 
    pack $base.fra28.fra23.but22 \
        -in $base.fra28.fra23 -anchor center -expand 0 -fill y -side left 
    pack $base.fra28.fra24 \
        -in $base.fra28 -anchor center -expand 0 -fill x -side top 
    pack $base.fra28.fra24.lab25 \
        -in $base.fra28.fra24 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra24.lab30 \
        -in $base.fra28.fra24 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra24.ent32 \
        -in $base.fra28.fra24 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra24.lab26 \
        -in $base.fra28.fra24 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra24.ent27 \
        -in $base.fra28.fra24 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra24.lab28 \
        -in $base.fra28.fra24 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra24.ent29 \
        -in $base.fra28.fra24 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra24.lab31 \
        -in $base.fra28.fra24 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra24.ent33 \
        -in $base.fra28.fra24 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra24.but34 \
        -in $base.fra28.fra24 -anchor center -expand 0 -fill y -side left 
    pack $base.fra28.fra25 \
        -in $base.fra28 -anchor center -expand 0 -fill x -side top 
    pack $base.fra28.fra25.lab25 \
        -in $base.fra28.fra25 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra25.lab30 \
        -in $base.fra28.fra25 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.fra25.ent32 \
        -in $base.fra28.fra25 -anchor center -expand 0 -fill none -side left 
    pack $base.fra36 \
        -in $base -anchor center -expand 0 -fill x -side top 
    pack $base.fra36.lab25 \
        -in $base.fra36 -anchor center -expand 0 -fill none -side left 
    pack $base.fra36.but39 \
        -in $base.fra36 -anchor center -expand 0 -fill y -side right 
    pack $base.fra36.but22 \
        -in $base.fra36 -anchor center -expand 0 -fill y -side right 
    pack $base.fra36.but23 \
        -in $base.fra36 -anchor center -expand 0 -fill y -side right 
    pack $base.fra36.but24 \
        -in $base.fra36 -anchor center -expand 0 -fill y -side right 
    pack $base.cpd23 \
        -in $base -anchor center -expand 1 -fill both -side top 
    grid columnconf $base.cpd23 0 -weight 1
    grid rowconf $base.cpd23 0 -weight 1
    grid $base.cpd23.01 \
        -in $base.cpd23 -column 0 -row 1 -columnspan 1 -rowspan 1 -sticky ew 
    grid $base.cpd23.02 \
        -in $base.cpd23 -column 1 -row 0 -columnspan 1 -rowspan 1 -sticky ns 
    grid $base.cpd23.03 \
        -in $base.cpd23 -column 0 -row 0 -columnspan 1 -rowspan 1 \
        -sticky nesw 
    pack $base.fra22 \
        -in $base -anchor center -expand 0 -fill x -side top 
    pack $base.fra22.lab25 \
        -in $base.fra22 -anchor center -expand 0 -fill none -side left 
    pack $base.fra22.ent26 \
        -in $base.fra22 -anchor center -expand 1 -fill x -side left 
    pack $base.fra22.but27 \
        -in $base.fra22 -anchor center -expand 0 -fill y -side left 
    pack $base.fra22.lab24 \
        -in $base.fra22 -anchor center -expand 0 -fill none -side left 
    pack $base.fra22.ent25 \
        -in $base.fra22 -anchor center -expand 0 -fill x -side left 
    pack $base.fra22.but26 \
        -in $base.fra22 -anchor center -expand 0 -fill y -side left 
    pack $base.lab23 \
        -in $base -anchor center -expand 0 -fill x -side top 

    vTcl:FireEvent $base <<Ready>>
}

Window show .
Window show .top22
Window show .top23

main $argc $argv
