unit Main;

interface

uses
  {$IFDEF MSWINDOWS}
  Winapi.Windows, Winapi.Messages,
  FMX.WinForm,
  {$ENDIF}
  System.SysUtils, System.Types, System.UITypes, System.Classes, FMX.Forms;

type
  TMainForm = class({$IFDEF MSWINDOWS}TWinForm{$ELSE}TForm{$ENDIF})
  {$IFDEF MSWINDOWS}
  private
    FMousePos: TPoint;
    FLastMsg: TMessage;
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
  {$ENDIF}
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

{$IFDEF MSWINDOWS}

procedure TMainForm.WndProc(var Message: TMessage);
begin
  inherited;
  if Message.Msg = WM_PAINT then Exit;
  if Message.Msg <> WM_MOUSEMOVE then
    FLastMsg := Message;
  Winapi.Windows.InvalidateRect(Wnd, TRect.Create(0, 0, Width, 100), False);
end;

procedure TMainForm.WMPaint(var Message: TWMPaint);
var
  LDC: HDC;
  LPS: TPaintStruct;
  LText: String;
begin
  LDC := BeginPaint(Wnd, LPS);
  try
    FillRect(LDC, ClientRect.Truncate, GetStockObject(WHITE_BRUSH));
    SetTextColor(LDC, TColorRec.Black);
    LText := 'Drawing text inside WM_PAINT!';
    TextOut(LDC, 10, 10, PChar(LText), LText.Length);
    SetTextColor(LDC, TColorRec.Blue);
    LText := Format('WM_MOUSEMOVE: X = %d; Y = %d', [FMousePos.X, FMousePos.Y]);
    TextOut(LDC, 10, 30, PChar(LText), LText.Length);
    LText := Format('Last message: ID = $%s; WParam = %d; LParam = %d; Result = %d', [
      IntToHex(FLastMsg.Msg), FLastMsg.WParam, FLastMsg.LParam, FLastMsg.Result
    ]);
    TextOut(LDC, 10, 50, PChar(LText), LText.Length);
  finally
    EndPaint(Wnd, LPS);
  end;
end;

procedure TMainForm.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  FMousePos := TPoint.Create(Message.XPos, Message.YPos);
end;

{$ENDIF}

end.
