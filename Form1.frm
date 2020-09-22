VERSION 5.00
Begin VB.Form Form1 
   Caption         =   " SELF DELETER"
   ClientHeight    =   2520
   ClientLeft      =   5595
   ClientTop       =   4395
   ClientWidth     =   4185
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2520
   ScaleWidth      =   4185
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   -120
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      TabIndex        =   2
      Top             =   1680
      Visible         =   0   'False
      Width           =   4335
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Left            =   3240
      Top             =   1680
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   375
      Left            =   113
      TabIndex        =   0
      Top             =   1800
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "CAVER DAVE'S SELF DELETING EXE"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1815
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   4095
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Command1_Click()
If Timer1.Enabled = False Then
Text1.Text = "help me im about to disappear!" _
& vbCrLf & "and go off into the ether"
End If
End Sub

 Sub KillMe()
Dim ff As Integer, batname As String, ext As String, batnum As Long
    ChDir App.Path
    ext = ".bat"
    Do
        batname = "DelMe" & Format(batnum) & ext
        batnum = batnum + 1
    Loop While Len(Dir(batname))
    ext = ".exe"
    ff = FreeFile
    Open batname For Output As ff
    Print #1, "@Echo off"
    Print #1, ":Repeat"
    Print #1, "del """ & App.EXEName & ext & """"
    Print #1, "if exist """ & App.EXEName & ext & """ goto Repeat"
    Print #1, "del " & batname
    Close #1
    batnum = Shell(batname, 0)
    End
End Sub

Private Sub Form_Load()

Dim TopCorner As Integer
  Dim LeftCorner As Integer
  
  'centres the form on the screen
  If Me.WindowState <> 0 Then Exit Sub

  TopCorner = (Screen.Height - Me.Height) \ 2
  LeftCorner = (Screen.Width - Me.Width) \ 2
  Me.Move LeftCorner, TopCorner
  
Text1.Visible = True

Call Command1_Click

End Sub

Private Sub Text1_Change()
If Text1.Text <> "" Then
Timer1.Enabled = True
Timer1.Interval = 3500
End If
End Sub

Private Sub Timer1_Timer()
If Timer1.Interval = 3500 Then
Timer1.Enabled = False
Call KillMe
'Unload Me
End If
End Sub
