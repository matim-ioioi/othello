unit Info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TfmInfo = class(TForm)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmInfo: TfmInfo;

implementation

{$R *.dfm}

procedure TfmInfo.FormCreate(Sender: TObject);
begin
  DoubleBuffered:= true;
end;

procedure TfmInfo.Image1Click(Sender: TObject);
begin
  Close;
end;

end.
