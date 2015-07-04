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
    namespace eval ::widgets::.top23 {
        array set save {}
    }
    namespace eval ::widgets::.top23.fra24 {
        array set save {-borderwidth 1 -height 1 -relief 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra24.lab25 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra24.ent26 {
        array set save {-background 1 -borderwidth 1 -textvariable 1}
    }
    namespace eval ::widgets::.top23.fra24.but27 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28 {
        array set save {-borderwidth 1 -height 1 -relief 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.lab25 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.ent26 {
        array set save {-background 1 -borderwidth 1 -justify 1 -textvariable 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.lab30 {
        array set save {-anchor 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.ent32 {
        array set save {-background 1 -borderwidth 1 -justify 1 -textvariable 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.lab33 {
        array set save {-anchor 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.ent34 {
        array set save {-background 1 -borderwidth 1 -justify 1 -textvariable 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.but35 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.lab28 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra28.but29 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.but30 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.but31 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.but32 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.but36 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.but37 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.fra28.but22 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
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
    namespace eval ::widgets::.top23.lab24 {
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



set fi [open $fn r]

set gVar(lld) {}
set i 0
while {![eof $fi]} {
 set l [gets $fi]
 if {[string length $l] > 0} {
 
  set datos [_fprsplit $l " \t"]

  set name [lindex $datos 2]
  
  if {$name == "$gVar(search,0)-$gVar(search,1)-$gVar(search,2)"} {
   lappend gVar(lld) $datos

   incr i
  }

 }
}
close $fi


#Sorting Seqs vertically
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


drawTable $gVar(wgetCNV) $gVar(tTitles) $gVar(lld)

set gVar(msg) "Found $i Lines..."

return 1
}
###########################################################
## Procedure:  drawTable

proc {drawTable} {w h lld} {
$w delete all
set table [::DrawTable::drawntable $w -columnwidths {35 15 16 6 6 7 7 7 7 15 15 10 12} -headerfont "Courier 12 bold" -textfont "Courier 10" -numberfont "Courier 10"]
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
## Procedure:  plotData

proc {plotData} {w lld} {
global gVar

$w delete all


set x0 20
set y0 20

set sizeX 20
set sizeY 20

set y [expr $y0]

set i 0
foreach ld $lld {
 set seq [lindex $ld 0]

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
  
   
   $w create line $xi $y $xf $y -fill $cl -width [expr $sizeY/3.0*2.0] -tags [list item "row-$i"]
   #$w create line $x $y -text $c -fill $cl
  }
  set x [expr $x + $sizeX]
 }

 set y [expr $y + $sizeY]
 incr i
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
###########################################################
## Procedure:  plotData_prv

proc {plotData_prv} {w lld} {
global gVar

$w delete all


set x0 20
set y0 20

set sizeX 10
set sizeY 15

set y [expr $y0]


foreach ld $lld {
 set seq [lindex $ld 0]

 set x [expr $x0 + $sizeX / 2.0]

 for {set k 0} {$k < [string length $seq]} {incr k} {
  set c [string index $seq $k]
 
  #A=rojo, T=azul, G=verde, C=amarillo
  switch $c {
   A {set cl red}
   T {set cl blue}
   G {set cl green}
   C {set cl yellow}
   default {set cl black}
  }
 
  if {$c != " "} { 
   $w create text $x $y -text $c -fill $cl
  }
  set x [expr $x + $sizeX]
 }

 set y [expr $y + $sizeY]
}

$w configure -scrollregion [$w bbox all]
}
###########################################################
## Procedure:  doTooltip

proc {doTooltip} {w x y op} {
global gVar

$w delete balloon

if {$op == 1} {







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
 set bbox [$w bbox $trow]
 set xr [lindex $bbox 2]
 set yr [lindex $bbox 3]
 
 set row [lindex [split $trow "-"] 1]
 
 set yr [expr $yr + 10]

 $w create text $xr $yr -text [join [lindex $gVar(lld) $row] "/"] -tags [list balloon bt]
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

proc init {argc argv} {
global gVar

if {[info script] == "vTcl-MIRNAadv.tcl"} {
 set gVar(sysPath) [pwd]
} else {
 set gVar(sysPath) [join [lreplace [split [info script] "/\\"] end end] "/"]
}


set gVar(resultPATH) $gVar(sysPath)

set gVar(search,0) cel
set gVar(search,1) miR-66
set gVar(search,2) 3p


set gVar(wgetCNV) .top23.cpd23.03

set gVar(msg) "Iniciando el programa..."

set gVar(tTitles) {seq name mir start end mism add t5 t3 s5 s3 DB ambiguity}
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
    vTcl:DefineAlias "$base.fra24" "Frame1" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.but27" "Button1" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.ent26" "Entry1" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.lab25" "Label1" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28" "Frame2" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.but22" "Button14" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.but29" "Button7" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.but30" "Button8" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.but31" "Button9" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.but32" "Button10" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.but35" "Button4" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.but36" "Button11" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.but37" "Button12" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.ent26" "Entry2" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.ent32" "Entry4" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.ent34" "Entry5" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.lab25" "Label2" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.lab28" "Label11" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.lab30" "Label4" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.lab33" "Label6" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36" "Frame4" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36.but22" "Button13" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36.but39" "Button6" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36.lab25" "Label7" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.lab24" "Label10" vTcl:WidgetProc "Toplevel1" 1

    ###################
    # CREATING WIDGETS
    ###################
    if {!$container} {
    vTcl:toplevel $base -class Toplevel
    wm focusmodel $base passive
    wm geometry $base 884x429+107+133; update
    wm maxsize $base 2964 1035
    wm minsize $base 104 1
    wm overrideredirect $base 0
    wm resizable $base 1 1
    wm deiconify $base
    wm title $base "vTclMIRNAadv (FPR2015)"
    vTcl:FireEvent $base <<Create>>
    }
    frame $base.fra24 \
        -borderwidth 1 -relief groove -height 75 -width 125 
    label $base.fra24.lab25 \
        -anchor w -text {Results Folder} -width 15 
    entry $base.fra24.ent26 \
        -background white -borderwidth 1 -textvariable gVar(resultPATH) 
    button $base.fra24.but27 \
        -borderwidth 1 \
        -command {set gVar(resultPATH) [tk_chooseDirectory -parent .top23 -title "Select Results Folder" -mustexist 1 -initialdir $gVar(resultPATH)]} \
        -pady 0 -text Browse 
    frame $base.fra28 \
        -borderwidth 1 -relief groove -height 75 -width 125 
    label $base.fra28.lab25 \
        -anchor w -text {Search Option:} -width 15 
    entry $base.fra28.ent26 \
        -background white -borderwidth 1 -justify center \
        -textvariable gVar(search,0) -width 5 
    label $base.fra28.lab30 \
        -anchor w -text - 
    entry $base.fra28.ent32 \
        -background white -borderwidth 1 -justify center \
        -textvariable gVar(search,1) -width 10 
    label $base.fra28.lab33 \
        -anchor w -text - 
    entry $base.fra28.ent34 \
        -background white -borderwidth 1 -justify center \
        -textvariable gVar(search,2) -width 5 
    button $base.fra28.but35 \
        -borderwidth 1 -command doSearch -pady 0 -text Search 
    label $base.fra28.lab28 \
        -anchor w -text {Sort Option:} -width 10 
    button $base.fra28.but29 \
        -borderwidth 1 \
        -command {drawTable $gVar(wgetCNV) $gVar(tTitles) [lsort -index 0 -increasing $gVar(lld)]} \
        -pady 0 -text Seq. 
    button $base.fra28.but30 \
        -borderwidth 1 \
        -command {drawTable $gVar(wgetCNV) $gVar(tTitles) [lsort -index 1 -increasing $gVar(lld)]} \
        -pady 0 -text name 
    button $base.fra28.but31 \
        -borderwidth 1 \
        -command {drawTable $gVar(wgetCNV) $gVar(tTitles) [lsort -index 5 -increasing $gVar(lld)]} \
        -pady 0 -text mism 
    button $base.fra28.but32 \
        -borderwidth 1 \
        -command {drawTable $gVar(wgetCNV) $gVar(tTitles) [lsort -index 6 -increasing $gVar(lld)]} \
        -pady 0 -text add 
    button $base.fra28.but36 \
        -borderwidth 1 \
        -command {drawTable $gVar(wgetCNV) $gVar(tTitles) [lsort -index 7 -increasing $gVar(lld)]} \
        -pady 0 -text t5 
    button $base.fra28.but37 \
        -borderwidth 1 \
        -command {drawTable $gVar(wgetCNV) $gVar(tTitles) [lsort -index 8 -increasing $gVar(lld)]} \
        -pady 0 -text t3 
    button $base.fra28.but22 \
        -borderwidth 1 \
        -command {drawTable $gVar(wgetCNV) $gVar(tTitles) $gVar(lld)} -pady 0 \
        -text Original 
    frame $base.fra36 \
        -borderwidth 1 -height 75 -width 125 
    label $base.fra36.lab25 \
        -anchor w -text Results: -width 15 
    button $base.fra36.but39 \
        -borderwidth 1 -command {console show} -pady 0 -text Console 
    button $base.fra36.but22 \
        -borderwidth 1 -command {plotData $gVar(wgetCNV) $gVar(lld)} -pady 0 \
        -text PlotData 
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
    label $base.lab24 \
        -anchor w -text {Iniciando el programa...} -textvariable gVar(msg) 
    ###################
    # SETTING GEOMETRY
    ###################
    pack $base.fra24 \
        -in $base -anchor center -expand 0 -fill x -side top 
    pack $base.fra24.lab25 \
        -in $base.fra24 -anchor center -expand 0 -fill none -side left 
    pack $base.fra24.ent26 \
        -in $base.fra24 -anchor center -expand 1 -fill x -side left 
    pack $base.fra24.but27 \
        -in $base.fra24 -anchor center -expand 0 -fill none -side top 
    pack $base.fra28 \
        -in $base -anchor center -expand 0 -fill x -side top 
    pack $base.fra28.lab25 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.ent26 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.lab30 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.ent32 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.lab33 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.ent34 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.but35 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.lab28 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.but29 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.but30 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.but31 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.but32 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.but36 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.but37 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.but22 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra36 \
        -in $base -anchor center -expand 0 -fill x -side top 
    pack $base.fra36.lab25 \
        -in $base.fra36 -anchor center -expand 0 -fill none -side left 
    pack $base.fra36.but39 \
        -in $base.fra36 -anchor center -expand 0 -fill none -side right 
    pack $base.fra36.but22 \
        -in $base.fra36 -anchor center -expand 0 -fill none -side right 
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
    pack $base.lab24 \
        -in $base -anchor center -expand 0 -fill x -side top 

    vTcl:FireEvent $base <<Ready>>
}

Window show .
Window show .top23

main $argc $argv
