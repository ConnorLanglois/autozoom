#pragma compile(Icon, 'C:\Program Files (x86)\AutoIt3\Icons\au3.ico')
#pragma compile(ExecLevel, requireAdministrator)
#RequireAdmin

_Init()

While True
	Sleep(5000)
WEnd

Func _Init()
	AutoItSetOption('PixelCoordMode', 2)
	AutoItSetOption('SendKeyDelay', 15)
	HotKeySet('{PAUSE}', '_Exit')
	HotKeySet('`', '_Run')
EndFunc

Func _Run()
	Local Static $state = False
	Local $hMainWnd
	Local $progressPos

	If Not WinExists('Cheat Engine') Then
		Run('C:\Program Files (x86)\Cheat Engine 6.4\cheatengine-i386.exe')
		Sleep(1000)
	EndIf

	$hMainWnd = _WinDisplay('Cheat Engine')

	If Not $state Then
		$progressPos = ControlGetPos($hMainWnd, '', '[CLASS:msctls_progress32; INSTANCE:1]')

		ControlClick($hMainWnd, '', '[CLASS:Window; INSTANCE:3]', 'primary')
		_WinDisplay('Process List')
		Send('^f')
		_WinDisplay('Filter')
		ControlSetText('Filter', '', '[CLASS:Edit; INSTANCE:1]', 'league')
		ControlClick('Filter', '', '[CLASS:Button; INSTANCE:2]', 'primary')
		Sleep(300)
		ControlClick('Process List', '', '[CLASS:Button; INSTANCE:3]', 'primary')
		ControlSetText($hMainWnd, '', '[CLASS:Edit; INSTANCE:1]', '2250')
		ControlCommand($hMainWnd, '', '[CLASS:LCLComboBox; INSTANCE:1]', 'SetCurrentSelection', '5')
		_WinDisplay('League of Legends (TM) Client')
		MouseWheel('down', 11)
		Sleep(500)
		_WinDisplay('Cheat Engine')
		ControlClick($hMainWnd, '', '[CLASS:Button; INSTANCE:18]', 'primary')
		ControlSetText($hMainWnd, '', '[CLASS:Edit; INSTANCE:1]', '1000')
		Sleep(1000)

		While PixelGetColor($progressPos[0] + 5, $progressPos[1] + 5, $hMainWnd) <> 0xE6E6E6
			Sleep(250)
		WEnd

		_WinDisplay('League of Legends (TM) Client')
		MouseWheel('up', 11)
		Sleep(500)
		_WinDisplay('Cheat Engine')
		ControlClick($hMainWnd, '', '[CLASS:Button; INSTANCE:9]', 'primary')

		While PixelGetColor($progressPos[0] + 5, $progressPos[1] + 5, $hMainWnd) <> 0xE6E6E6
			Sleep(250)
		WEnd

		Sleep(300)
		ControlClick($hMainWnd, '', '[CLASS:SysHeader32; INSTANCE:1]', 'primary')
		Send('{DOWN}{APPSKEY}{DOWN}{ENTER}')
		ControlClick($hMainWnd, '', '[CLASS:Window; INSTANCE:12]', 'primary')
		Send('{DOWN}{F6}{ENTER}')
		_OpReplace()
		Send('{ENTER}3000{ENTER}{F6}')
		_OpReplace()
		Send('{ENTER}3000{ENTER}')
		_WinDisplay('League of Legends (TM) Client')
	Else
		_WinDisplay('Cheat Engine')
		Send('{ENTER}2250{ENTER}')
		_WinDisplay('League of Legends (TM) Client')
	EndIf

	$state = Not $state
EndFunc

Func _OpReplace()
	Local Static $state = False;

	_WinDisplay('The following opcodes write to')
	ControlClick('The following opcodes write to', '', '[CLASS:SysListView32; INSTANCE:1]', 'primary', 1, 10, 10)
	Send('^a')
	ControlClick('The following opcodes write to', '', '[CLASS:Button; INSTANCE:1]', 'primary')

	If $state Then
		Send('{ENTER}')
	EndIf

	WinClose('The following opcodes write to')

	$state = Not $state
EndFunc

Func _WinDisplay($title)
	Local $hWnd

	$hWnd = WinWait($title, '', 5)

	If Not $hWnd Then
		MsgBox(0, 'ERROR', 'Could not locate window "' & $title & '"')
		_Exit()
	EndIf

	WinActivate($title)

	$hWnd = WinWaitActive($title, '', 5)

	If Not $hWnd Then
		MsgBox(0, 'ERROR', 'Could not activate window "' & $title & '"')
		_Exit()
	EndIf

	Return $hWnd
EndFunc

Func _Exit()
	Exit
EndFunc
