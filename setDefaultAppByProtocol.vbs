' VBScript register or remove app as protocol default app. It's used on Windows'
' https://github.com/electron/electron/issues/14108 '

On Error Resume Next

operation = WScript.Arguments(0) 'add or remove'
scheme = WScript.Arguments(1)
appName = WScript.Arguments(2)
appPath = WScript.Arguments(3)
appNameWithJ = appName & "J" 'Avoid conflicts with RC Phone'

set reg = New RegExp
reg.Pattern = appName & ".exe"

' msgbox(operation & " " & scheme & " " & appName & " " & appPath)

Set WshShell = CreateObject("WScript.Shell")

If operation = "add" then
    ' msgbox("start to add")
    WshShell.RegWrite "HKCU\SOFTWARE\Classes\" & scheme & "\" , "URL:" & scheme , "REG_SZ"
    WshShell.RegWrite "HKCU\SOFTWARE\Classes\" & scheme & "\URL Protocol" , "" , "REG_SZ"
    WshShell.RegWrite "HKCU\SOFTWARE\Classes\" & appNameWithJ & "." & scheme & "\" , "URL:" & scheme & " Protocol" , "REG_SZ"
    WshShell.RegWrite "HKCU\SOFTWARE\Classes\" & appNameWithJ & "." & scheme & "\Shell\" , "" , "REG_SZ"
    WshShell.RegWrite "HKCU\SOFTWARE\Classes\" & appNameWithJ & "." & scheme & "\Shell\Open\" , "" , "REG_SZ"
    WshShell.RegWrite "HKCU\SOFTWARE\Classes\" & appNameWithJ & "." & scheme & "\Shell\Open\Command\" , """" & appPath & """ ""%1""", "REG_SZ"
    WshShell.RegWrite "HKCU\SOFTWARE\" & appNameWithJ & "\" , "" , "REG_SZ"
    WshShell.RegWrite "HKCU\SOFTWARE\" & appNameWithJ & "\Capabilities\ApplicationDescription" , appNameWithJ , "REG_SZ"
    WshShell.RegWrite "HKCU\SOFTWARE\" & appNameWithJ & "\Capabilities\ApplicationName" , appNameWithJ , "REG_SZ"
    WshShell.RegWrite "HKCU\SOFTWARE\" & appNameWithJ & "\Capabilities\URLAssociations\" & scheme , appNameWithJ & "." & scheme , "REG_SZ"
    WshShell.RegWrite "HKCU\SOFTWARE\RegisteredApplications\" & appNameWithJ , "Software\" & appNameWithJ & "\Capabilities" , "REG_SZ"
End If

If operation = "remove" then

    value = WshShell.RegRead("HKCU\SOFTWARE\Classes\" & appNameWithJ & "." & scheme & "\Shell\Open\Command\")

    if reg.test(value) then
        ' msgbox("start to remove")
        ' WshShell.RegDelete "HKCU\SOFTWARE\Classes\" & scheme & "\"
        ' WshShell.RegDelete "HKCU\SOFTWARE\Classes\" & scheme & "\URL Protocol"
        WshShell.RegDelete "HKCU\SOFTWARE\Classes\" & appNameWithJ & "." & scheme & "\Shell\Open\Command\"
        WshShell.RegDelete "HKCU\SOFTWARE\Classes\" & appNameWithJ & "." & scheme & "\Shell\Open\"
        WshShell.RegDelete "HKCU\SOFTWARE\Classes\" & appNameWithJ & "." & scheme & "\Shell\"
        WshShell.RegDelete "HKCU\SOFTWARE\Classes\" & appNameWithJ & "." & scheme & "\"
        WshShell.RegDelete "HKCU\SOFTWARE\" & appNameWithJ & "\Capabilities\URLAssociations\" & scheme
        WshShell.RegDelete "HKCU\SOFTWARE\" & appNameWithJ & "\Capabilities\ApplicationDescription"
        WshShell.RegDelete "HKCU\SOFTWARE\" & appNameWithJ & "\Capabilities\ApplicationName"
        WshShell.RegDelete "HKCU\SOFTWARE\" & appNameWithJ & "\"
        WshShell.RegDelete "HKCU\SOFTWARE\RegisteredApplications\" & appNameWithJ
    End If
End If
