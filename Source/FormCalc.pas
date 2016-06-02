(* SimpleCalculator ***********************************************)
(* Copyright (c) 2003 Marc-Andre Lamothe ***************************)
(* All rights reserved *********************************************)

unit FormCalc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Controls,
  Menus, StdCtrls, ExtCtrls, Buttons, Clipbrd, IniFiles, UnitCalc, ImgList ;

type
  TfrmCalc = class(TForm)
    Panel1: TPanel;
    lblAffiche: TLabel;
    lblMem: TLabel;
    lblOp: TLabel;
    tmrBlink: TTimer;
    MainMenu: TMainMenu;
    MainMenu_File: TMenuItem;
    MainMenu_Edit: TMenuItem;
    MainMenu_File_Quit: TMenuItem;
    MainMenu_Edit_Copy: TMenuItem;
    MainMenu_Edit_Paste: TMenuItem;
    N1: TMenuItem;
    MainMenu_File_StayOnTop: TMenuItem;
    MainMenu_Help: TMenuItem;
    MainMenu_Help_About: TMenuItem;
    btnMC: TButton;
    btnMR: TButton;
    btnM: TButton;
    btn7: TButton;
    btn8: TButton;
    btn9: TButton;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    btn0: TButton;
    btnPnt: TButton;
    btnPM: TButton;
    btnCE: TButton;
    btnC: TButton;
    btnPerc: TButton;
    btnPow: TButton;
    btnAdd: TButton;
    btnSub: TButton;
    btnMul: TButton;
    btnDiv: TButton;
    btnTot: TButton;
    btnAns: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrBlinkTimer(Sender: TObject);
    procedure MainMenu_File_QuitClick(Sender: TObject);
    procedure MainMenu_Edit_CopyClick(Sender: TObject);
    procedure MainMenu_Edit_PasteClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure MainMenu_File_StayOnTopClick(Sender: TObject);
    procedure MainMenu_Help_AboutClick(Sender: TObject);
    procedure btnNumberClick(Sender: TObject);
    procedure btnPntClick(Sender: TObject);
    procedure btnPMClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnSubClick(Sender: TObject);
    procedure btnMulClick(Sender: TObject);
    procedure btnDivClick(Sender: TObject);
    procedure btnPercClick(Sender: TObject);
    procedure btnPowClick(Sender: TObject);
    procedure btnTotClick(Sender: TObject);
    procedure btnAnsClick(Sender: TObject);
    procedure btnMClick(Sender: TObject);
    procedure btnMRClick(Sender: TObject);
    procedure btnCEClick(Sender: TObject);
    procedure btnCClick(Sender: TObject);
    procedure btnMCClick(Sender: TObject);
  private
    Calc : TCalc ;

    procedure Blink ;
    procedure Display (Output : Real) ;
  public
  end;

var
  frmCalc: TfrmCalc;

implementation

uses FormAbout;

{$R *.dfm}
     
procedure TfrmCalc.FormCreate(Sender: TObject);
var
  IniFile : TIniFile ;
begin
  IniFile := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Settings.ini') ;

  MainMenu_File_StayOnTop.Checked := IniFile.ReadBool('Calculator', 'StayOnTop', False) ;
  frmCalc.Left := IniFile.ReadInteger('Calculator', 'LeftPos', 100) ;
  frmCalc.Top := IniFile.ReadInteger('Calculator', 'TopPos', 100) ;
  IniFile.Free ;

  if MainMenu_File_StayOnTop.Checked  then
    frmCalc.FormStyle := fsStayOnTop ;

  Calc := TCalc.Create ;
  Display(Calc.Entry) ;
end;

procedure TfrmCalc.FormClose(Sender: TObject; var Action: TCloseAction);
var
  IniFile : TIniFile ;
begin
  IniFile := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Settings.ini') ;

  IniFile.WriteBool('Calculator', 'StayOnTop', MainMenu_File_StayOnTop.Checked) ;
  IniFile.WriteInteger('Calculator', 'LeftPos', frmCalc.Left) ;
  IniFile.WriteInteger('Calculator', 'TopPos', frmCalc.Top) ;
  IniFile.Free ;
end;

procedure TfrmCalc.Blink ;
begin
  lblAffiche.Visible := False ;
  tmrBlink.Enabled := True ;
end ;

procedure TfrmCalc.Display (Output : Real) ;
begin
  Blink ;
  lblAffiche.Caption := FormatFloat(FFormat, Output) ;
  if Pos(DecimalSeparator, lblAffiche.Caption) = 0 then
    lblAffiche.Caption := lblAffiche.Caption + DecimalSeparator ;
end ;

procedure TfrmCalc.tmrBlinkTimer(Sender: TObject);
begin
  lblAffiche.Visible := True ;
  tmrBlink.Enabled := False ;
end;

procedure TfrmCalc.btnNumberClick(Sender: TObject);
begin
  Calc.AddNumber(TLabel(Sender).Tag) ;
  Display(Calc.Entry) ;
end;

procedure TfrmCalc.btnPntClick(Sender: TObject);
begin
  Calc.AddDecimal ;
  Display(Calc.Entry) ;
end;

procedure TfrmCalc.btnPMClick(Sender: TObject);
begin
  Calc.ChangeSign ;
  Display(Calc.Entry) ;
end;
     
procedure TfrmCalc.btnAddClick(Sender: TObject);
begin
  Calc.Add ;
  Display(Calc.Awnser) ;
  lblOp.Caption := '+' ;
end;

procedure TfrmCalc.btnSubClick(Sender: TObject);
begin
  Calc.Substract ;
  Display(Calc.Awnser) ;
  lblOp.Caption := '-' ;
end;

procedure TfrmCalc.btnMulClick(Sender: TObject);
begin
  Calc.Multiply ;
  Display(Calc.Awnser) ;
  lblOp.Caption := '*' ;
end;

procedure TfrmCalc.btnDivClick(Sender: TObject);
begin
  Calc.Divide ;
  Display(Calc.Awnser) ;
  lblOp.Caption := '/' ;
end;

procedure TfrmCalc.btnPercClick(Sender: TObject);
begin
  Calc.Percentage ;
  Display(Calc.Entry) ;
end;

procedure TfrmCalc.btnPowClick(Sender: TObject);
begin
  Calc.Power ;
  Display(Calc.Awnser) ;
  lblOp.Caption := '^' ;
end;

procedure TfrmCalc.btnTotClick(Sender: TObject);
begin
  Calc.Total ;
  Display(Calc.Awnser) ;
  lblOp.Caption := '' ;
end;

procedure TfrmCalc.btnAnsClick(Sender: TObject);
begin
  Calc.LastAwser ;
  Display(Calc.Entry) ;
end;
   
procedure TfrmCalc.btnMClick(Sender: TObject);
begin
  Calc.MemoryAdd ;
  lblMem.Caption := 'M' ;
end;

procedure TfrmCalc.btnMRClick(Sender: TObject);
begin
  Calc.MemoryRecall ;
  Display(Calc.Entry) ;
end;

procedure TfrmCalc.btnMCClick(Sender: TObject);
begin
  Calc.MemoryClear ;
  lblMem.Caption := '' ;
end;
  
procedure TfrmCalc.btnCEClick(Sender: TObject);
begin
  Calc.ClearEntry ;
  Display(Calc.Entry) ;
end;

procedure TfrmCalc.btnCClick(Sender: TObject);
begin
  Calc.ClearCalc ;
  Display(Calc.Entry) ;
  lblOp.Caption := '' ;
end;

procedure TfrmCalc.MainMenu_File_StayOnTopClick(Sender: TObject);
begin
  frmCalc.Hide ;
  if MainMenu_File_StayOnTop.Checked then
    frmCalc.FormStyle := fsStayOnTop
  else
    frmCalc.FormStyle := fsNormal ;
  frmCalc.Show ;
end;

procedure TfrmCalc.MainMenu_File_QuitClick(Sender: TObject);
begin
  frmCalc.Close ;
end;

procedure TfrmCalc.MainMenu_Edit_CopyClick(Sender: TObject);
begin
  Clipboard.SetTextBuf(PChar(lblAffiche.Caption)) ;
  Calc.ClearNext := True ;
end;

procedure TfrmCalc.MainMenu_Edit_PasteClick(Sender: TObject);
begin
  Calc.Entry := StrToFloat(Clipboard.AsText) ;
  Display(Calc.Entry) ;
end;

procedure TfrmCalc.MainMenu_Help_AboutClick(Sender: TObject);
begin
  frmAbout.Dialog('À propos') ;
end;

procedure TfrmCalc.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  case Msg.CharCode of
	  VK_NUMPAD0 : begin
		  btn0.OnClick(btn0) ;
		  Handled := true ;
    end ;
    VK_NUMPAD1 : begin
		  btn1.OnClick(btn1) ;
		  Handled := true ;
    end ;
    VK_NUMPAD2 : begin
		  btn2.OnClick(btn2) ;
		  Handled := true ;
    end ;
    VK_NUMPAD3 : begin
		  btn3.OnClick(btn3) ;
		  Handled := true ;
    end ;
    VK_NUMPAD4 : begin
		  btn4.OnClick(btn4) ;
		  Handled := true ;
    end ;
    VK_NUMPAD5 : begin
		  btn5.OnClick(btn5) ;
		  Handled := true ;
    end ;
    VK_NUMPAD6 : begin
		  btn6.OnClick(btn6) ;
		  Handled := true ;
    end ;
    VK_NUMPAD7 : begin
		  btn7.OnClick(btn7) ;
		  Handled := true ;
    end ;
    VK_NUMPAD8 : begin
		  btn9.OnClick(btn8) ;
		  Handled := true ;
    end ;
    VK_NUMPAD9 : begin
		  btn9.OnClick(btn9) ;
		  Handled := true ;
    end ;
    VK_DECIMAL : begin
		  btnPnt.OnClick(btnPnt) ;
		  Handled := true ;
    end ;
    VK_ADD : begin
		  btnAdd.OnClick(btnAdd) ;
		  Handled := true ;
    end ;
    VK_SUBTRACT : begin
		  btnSub.OnClick(btnSub) ;
		  Handled := true ;
    end ;
    VK_MULTIPLY : begin
		  btnMul.OnClick(btnMul) ;
		  Handled := true ;
    end ;
    VK_DIVIDE : begin
		  btnDiv.OnClick(btnDiv) ;
		  Handled := true ;
    end ;
    VK_RETURN : begin
  		btnTot.OnClick(btnTot) ;
	  	Handled := true ;
    end ;
    VK_BACK : begin
      Calc.DelNumber ;
	    Display(Calc.Entry) ;
    	Handled := true ;
    end ;        
    VK_DELETE : begin
  		btnCE.OnClick(btnCE) ;
	  	Handled := true ;
    end ;
    VK_ESCAPE : begin
  		btnC.OnClick(btnC) ;
	  	Handled := true ;
    end ;
  end ;
end;

end.


