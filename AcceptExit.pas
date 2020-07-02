unit AcceptExit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfmAcceptExit = class(TForm)
    YesEx: TBitBtn;
    NoEx: TBitBtn;
    Image1: TImage;
    procedure YesExClick(Sender: TObject);
    procedure NoExClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAcceptExit: TfmAcceptExit;

implementation
uses
  Menu;

{$R *.dfm}

procedure TfmAcceptExit.FormCreate(Sender: TObject);
begin
  DoubleBuffered:= true;
end;

procedure TfmAcceptExit.NoExClick(Sender: TObject);
begin
  Close;
end;

procedure TfmAcceptExit.YesExClick(Sender: TObject);
begin
  fmMenu.Close;
end;

end.
