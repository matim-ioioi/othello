unit Menu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons, Game, Help, AcceptExit, Info;

type
  TfmMenu = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Play: TBitBtn;
    Help: TBitBtn;
    Exit: TBitBtn;
    Info: TButton;
    Flag: TImage;
    procedure ExitClick(Sender: TObject);
    procedure PlayClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FlagClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TLanguage = (lRus, lEng);

var
  fmMenu: TfmMenu;
  Lang: TLanguage;

implementation

var
  bmRus, bmEng, bmPlayRus, bmHelpRus, bmExitRus, bmPlayEng, bmHelpEng, bmExitEng,
  bmAcceptExRus, bmAcceptExEng, bmInfoRus, bmInfoEng, bmHELPINGeng, bmHELPINGrus: TBitMap;
{$R *.dfm}

procedure TfmMenu.PlayClick(Sender: TObject);
begin
  if (Lang = lEng) then
  begin
    fmGame.AmBlack.Caption:= 'Black chips: 2';
    fmGame.AmWhite.Caption:= 'White chips: 2';
    fmGame.WhatMove.Caption:= 'Black`s   turn';
    fmGame.miGame.Caption:= 'Game';
    fmGame.miNG.Caption:= 'New game';
    fmGame.miTMM.Caption:= 'To main menu';
    fmGame.miLTG.CAption:= 'Leave the game';
    fmGame.miHelp.Caption:= 'Help';
    fmGame.miInfo.Caption:= 'Info';
  end
  else
  begin
    fmGame.AmBlack.Caption:= 'Чёрных фишек: 2';
    fmGame.AmWhite.Caption:= 'Белых фишек: 2';
    fmGame.WhatMove.Caption:= 'Ход чёрных';
    fmGame.miGame.Caption:= 'Игра';
    fmGame.miNG.Caption:= 'Новая игра';
    fmGame.miTMM.Caption:= 'В главное меню';
    fmGame.miLTG.CAption:= 'Выйти из игры';
    fmGame.miHelp.Caption:= 'Помощь';
    fmGame.miInfo.Caption:= 'Инфо';
  end;
  fmGame.ShowModal;
end;

procedure TfmMenu.FormCreate(Sender: TObject);
begin
  bmRus:= TBitmap.Create;
  bmRus.LoadFromFile('pictures/rus.bmp');
  bmEng:= TBitmap.Create;
  bmEng.LoadFromFile('pictures/eng.bmp');
  bmPlayRus:= TBitmap.Create;
  bmPlayRus.LoadFromFile('pictures/btnstrus.bmp');
  bmHelpRus:= TBitmap.Create;
  bmHelpRus.LoadFromFile('pictures/btnherus.bmp');
  bmExitRus:= TBitmap.Create;
  bmExitRus.LoadFromFile('pictures/btnexrus.bmp');
  bmPlayEng:= TBitmap.Create;
  bmPlayEng.LoadFromFile('pictures/btnsteng.bmp');
  bmHelpEng:= TBitmap.Create;
  bmHelpEng.LoadFromFile('pictures/btnheeng.bmp');
  bmExitEng:= TBitmap.Create;
  bmExitEng.LoadFromFile('pictures/btnexeng.bmp');
  bmAcceptExRus:= TBitmap.Create;
  bmAcceptExRus.LoadFromFile('pictures/acceptexitrus.bmp');
  bmAcceptExEng:= TBitmap.Create;
  bmAcceptExEng.LoadFromFile('pictures/acceptexiteng.bmp');
  bmInfoRus:= TBitmap.Create;
  bmInfoRus.LoadFromFile('pictures/inforus.bmp');
  bmInfoEng:= TBitmap.Create;
  bmInfoEng.LoadFromFile('pictures/infoeng.bmp');
  bmHELPINGrus:= TBitmap.Create;
  bmHELPINGrus.LoadFromFile('pictures/helprus.bmp');
  bmHELPINGeng:= TBitmap.Create;
  bmHELPINGeng.LoadFromFile('pictures/helpeng.bmp');
  Lang:= lEng;
end;

procedure TfmMenu.HelpClick(Sender: TObject);
begin
  if (Lang = lEng) then fmHelp.Image1.Picture.Bitmap:= bmHELPINGeng
  else fmHelp.Image1.Picture.Bitmap:= bmHELPINGrus;
  fmHelp.ShowModal;
end;

procedure TfmMenu.FlagClick(Sender: TObject);
begin
  if (Lang = lEng) then
  begin
    Lang:= lRus;
    Flag.Picture.Bitmap:= bmRus;
    Play.Glyph:= bmPlayRus;
    Help.Glyph:= bmHelpRus;
    Exit.Glyph:= bmExitRus;
    Label1.Left:= 317;
    Label1.Caption:= 'МЕНЮ';
    Info.Caption:= 'инфо';
    fmAcceptExit.Image1.Picture.Bitmap:= bmAcceptExRus;
    fmAcceptExit.YesEx.Caption:= 'Ага!';
    fmAcceptExit.NoEx.Caption:= 'Не-а!';
    fmInfo.Image1.Picture.Bitmap:= bmInfoRus;
  end
  else
  begin
    Lang:= lEng;
    Flag.Picture.Bitmap:= bmEng;
    Play.Glyph:= bmPlayEng;
    Help.Glyph:= bmHelpEng;
    Exit.Glyph:= bmExitEng;
    Label1.Left:= 336;
    Label1.Caption:= 'MENU';
    Info.Caption:= 'info';
    fmAcceptExit.Image1.Picture.Bitmap:= bmAcceptExEng;
    fmAcceptExit.YesEx.Caption:= 'Yeah!';
    fmAcceptExit.NoEx.Caption:= 'Nope!';
    fmInfo.Image1.Picture.Bitmap:= bmInfoEng;
  end;
end;

procedure TfmMenu.InfoClick(Sender: TObject);
begin
  fmInfo.ShowModal;
end;

procedure TfmMenu.ExitClick(Sender: TObject);
begin
  fmAcceptExit.ShowModal;
end;

end.
