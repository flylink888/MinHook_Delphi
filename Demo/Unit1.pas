unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MinHook, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var
  MessageBoxWNextHook: function(hWnd: hWnd; lpText, lpCaption: PChar;
    uType: UINT): Integer; stdcall;

function MessageBoxWHookProc(hWnd: hWnd; lpText, lpCaption: PChar; uType: UINT)
  : Integer; stdcall;
begin
  Result := MessageBoxWNextHook(0, 'Hooked xxxxx', 'Hook测试', 0);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  pTarget: Pointer;
begin
  if (MH_Initialize() <> MH_OK) then
    Exit;

  // 方法一
  if (MH_CreateHookApiEx('user32', 'MessageBoxW', @MessageBoxWHookProc,
    @MessageBoxWNextHook, pTarget) <> MH_OK) then
    Exit;
  // 方法二
  // pTarget := GetProcAddress(LoadLibrary('user32.dll'), 'MessageBoxW');
  // if (MH_CreateHook(pTarget, @MessageBoxWHookProc, @MessageBoxWNextHook) <>
  // MH_OK) then
  // Exit;

  if (MH_EnableHook(pTarget) <> MH_OK) then
    Exit;

  // test the target API
  MessageBoxW(0, 'aaa', 'hi', 0);

  if (MH_DisableHook(pTarget) <> MH_OK) then
    Exit;

  // the message should be changed
  MessageBoxW(0, 'aaa', 'hi', 0);

  if (MH_Uninitialize() <> MH_OK) then
    Exit;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  pTarget: Pointer;
begin
  if (MH_Initialize() <> MH_OK) then
    Exit;

  // 方法一
  // if (MH_CreateHookApiEx('user32', 'MessageBoxW', @MessageBoxWHookProc,
  // @MessageBoxWNextHook, pTarget) <> MH_OK) then
  // Exit;
  // 方法二
  pTarget := GetProcAddress(LoadLibrary('user32.dll'), 'MessageBoxW');
  if (MH_CreateHook(pTarget, @MessageBoxWHookProc, @MessageBoxWNextHook) <>
    MH_OK) then
    Exit;

  if (MH_EnableHook(pTarget) <> MH_OK) then
    Exit;

  // test the target API
  MessageBoxW(0, 'aaa', 'hi', 0);

  if (MH_DisableHook(pTarget) <> MH_OK) then
    Exit;

  // the message should be changed
  MessageBoxW(0, 'aaa', 'hi', 0);

  if (MH_Uninitialize() <> MH_OK) then
    Exit;

end;

end.
