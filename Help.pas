unit Help;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TfmHelp = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Timer1: TTimer;
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmHelp: TfmHelp;

implementation

var
  bmHelpBoard1, bmHelpBoard2, bmHelpBoard3: TBitMap;
  CurrBMP: integer;
{$R *.dfm}

procedure TfmHelp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled:= false;
  Image2.Picture.Bitmap:= bmHelpBoard1;
end;

procedure TfmHelp.FormCreate(Sender: TObject);
begin
  bmHelpBoard1:= TBitmap.Create;
  bmHelpBoard1.LoadFromFile('pictures/helpboard1.bmp');
  bmHelpBoard2:= TBitmap.Create;
  bmHelpBoard2.LoadFromFile('pictures/helpboard2.bmp');
  bmHelpBoard3:= TBitmap.Create;
  bmHelpBoard3.LoadFromFile('pictures/helpboard3.bmp');
  DoubleBuffered:= true;
  Timer1.Enabled:= false;
end;

procedure TfmHelp.FormDestroy(Sender: TObject);
begin
  bmHelpBoard1.Free;
  bmHelpBoard2.Free;
  bmHelpBoard3.Free;
end;

procedure TfmHelp.FormShow(Sender: TObject);
begin
  Timer1.Enabled:= true;
  CurrBMP:= 1;
end;

procedure TfmHelp.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmHelp.Image2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmHelp.Timer1Timer(Sender: TObject);
begin
  case CurrBMP of
    1:
      begin
        CurrBMP:= 2;
        Image2.Picture.Bitmap:= bmHelpBoard2;
      end;
    2:
      begin
        CurrBMP:= 3;
        Image2.Picture.Bitmap:= bmHelpBoard3;
      end;
    3:
      begin
        CurrBMP:= 1;
        Image2.Picture.Bitmap:= bmHelpBoard1;
      end;
  end;
end;

end.
