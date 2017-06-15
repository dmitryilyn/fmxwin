program WinFormDemo;

uses
  System.StartUpCopy,
  {$IFDEF MSWINDOWS}
  FMX.WinForm in '..\..\FMX.WinForm.pas',
  {$ENDIF}
  FMX.Forms,
  Main in 'Main.pas' {MainForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
