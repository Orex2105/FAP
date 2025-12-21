///Модуль для настройки глобальных параметров окна GraphABC
unit GraphApp;

interface
uses GraphABC;

type
App = class
  private
    fWindowWidth: integer;
    fWindowHeight: integer;
    fWindowCaption: string;
    fCenterWindow: boolean;
    fSmoothing: boolean;
    
    procedure SetFontSize(val: integer);
    procedure SetFontColor(clr: GraphABC.Color);
    procedure SetFontStyle(style: FontStyleType);
    
  public
    /// Ширина окна
    property Width: integer read fWindowHeight;
    /// Высота окна
    property Height: integer read fWindowHeight;
    
    /// Размер шрифта
    property FontSize: integer read Font.Size write SetFontSize;
    /// Цвет шрифта
    property FontColor: Color read Font.Color write SetFontColor;
    /// Стиль шрифта
    property FontStyle: FontStyleType read Font.Style write SetFontStyle;
    
    constructor Create(width, height: integer; caption: string := '';
                      center: boolean := true; smoothing: boolean := true);
    /// Применить настройки окна приложения
    procedure BuildApp();
    /// Очищает экран
    procedure Clear();
end;

/// Конвертация RGB в цвет
function RGBConvert(r: byte; g: byte; b: byte): Color;

implementation

constructor App.Create(width, height: integer; caption: string; center: boolean;
                   smoothing: boolean);
begin
  self.fWindowWidth := width;
  self.fWindowHeight := height;
  self.fWindowCaption := caption;
  self.fCenterWindow := center;
  self.fSmoothing := smoothing;
end;

procedure App.SetFontSize(val: integer);
begin
  Font.Size := val;
end;

procedure App.SetFontColor(clr: GraphABC.Color);
begin
  Font.Color := clr;
end;

procedure App.SetFontStyle(style: FontStyleType);
begin
  Font.Style := style;
end;

procedure App.BuildApp();
begin
  if (self.fWindowWidth <= 0) or (self.fWindowHeight <= 0) then
    (self.fWindowWidth, self.fWindowHeight) := (800, 600);
  
  Window.SetSize(self.fWindowWidth, self.fWindowHeight);
  SetSmoothing(self.fSmoothing);
  
  if self.fWindowCaption <> '' then
    SetWindowCaption(self.fWindowCaption);
  
  if self.fCenterWindow = true then CenterWindow();
end;

procedure App.Clear();
begin
  Window.Clear();
end;

function RGBConvert(r: byte; g: byte; b: byte): Color;
begin
  Result := RGB(r, g, b);
end;

end.