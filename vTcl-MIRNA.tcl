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
    namespace eval ::widgets::.top23.fra36 {
        array set save {-borderwidth 1 -height 1 -relief 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra36.lab25 {
        array set save {-anchor 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top23.fra36.but39 {
        array set save {-borderwidth 1 -command 1 -pady 1 -text 1}
    }
    namespace eval ::widgets::.top23.cpd37 {
        array set save {-height 1 -width 1}
    }
    namespace eval ::widgets::.top23.cpd37.01 {
        array set save {-command 1 -orient 1}
    }
    namespace eval ::widgets::.top23.cpd37.02 {
        array set save {-command 1}
    }
    namespace eval ::widgets::.top23.cpd37.03 {
        array set save {-borderwidth 1 -font 1 -height 1 -width 1 -wrap 1 -xscrollcommand 1 -yscrollcommand 1}
    }
    namespace eval ::widgets::.top23.lab38 {
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


putTEXT cls
putTEXT "seq	name	mir	start	end	mism	add	t5	t3	s5	s3	DB	ambiguity"


set fi [open $fn r]

set i 0
while {![eof $fi]} {
 set l [gets $fi]
 if {[string length $l] > 0} {
 
  set datos [_fprsplit $l " \t"]

  set name [lindex $datos 2]
  
  if {$name == "$gVar(search,0)-$gVar(search,1)-$gVar(search,2)"} {
   putTEXT $l
   incr i
  }

 }
}
close $fi

set gVar(msg) "Found $i Lines..."

return 1
}
###########################################################
## Procedure:  putTEXT

proc {putTEXT} {txt} {
global gVar

if {$txt == "cls"} {
 $gVar(wgetTEXT) delete 0.0 end
} else {
 $gVar(wgetTEXT) insert end "$txt\n"
 update
}
}
###########################################################
## Procedure:  init
###########################################################
## Procedure:  main

proc {main} {argc argv} {
## This will clean up and call exit properly on Windows.
wm protocol .top23 WM_DELETE_WINDOW { exit }
}

proc init {argc argv} {
global gVar

set gVar(resultPATH) [pwd]

set gVar(search,0) cel
set gVar(search,1) miR-66
set gVar(search,2) 3p


set gVar(wgetTEXT) .top23.cpd37.03

set gVar(msg) "Iniciando el programa..."
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
    vTcl:DefineAlias "$base.cpd37" "Frame5" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.cpd37.01" "Scrollbar1" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.cpd37.02" "Scrollbar2" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.cpd37.03" "Text1" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24" "Frame1" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.but27" "Button1" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.ent26" "Entry1" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra24.lab25" "Label1" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28" "Frame2" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.but35" "Button4" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.ent26" "Entry2" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.ent32" "Entry4" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.ent34" "Entry5" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.lab25" "Label2" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.lab30" "Label4" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra28.lab33" "Label6" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36" "Frame4" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36.but39" "Button6" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.fra36.lab25" "Label7" vTcl:WidgetProc "Toplevel1" 1
    vTcl:DefineAlias "$base.lab38" "Label10" vTcl:WidgetProc "Toplevel1" 1

    ###################
    # CREATING WIDGETS
    ###################
    if {!$container} {
    vTcl:toplevel $base -class Toplevel
    wm focusmodel $base passive
    wm geometry $base 638x422+287+134; update
    wm maxsize $base 2964 1035
    wm minsize $base 104 1
    wm overrideredirect $base 0
    wm resizable $base 1 1
    wm deiconify $base
    wm title $base "vTclMIRNA (FPR2015)"
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
        -command {set gVar(resultPATH) [tk_chooseDirectory -parent .top23 -title "Select Results Folder" -mustexist 1]} \
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
    frame $base.fra36 \
        -borderwidth 1 -relief groove -height 75 -width 125 
    label $base.fra36.lab25 \
        -anchor w -text Results: -width 15 
    button $base.fra36.but39 \
        -borderwidth 1 -command {console show} -pady 0 -text Console 
    frame $base.cpd37 \
        -height 30 -width 30 
    scrollbar $base.cpd37.01 \
        -command "$base.cpd37.03 xview" -orient horizontal 
    scrollbar $base.cpd37.02 \
        -command "$base.cpd37.03 yview" 
    text $base.cpd37.03 \
        -borderwidth 1 -font {Courier 10} -height 10 -width 20 -wrap none \
        -xscrollcommand "$base.cpd37.01 set" \
        -yscrollcommand "$base.cpd37.02 set" 
    label $base.lab38 \
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
    pack $base.fra36 \
        -in $base -anchor center -expand 0 -fill x -side top 
    pack $base.fra36.lab25 \
        -in $base.fra36 -anchor center -expand 0 -fill none -side left 
    pack $base.fra36.but39 \
        -in $base.fra36 -anchor center -expand 0 -fill none -side right 
    pack $base.cpd37 \
        -in $base -anchor center -expand 1 -fill both -side top 
    grid columnconf $base.cpd37 0 -weight 1
    grid rowconf $base.cpd37 0 -weight 1
    grid $base.cpd37.01 \
        -in $base.cpd37 -column 0 -row 1 -columnspan 1 -rowspan 1 -sticky ew 
    grid $base.cpd37.02 \
        -in $base.cpd37 -column 1 -row 0 -columnspan 1 -rowspan 1 -sticky ns 
    grid $base.cpd37.03 \
        -in $base.cpd37 -column 0 -row 0 -columnspan 1 -rowspan 1 \
        -sticky nesw 
    pack $base.lab38 \
        -in $base -anchor center -expand 0 -fill x -side top 

    vTcl:FireEvent $base <<Ready>>
}

Window show .
Window show .top23

main $argc $argv
