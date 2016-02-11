;Date 2016/01/27
;Script Function: 
;	Intended to automate acquisitions of data from Lightfield acquire button
; F10 is the key to Send for Acquire
; F9 is the key to Send to Run again (which autoscales too)


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;#############################-More Notes-###################################
; Send keystrokes to an inactive window site:autohotkey.com
; ControlSend Command
;;ControlSend [, Control, Keys, WinTitle, WinText, ExcludeTitle, ExcludeText]
; With the Use of Spy Window:
;	Window Title: QDLE001 - LightField
;	Class: 
;	Process: ahk_exe PrincetonInstruments.LightField.exe
;
;ControlClick Command can be sent too
;
;SendInput Command <<<--- this is the command used in this script as we probably will leave the computer alone while acquiring data
;Details:
;Ctrl (^) + some number from the NumberPad (0-9) were set up as hotkeys
;	i.e. ^Numpad0 is setup for acquisition over time (PL over time)
;	Loops the SendInput and before Sending Keys, makes LightField the active window in case any soft popups occur (Komodo*ahem*)
;
;#############################-Begin Script-#####################################

DetectHiddenWindows, On
#SingleInstance force ;similar to reloading the script in case you... load the script again...
#Persistent ; make it run indefinitely
SetTitleMatchMode, 1

;#############################-Create GUI-######################################################
Gui, Show, x150 y400 h165 w180, Mark's HotKey Script
Gui, Add, Text, x5 y120 w180 h30, Mark Lavarius
;
Gui, Add, Text, x5 y0 w120 h30, ^Numpad0 = Acquire
Gui, Add, Text, x5 y15 w120 h30, ^Numpad1 = Rescale indefinitely
Gui, Add, Text, x5 y30 w120 h30, F3 = Not assigned
Gui, Add, Text, x5 y45 w120 h30, F4 = Not Assigned
Gui, Add, Text, x5 y60 w120 h30, F5 = Nothing
Gui, Add, Text, x5 y75 w150 h30, F6 = Nothing
;
Gui, Add, Button, x100 y140 w75 h20 gButtonExit, Exit Program
Gui, -SysMenu

;#############################-Hit Acquire by Designated Intervals-######################################################
^Numpad0::
;Hit Acquire and Run interval
	
	;sleep 1000
	MsgBox, , Notification, Beginning Script, 1 ; notification for 1 seconds and wait 2 seconds after
	sleep 2000
	i = 0 ; +
	;Loop [count], change the value of count to loop however many times
	Loop 15
	{
		WinActivate, QDLE001 - LightField
		;MsgBox, , Notification, I am in the loop, 1 ; notification for 10 seconds and wait 2 seconds after
		sleep 1000 ; this line isn't really necessary
		ControlSend, , {F10}, QDLE001 - LightField
		sleep 5000 ; give 5 seconds to get the acquire back
		;ControlSend, , F9, ahk_class HwndWrapper[PrincetonInstruments.LightField.exe;;a50dfe9d-7769-4f59-bd27-30c010a6ff62]
		;ControlClick, x806 y54, QDLE001 - LightField,,,, Pos
		WinActivate, QDLE001 - LightField
		sleep 1000 ; this line isn't really necessary
		ControlSend, , {F9}, QDLE001 - LightField
		;SendInput {F9}
		sleep 13000 ; wait 1 seconds (Total 3 minute wait) 
		i++
		MsgBox, ,Acquired, Acquire: %i%, 1
	}
	k=0;
	;sleep 114000 acquires every 2 minutes after all the other delays. 
	;Loop 24 for 2 hours after a 5 minute initial iteration from above, 23 ended at 1:55:00
	Loop 23 ; change the value of the number after 'Loop' to repeat the following (change the second sleep command)
	{	
		WinActivate, QDLE001 - LightField
		;MsgBox, , Notification, I am in the 2nd loop, 1 ; notification for 10 seconds and wait 2 seconds after
		ControlSend, , {F10}, QDLE001 - LightField
		sleep 5000
		WinActivate, QDLE001 - LightField
		sleep 1000
		ControlSend, , {F9}, QDLE001 - LightField
		;SendInput {F9}
		;change this value
		sleep 294000 ; keep
		;sleep 5000 ;testing (remove later)
		k++
		MsgBox, , Acquired, Acquire: %k%, 1 ; 1 second popup, place ';' in front of MsgBox to remove popup
	}
	WinActivate, QDLE001 - LightField
	sleep 1000
	ControlSend, , {F10}, QDLE001 - LightField ;last acquire after 1 second after the designated wait time
	sleep 2000
	MsgBox, , Data Acquisition - Complete, Script is done ; Pop-Up Indefinitely
	
	Return

;#############################-Loop AutoScale button-######################################################
;ControlClick [, Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText]
^Numpad1::
;Hit AutoScale - BothAxis
	loop
	{
		;MsgBox, Test, This is a test
		ControlClick, 
		sleep 5000
	}
Return

;############################-Exit Button-##########################################################
ButtonExit:
      ExitApp
return

ClickFunction:
    Click
return

GuiClose:
	ExitApp