program SimpleCalc;



uses
  Forms,
  FormCalc in 'FormCalc.pas' {frmCalc},
  UnitCalc in 'UnitCalc.pas',
  FormAbout in 'FormAbout.pas' {frmAbout};

{$R *.res}
{$R Ressources\WinXP.res}

begin
  Application.Initialize;
  Application.Title := 'SimpleCalculator';
  Application.CreateForm(TfrmCalc, frmCalc);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
