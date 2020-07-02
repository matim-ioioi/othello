program Othello;

uses
  Forms,
  Menu in 'Menu.pas' {fmMenu},
  Game in 'Game.pas' {fmGame},
  Help in 'Help.pas' {fmHelp},
  AcceptExit in 'AcceptExit.pas' {fmAcceptExit},
  Info in 'Info.pas' {fmInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMenu, fmMenu);
  Application.CreateForm(TfmGame, fmGame);
  Application.CreateForm(TfmHelp, fmHelp);
  Application.CreateForm(TfmAcceptExit, fmAcceptExit);
  Application.CreateForm(TfmInfo, fmInfo);
  Application.Run;
end.
