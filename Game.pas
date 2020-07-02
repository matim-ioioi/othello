unit Game;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Menus, StdCtrls;

type
  TfmGame = class(TForm)
    BG: TImage;
    WhatMove: TLabel;
    miGame: TMenuItem;
    miNG: TMenuItem;
    miLTG: TMenuItem;
    miHelp: TMenuItem;
    miInfo: TMenuItem;
    miTMM: TMenuItem;
    MainMenu: TMainMenu;
    AmBlack: TLabel;
    AmWhite: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BGMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure miNGClick(Sender: TObject);
    procedure miTMMClick(Sender: TObject);
    procedure miLTGClick(Sender: TObject);
    procedure miHelpClick(Sender: TObject);
    procedure miInfoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmGame: TfmGame;

implementation
uses
  Menu, Help, AcceptExit, Info;

type
  TCellType = (ctNone, ctWhite, ctBlack, ctReady);
  TPlayerType = (ptWhite, ptBlack);

var
  Board: array [1..8, 1..8] of TCellType;
  CurrentPlayer: TPlayerType;
  bmCellNone, bmCellWhite, bmCellBlack, bmCellReady: TBitmap;
  x0, y0, dx, dy, AmountWhite, AmountBlack: integer;
  CanWhiteMove, CanBlackMove, GameOver: boolean;

{$R *.dfm}

procedure CheckCell(x, y: integer; Reverse: boolean);
  function CheckLine(di, di1: integer): boolean;
  var
    ix, iy, i, LineCnt: integer;
    EndLine: boolean;
  begin
    Result:= false;
    EndLine:= false;
    LineCnt:= 0;
    ix:= x + di;
    iy:= y + di1;
    while not(EndLine) do
    begin
      if ((ix in [1..8]) and (iy in [1..8])) then
      begin
        case Board[ix, iy] of
          ctNone: EndLine:= true;
          ctReady: EndLine:= true;
          ctWhite:
          begin
            if (CurrentPlayer = ptBlack) then inc(LineCnt)
            else
            begin
              EndLine:= true;
              if (LineCnt > 0) then Result:= true;
            end;
          end;
          ctBlack:
          begin
            if (CurrentPlayer = ptWhite) then inc(LineCnt)
            else
            begin
              EndLine:= true;
              if (LineCnt > 0) then Result:= true;
            end;
          end;
        end;
        inc(ix, di);
        inc(iy, di1);
      end
      else EndLine:= true;
    end;
    if (Result and Reverse) then
    begin
      ix:= x;
      iy:= y;
      for i:= 1 to LineCnt do
      begin
        inc(ix, di);
        inc(iy, di1);
        if (CurrentPlayer = ptWhite) then Board[ix, iy]:= ctWhite
        else Board[ix, iy]:= ctBlack;
      end;
    end;
    if ((CurrentPlayer = ptWhite) and (Result)) then CanWhiteMove:= true;
    if ((CurrentPlayer = ptBlack) and (Result)) then CanBlackMove:= true;
  end;
begin
  {$B+}
  if (CheckLine(0, 1) and not(Reverse)) then Board[x, y]:= ctReady;
  if (CheckLine(0, -1) and not(Reverse)) then Board[x, y]:= ctReady;
  if (CheckLine(1, 0) and not(Reverse)) then Board[x, y]:= ctReady;
  if (CheckLine(-1, 0) and not(Reverse)) then Board[x, y]:= ctReady;
  if (CheckLine(1, 1) and not(Reverse)) then Board[x, y]:= ctReady;
  if (CheckLine(-1, 1) and not(Reverse)) then Board[x, y]:= ctReady;
  if (CheckLine(-1, -1) and not(Reverse)) then Board[x, y]:= ctReady;
  if (CheckLine(1, -1) and not(Reverse)) then Board[x, y]:= ctReady;
  {$B-}
end;

procedure InitBoard;
var
  i, i1: integer;
begin
  for i:= 1 to 8 do
    for i1:= 1 to 8 do
      Board[i, i1]:= ctNone;
  Board[4, 4]:= ctWhite;
  Board[5, 5]:= ctWhite;
  Board[4, 5]:= ctBlack;
  Board[5, 4]:= ctBlack;
  GameOver:= false;
  CurrentPlayer:= ptBlack;
  x0:= 25;
  y0:= 25;
  for i:= 1 to 8 do
    for i1:= 1 to 8 do
      if (Board[i, i1] = ctNone) then CheckCell(i, i1, false);
end;

procedure DrawBoard;
var
  i, i1, x, y: integer;
begin
  fmGame.BG.Canvas.Pen.Color:= RGB(170, 105, 70);
  fmGame.BG.Canvas.Brush.Color:= RGB(170, 105, 70);
  fmGame.BG.Canvas.Rectangle(x0-7, y0-7, x0+dx*8+7, y0+dy*8+7);
  fmGame.BG.Canvas.Pen.Color:= clBlack;
  fmGame.BG.Canvas.Brush.Color:= clBlack;
  fmGame.BG.Canvas.Rectangle(x0-5, y0-5, x0+dx*8+5, y0+dy*8+5);
  fmGame.BG.Canvas.Pen.Color:= RGB(238, 255, 95);
  fmGame.BG.Canvas.Brush.Color:= RGB(238, 255, 95);
  fmGame.BG.Canvas.Rectangle(x0+4*dx-7, y0-9, x0+4*dx+7, y0-7);
  for i:= 1 to 8 do
    for i1:= 1 to 8 do
    begin
      x:= x0 + (i1 - 1) * dx;
      y:= y0 + (i - 1) * dy;
      case Board[i, i1] of
        ctNone: fmGame.BG.Canvas.Draw(x, y, bmCellNone);
        ctWhite: fmGame.BG.Canvas.Draw(x, y, bmCellWhite);
        ctBlack: fmGame.BG.Canvas.Draw(x, y, bmCellBlack);
        ctReady: fmGame.BG.Canvas.Draw(x, y, bmCellReady);
      end;
    end;
  fmGame.BG.Canvas.Pen.Color:= RGB(57, 0, 48);
  fmGame.BG.Canvas.Brush.Color:= RGB(57, 0, 48);
  fmGame.BG.Canvas.Rectangle(x0-7, y0+dy*4-1, x0+dx*8+7, y0+dy*4+1);
end;

procedure ClearReady;
var
  i, i1: integer;
begin
  for i:= 1 to 8 do
    for i1:= 1 to 8 do
      if (Board[i, i1] = ctReady) then Board[i, i1]:= ctNone;
end;

procedure NextMove;
  procedure CheckReady;
  var
    i, i1: integer;
  begin
    ClearReady;
    CanWhiteMove:= false;
    CanBlackMove:= false;
    for i:= 1 to 8 do
      for i1:= 1 to 8 do
        if (Board[i, i1] = ctNone) then CheckCell(i, i1, false);
  end;
begin
  CheckReady;
  case CurrentPlayer of
    ptWhite:
    begin
      if not(CanWhiteMove) then
      begin
        CurrentPlayer:= ptBlack;
        CheckReady;
        GameOver:= not(CanBlackMove);
      end;
    end;
    ptBlack:
    begin
      if not(CanBlackMove) then
      begin
        CurrentPlayer:= ptWhite;
        CheckReady;
        GameOver:= not(CanWhiteMove);
      end;
    end;
  end;
end;

procedure SetChip(x, y: integer);
var
  i, i1: integer;
begin
  if ((x <= x0) or (x >= x0+dx*8)) then Exit;
  if ((y <= y0) or (y >= y0+dy*8)) then Exit;
  i:= (y - y0) div dy + 1;
  i1:= (x - x0) div dx + 1;
  if (Board[i, i1] = ctReady) then
  case CurrentPlayer of
    ptWhite:
    begin
      Board[i, i1]:= ctWhite;
      CheckCell(i, i1, true);
      CurrentPlayer:= ptBlack;
    end;
    ptBlack:
    begin
      Board[i, i1]:= ctBlack;
      CheckCell(i, i1, true);
      CurrentPlayer:= ptWhite;
    end;
  end;
end;

procedure EndGame;
var
  i, i1: integer;
begin
  for i:= 1 to 8 do
    for i1:= 1 to 8 do
      if (Board[i, i1] = ctWhite) then inc(AmountWhite)
      else if (Board[i, i1] = ctBlack) then inc(AmountBlack);
  if (AmountWhite > AmountBlack) then
    if (Lang = lEng) then fmGame.WhatMove.Caption:= 'White`s won!'
    else fmGame.WhatMove.Caption:= '����� ��������!'
  else
    if (Lang = lEng) then fmGame.WhatMove.Caption:= 'Black`s   won!'
    else fmGame.WhatMove.Caption:= '׸���� ��������!';
end;

procedure TfmGame.BGMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i, i1: integer;
begin
  if ((x <= x0) or (x >= x0+dx*8)) then Exit;
  if ((y <= y0) or (y >= y0+dy*8)) then Exit;
  SetChip(x, y);
  NextMove;
  DrawBoard;
  if (GameOver) then EndGame;
  if not(GameOver) then
  begin
    if CurrentPlayer = ptBlack then
      if (Lang = lEng) then WhatMove.Caption:= 'Black`s   turn'
      else WhatMove.Caption:= '��� ������'
    else
      if (Lang = lEng) then WhatMove.Caption:= 'White`s   turn'
      else WhatMove.Caption:= '��� �����';
    for i:= 1 to 8 do
      for i1:= 1 to 8 do
        if (Board[i, i1] = ctWhite) then inc(AmountWhite)
        else if (Board[i, i1] = ctBlack) then inc(AmountBlack);
  end;
  if (Lang = lEng) then
  begin
    AmBlack.Caption:= 'Black chips: ' + IntToStr(AmountBlack);
    AmWhite.Caption:= 'White chips: ' + IntToStr(AmountWhite);
  end
  else
  begin
    AmBlack.Caption:= '׸���� �����: ' + IntToStr(AmountBlack);
    AmWhite.Caption:= '����� �����: ' + IntToStr(AmountWhite);
  end;
  AmountBlack:= 0;
  AmountWhite:= 0;
end;

procedure TfmGame.FormCreate(Sender: TObject);
begin
  bmCellNone:= TBitmap.Create;
  bmCellNone.LoadFromFile('pictures/cellnone.bmp');
  bmCellWhite:= TBitmap.Create;
  bmCellWhite.LoadFromFile('pictures/cellwhite.bmp');
  bmCellBlack:= TBitmap.Create;
  bmCellBlack.LoadFromFile('pictures/cellblack.bmp');
  bmCellReady:= TBitmap.Create;
  bmCellReady.LoadFromFile('pictures/cellready.bmp');
  dx:= bmCellNone.Width;
  dy:= bmCellNone.Height;
  DoubleBuffered:= true;
  InitBoard;
  DrawBoard;
end;

procedure TfmGame.FormDestroy(Sender: TObject);
begin
  bmCellNone.Free;
  bmCellWhite.Free;
  bmCellBlack.Free;
  bmCellReady.Free;
end;

procedure TfmGame.miHelpClick(Sender: TObject);
begin
  fmMenu.HelpClick(Help.fmHelp);
end;

procedure TfmGame.miInfoClick(Sender: TObject);
begin
  fmInfo.ShowModal;
end;

procedure TfmGame.miLTGClick(Sender: TObject);
begin
  fmAcceptExit.ShowModal;
end;

procedure TfmGame.miNGClick(Sender: TObject);
begin
  InitBoard;
  DrawBoard;
  if (Lang = lEng) then
  begin
    fmGame.AmBlack.Caption:= 'Black chips: 2';
    fmGame.AmWhite.Caption:= 'White chips: 2';
    fmGame.WhatMove.Caption:= 'Black`s   turn';
  end
  else
  begin
    fmGame.AmBlack.Caption:= '׸���� �����: 2';
    fmGame.AmWhite.Caption:= '����� �����: 2';
    fmGame.WhatMove.Caption:= '��� ������';
  end;
end;

procedure TfmGame.miTMMClick(Sender: TObject);
begin
  InitBoard;
  DrawBoard;
  Close;
end;

end.
