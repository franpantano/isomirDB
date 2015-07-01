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

proc vTcl:WindowsCleanup {} {
    global vTcl
    if {[info exists vTcl(sourcing)]} { return }
    foreach w [winfo children .] {
    	wm protocol $w WM_DELETE_WINDOW { exit }
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
    namespace eval ::widgets::.top17 {
        array set save {}
    }
    namespace eval ::widgets::.top17.fra23 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top17.fra23.lab22 {
        array set save {-anchor 1 -borderwidth 1 -justify 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top17.fra23.ent23 {
        array set save {-borderwidth 1 -textvariable 1}
    }
    namespace eval ::widgets::.top17.fra23.but24 {
        array set save {-borderwidth 1 -command 1 -padx 1 -pady 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top17.fra28 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top17.fra28.lab22 {
        array set save {-anchor 1 -borderwidth 1 -justify 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top17.fra28.ent23 {
        array set save {-borderwidth 1 -textvariable 1}
    }
    namespace eval ::widgets::.top17.fra28.but24 {
        array set save {-borderwidth 1 -command 1 -padx 1 -pady 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top17.fra29 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top17.fra29.lab34 {
        array set save {-anchor 1 -borderwidth 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top17.fra29.ent35 {
        array set save {-borderwidth 1 -textvariable 1}
    }
    namespace eval ::widgets::.top17.fra29.but36 {
        array set save {-borderwidth 1 -command 1 -padx 1 -pady 1 -text 1 -width 1}
    }
    namespace eval ::widgets::.top17.fra30 {
        array set save {-borderwidth 1 -height 1 -width 1}
    }
    namespace eval ::widgets::.top17.fra30.but19 {
        array set save {-command 1 -padx 1 -pady 1 -relief 1 -text 1}
    }
    namespace eval ::widgets::.top17.lab31 {
        array set save {-anchor 1 -borderwidth 1 -font 1 -text 1 -textvariable 1}
    }
    namespace eval ::widgets::.top17.fra32 {
        array set save {-borderwidth 1 -height 1 -relief 1 -width 1}
    }
    namespace eval ::widgets::.top17.fra32.lab24 {
        array set save {-background 1 -font 1 -foreground 1 -text 1}
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
## Procedure:  _FileDialog

proc {_FileDialog} {w op} {
global GVar


if {$op == "open"} {
  set types {
    {"Archivos TXT ..."		{.txt} }
    {"Todos ..."		* }
  }
  set tmp1 [tk_getOpenFile -filetypes $types -parent $w]
} else {
  set types {
    {"FASTA DB ..."		{.fa} }
    {"Todos ..."		* }
  }
  set tmp1 [tk_getSaveFile -filetypes $types -parent $w  -initialfile [join [lreplace [split $GVar(FileName) "."] end end] "."] -defaultextension .fa]
}

if {$tmp1 != ""} {
 set GVar(FileName) $tmp1
 return 1
} else {
 return 0
}
}
###########################################################
## Procedure:  _StatBar

proc {_StatBar} {percent} {
global GVar

if {$percent < 50} {
 set rcol 255
 set gcol [expr round($percent / 50.0 * 255.0) ]
} else {
 set rcol [expr 255 - round(($percent - 50.0) / 50.0 * 255.0) ]
 set gcol 255
}
set color "#[format %02x $rcol][format %02x $gcol]00"

place configure $GVar(Wget,StatBar) -relwidth [expr $percent / 100.0]

$GVar(Wget,StatBar) configure -text "[expr round($percent)]%"
$GVar(Wget,StatBar) configure -background $color

update
}
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
## Procedure:  _newLeeDatosIn

proc {_newLeeDatosIn} {ifname ofname mirnafn} {
global GVar

############################################################
_putMsg "Procesando Fichero MIRNA..."

set fi [open $mirnafn r]
while {![eof $fi]} {
 set l [gets $fi]
 if {[string length $l] > 0} {
 
  set datos [_fprsplit $l " \t"]

  set nm [lindex $datos 1]
  set id [string range [lindex $datos 2] 0 2]

  set Mirna($nm) $id
 }
}
close $fi

############################################################
_putMsg "Contando Lineas de Entrada..."

set fi [open $ifname r]
set i 0
while {![eof $fi]} {
 set l [gets $fi]
 incr i
}
close $fi

set totl $i

############################################################
_putMsg "Procesando Datos de Entrada..."

set fi [open $ifname r]

set fo "null"

set per_prv -1
set mirn_prv "null"
set i 0
while {![eof $fi]} {
 set l [gets $fi]
 if {[string length $l] > 0} {
 
  set datos [_fprsplit $l " \t"]

  set mirn [lindex $datos 0]
  set name [lindex $datos 1]
  set seq  [lindex $datos 2]

  set seqm ""
  for {set k 0} {$k < [string length $seq]} {incr k} {
   set c [string index $seq $k]
   if {$c == "U"} {
    set c "T"
   }
   set seqm $seqm$c
  }


  if {$mirn != $mirn_prv} {
   set mirn_prv $mirn
   
   if {$fo != "null"} {
    close $fo
   }

   set splfn [split $ofname "."]
   set prefn [join [lreplace $splfn end end] "."]
   set extfn [lindex $splfn end]
   set ofn "${prefn}_$Mirna($mirn).${extfn}"

   set fo [open $ofn a+]
  }
  
  puts $fo ">$name"
  puts $fo $seqm
 }

 incr i

 set per [expr 100 * $i / $totl]
 if {$per > $per_prv} {
  _StatBar $per
  set per_prv $per
 }
}
close $fi
close $fo

_putMsg "Procesados $i Lineas..."

return 1
}
###########################################################
## Procedure:  _putMsg

proc {_putMsg} {msg} {
global GVar

set GVar(Msg) $msg
update
}
###########################################################
## Procedure:  init
###########################################################
## Procedure:  main

proc {main} {argc argv} {
global GVar

wm protocol .top17 WM_DELETE_WINDOW {exit}
}

proc init {argc argv} {
global GVar

set GVar(file1) "/file1"
set GVar(file2) "/file2"
set GVar(file4) "/file4"

set GVar(Wget,StatBar) .top17.fra32.lab24

set GVar(Msg) "Iniciando vTcl-FASTAdiv!!!"
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
    wm geometry $base 200x200+132+132; update
    wm maxsize $base 2964 1035
    wm minsize $base 104 1
    wm overrideredirect $base 0
    wm resizable $base 1 1
    wm withdraw $base
    wm title $base "vtcl"
    bindtags $base "$base Vtcl all"
    vTcl:FireEvent $base <<Create>>
    }
    ###################
    # SETTING GEOMETRY
    ###################

    vTcl:FireEvent $base <<Ready>>
}

proc vTclWindow.top17 {base {container 0}} {
    if {$base == ""} {
        set base .top17
    }
    if {[winfo exists $base] && (!$container)} {
        wm deiconify $base; return
    }

    global widget
    vTcl:DefineAlias "$base.fra23" "Frame13" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra23.but24" "Button1" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra23.ent23" "Entry1" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra23.lab22" "Label17" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra28" "Frame16" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra28.but24" "Button4" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra28.ent23" "Entry3" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra28.lab22" "Label19" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra29" "Frame14" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra29.but36" "Button2" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra29.ent35" "Entry2" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra29.lab34" "Label18" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra30" "Frame15" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra30.but19" "Button3" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra32" "Frame12" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.fra32.lab24" "Label16" vTcl:WidgetProc "$base" 1
    vTcl:DefineAlias "$base.lab31" "Label15" vTcl:WidgetProc "$base" 1

    ###################
    # CREATING WIDGETS
    ###################
    if {!$container} {
    vTcl:toplevel $base -class Toplevel
    wm focusmodel $base passive
    wm geometry $base 488x182+121+104; update
    wm maxsize $base 1028 748
    wm minsize $base 132 2
    wm overrideredirect $base 0
    wm resizable $base 0 0
    wm deiconify $base
    wm title $base "vTcl-FASTAdiv (FPR 2015)"
    vTcl:FireEvent $base <<Create>>
    }
    frame $base.fra23 \
        -borderwidth 2 -height 75 -width 125 
    label $base.fra23.lab22 \
        -anchor w -borderwidth 1 -justify left -text {Fichero mirnaTXT:} \
        -width 16 
    entry $base.fra23.ent23 \
        -borderwidth 1 -textvariable GVar(file2) 
    button $base.fra23.but24 \
        -borderwidth 1 \
        -command {if {[_FileDialog .top17 open] == 1} {
  set GVar(file2) $GVar(FileName)
}} \
        -padx 9 -pady 3 -text buscar -width 10 
    frame $base.fra28 \
        -borderwidth 2 -height 75 -width 125 
    label $base.fra28.lab22 \
        -anchor w -borderwidth 1 -justify left -text {Fichero inTXT:} \
        -width 16 
    entry $base.fra28.ent23 \
        -borderwidth 1 -textvariable GVar(file1) 
    button $base.fra28.but24 \
        -borderwidth 1 \
        -command {if {[_FileDialog .top17 open] == 1} {
  set GVar(file1) $GVar(FileName)
}} \
        -padx 9 -pady 3 -text buscar -width 10 
    frame $base.fra29 \
        -borderwidth 2 -height 75 -width 125 
    label $base.fra29.lab34 \
        -anchor w -borderwidth 1 -text {Fichero outFA:} -width 16 
    entry $base.fra29.ent35 \
        -borderwidth 1 -textvariable GVar(file4) 
    button $base.fra29.but36 \
        -borderwidth 1 \
        -command {if {[_FileDialog .top17 save] == 1} {
  set GVar(file4) $GVar(FileName)
}} \
        -padx 9 -pady 3 -text buscar -width 10 
    frame $base.fra30 \
        -borderwidth 2 -height 75 -width 125 
    button $base.fra30.but19 \
        -command {_newLeeDatosIn $GVar(file1) $GVar(file4) $GVar(file2)} \
        -padx 9 -pady 3 -relief groove -text Procesar... 
    label $base.lab31 \
        -anchor w -borderwidth 1 -font {{MS Sans Serif} 12 bold} \
        -text {Iniciando vTcl-FASTAdiv!!!} -textvariable GVar(Msg) 
    frame $base.fra32 \
        -borderwidth 1 -relief sunken -height 20 -width 125 
    label $base.fra32.lab24 \
        -background #ff0000 -font {{MS Sans Serif} 8 bold} \
        -foreground #ffffff -text 0% 
    ###################
    # SETTING GEOMETRY
    ###################
    pack $base.fra23 \
        -in $base -anchor center -expand 0 -fill x -side top 
    pack $base.fra23.lab22 \
        -in $base.fra23 -anchor center -expand 0 -fill none -side left 
    pack $base.fra23.ent23 \
        -in $base.fra23 -anchor center -expand 1 -fill x -side left 
    pack $base.fra23.but24 \
        -in $base.fra23 -anchor center -expand 0 -fill none -padx 5 \
        -side right 
    pack $base.fra28 \
        -in $base -anchor center -expand 0 -fill x -side top 
    pack $base.fra28.lab22 \
        -in $base.fra28 -anchor center -expand 0 -fill none -side left 
    pack $base.fra28.ent23 \
        -in $base.fra28 -anchor center -expand 1 -fill x -side left 
    pack $base.fra28.but24 \
        -in $base.fra28 -anchor center -expand 0 -fill none -padx 5 \
        -side right 
    pack $base.fra29 \
        -in $base -anchor center -expand 0 -fill x -side top 
    pack $base.fra29.lab34 \
        -in $base.fra29 -anchor center -expand 0 -fill none -side left 
    pack $base.fra29.ent35 \
        -in $base.fra29 -anchor center -expand 1 -fill x -side left 
    pack $base.fra29.but36 \
        -in $base.fra29 -anchor center -expand 0 -fill none -padx 5 \
        -side right 
    pack $base.fra30 \
        -in $base -anchor center -expand 1 -fill both -side top 
    pack $base.fra30.but19 \
        -in $base.fra30 -anchor center -expand 1 -fill both -side left 
    pack $base.lab31 \
        -in $base -anchor center -expand 0 -fill x -padx 3 -pady 3 -side top 
    pack $base.fra32 \
        -in $base -anchor center -expand 0 -fill x -side top 
    place $base.fra32.lab24 \
        -in $base.fra32 -x 0 -y 0 -relheight 1 -anchor nw -bordermode ignore 

    vTcl:FireEvent $base <<Ready>>
}

Window show .
Window show .top17

main $argc $argv
