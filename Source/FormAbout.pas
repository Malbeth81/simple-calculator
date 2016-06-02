(* SimpleCalculator ***********************************************)
(* Copyright (c) 2003 Marc-Andre Lamothe ***************************)
(* All rights reserved *********************************************)

unit FormAbout;

interface

uses
  Windows, Messages, Classes, Graphics, ExtCtrls, Controls, StdCtrls,
  Forms, ShellAPI ;
           
const
  Version = 'version 1.3.0' ;
  
type
  TfrmAbout = class(TForm)
    btnOk: TButton;
    Panel1: TPanel;
    lblVersion: TLabel;
    lblCopyright: TLabel;
    lblWeb: TLabel;
    Image2: TImage;
    Label1: TLabel;
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure btnOkClick(Sender: TObject);
    procedure lblWebClick(Sender: TObject);
    function Dialog (Title : String) : Boolean ;
  private             
  public
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

function TfrmAbout.Dialog (Title : String) : Boolean ;
begin
  frmAbout.Caption := Title ;
  frmAbout.lblVersion.Caption := Version ;
  if frmAbout.ShowModal = mrOk then
    Result := True
  else
    result := False ;
end ;

procedure TfrmAbout.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if Msg.CharCode = VK_ESCAPE	then
  begin
    btnOk.Click ;
    Handled := True ;
  end ;
end;

procedure TfrmAbout.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk ;
end;

procedure TfrmAbout.lblWebClick(Sender: TObject);
begin
  ShellExecute(HWND(nil), 'open', PChar(lblWeb.Caption), nil, nil, SW_SHOW)
end;

end.
