/// Модуль для рендеринга функций на системе кординат
unit GraphPlotter;

interface
uses GraphABC;

type
  CartesianSystem = class
    private
      fPixelUnit: integer;
      fCenter: Point;
      fTickValue: real;
    public
      /// Создает систему координат по параметрам:
      ///PixelUnit - размер (в пикселя) единичного отрезка
      ///TickValue - единичный отрезок
      constructor Create(PixelUnit: integer; TickValue: real);

      /// Генератор горизонтальной разметки
      function HorizontalSegmentGenerator(): sequence of (Point, real);
      /// Генератор вертикальной разметки
      function VerticalSegmentGenerator(): sequence of (Point, real);

      /// Рисует оси координат и разметку с подписями
      procedure Render();
      /// Рендерит оси кординат
      procedure RenderAxis();
      /// Рисует разметку осей
      procedure RenderSegments();
      /// Рисует подписи разметке
      procedure RenderSegmentLabel();
      /// Рисует график функции на отрезке от a до b
      procedure RenderFunction(f: real -> real; a, b: real; caption: string := '');
  end;


function Simpson(f: real -> real; a, b: real; n: integer): real;
function Area(a, b: real; n: integer): real;


implementation


constructor CartesianSystem.Create(PixelUnit: integer; TickValue: real);
begin
  self.fPixelUnit := PixelUnit;
  self.fCenter := new Point(Window.Center.X, Window.Center.Y);
  self.fTickValue := TickValue;
end;

function CartesianSystem.HorizontalSegmentGenerator(): sequence of (Point, real);
begin
  var Y := self.fCenter.Y;
  
  // ЦЕНТР 
  yield (new Point(self.fCenter.X, Y), 0);

  // ЛЕВАЯ ПОЛОВИНА
  var X := self.fCenter.X - self.fPixelUnit;
  var TickValue := -self.fTickValue;
  
  while X >= 0 do
  begin
    yield (new Point(X, Y), TickValue);
    
    X -= self.fPixelUnit;
    TickValue -= self.fTickValue;
  end;

  // ПРАВАЯ ПОЛОВИНА
  X := self.fCenter.X + self.fPixelUnit;
  TickValue := self.fTickValue;
  
  while X <= Window.Width do
  begin
    yield (new Point(X, Y), TickValue);
    
    X += self.fPixelUnit;
    TickValue += self.fTickValue;
  end;
end;


function CartesianSystem.VerticalSegmentGenerator(): sequence of (Point, real);
begin
  var X := self.fCenter.X;
  
  // ВЕРХНЯЯ ПОЛОВИНА
  var Y := self.fCenter.Y - self.fPixelUnit;
  var TickValue := self.fTickValue;
  
  while Y >= 0 do
  begin
    yield (new Point(X, Y), TickValue);

    Y -= self.fPixelUnit;
    TickValue += self.fTickValue;
  end;

  // НИЖНЯЯ ПОЛОВИНА
  Y := self.fCenter.Y + self.fPixelUnit;
  TickValue := -self.fTickValue;
  
  while Y <= Window.Height do
  begin
    yield (new Point(X, Y), TickValue);

    Y += self.fPixelUnit;
    TickValue -= self.fTickValue;
  end;
end;


procedure CartesianSystem.Render();
begin
  self.RenderAxis();
  self.RenderSegments();
  self.RenderSegmentLabel();
end;


procedure CartesianSystem.RenderAxis();
begin
  var WH := Window.Height;
  var WW := Window.Width;

  var HorizontalLeft := new Point(0, WH div 2);
  var HorizontalRight := new Point(WW, WH div 2);
  var VerticalTop := new Point(WW div 2, 0);
  var VerticalBottom := new Point(WW div 2, WH);

  // РЕНДЕР ОСИ X
  Line(HorizontalLeft.X, HorizontalLeft.Y, HorizontalRight.X, HorizontalRight.Y);
  // РЕНДЕР ОСИ Y
  Line(VerticalTop.X, VerticalTop.Y, VerticalBottom.X, VerticalBottom.Y);
end;


procedure CartesianSystem.RenderSegments();
begin
  // РЕНДЕР ОТРЕЗКОВ ПО ОСИ X
  foreach var segment in self.HorizontalSegmentGenerator() do
  begin
    Circle(segment.Item1.X, segment.Item1.Y, Pen.Width);
  end;

  // РЕНДЕР ОТРЕЗКОВ ПО ОСИ Y
  foreach var segment in self.VerticalSegmentGenerator() do
  begin
    Circle(segment.Item1.X, segment.Item1.Y, Pen.Width);
  end;
end;


procedure CartesianSystem.RenderSegmentLabel();
begin
  // РЕНДЕР ПОДПИСЕЙ ОТРЕЗКОВ ПО ОСИ X
  foreach var segment in self.HorizontalSegmentGenerator() do
  begin
    var Apex := segment[0];
    var LabelValue := segment[1];

    if LabelValue = 0 then continue;

    var TextW := TextWidth(LabelValue.ToString());
    var TextPoint := new Point(Apex.X - TextW div 2, Apex.Y + 3);

    TextOut(TextPoint.X, TextPoint.Y, LabelValue.ToString());
  end;

  // РЕНДЕР ПОДПИСЕЙ ОТРЕЗКОВ ПО ОСИ Y
  foreach var segment in self.VerticalSegmentGenerator() do
  begin
    var Apex := segment[0];
    var LabelValue := segment[1];

    if LabelValue = 0 then continue;

    var TextH := TextHeight(LabelValue.ToString());
    var TextPoint := new Point(Apex.X + 3, Apex.Y - TextH div 2);

    TextOut(TextPoint.X, TextPoint.Y, LabelValue.ToString());
  end;
end;


procedure CartesianSystem.RenderFunction(f: real -> real; a, b: real; caption: string);
begin
  var IsFirst := true;
  var x := a;
  
  while x <= b do
  begin
    try
      var y := f(x);
      var ScreenX := self.fCenter.X + Round(x * self.fPixelUnit / self.fTickValue);
      var ScreenY := self.fCenter.Y - Round(y * self.fPixelUnit / self.fTickValue);
      
      if IsFirst then
      begin
        MoveTo(ScreenX, ScreenY);
        IsFirst := false;
      end
      else
      begin
        LineTo(ScreenX, ScreenY);
      end;
    except
      isFirst := true;
    end;
    x += 0.01;
  end;
  
  if caption <> '' then
    Println($'f(x) = {caption}');
  
  var n := Round((b - a) * 10);
  var Area := Round(Area(a, b, n), 3);
  Println($'S фигуры на отрезке ({a}; {b}) = {Area}');
end;


function Simpson(f: real -> real; a, b: real; n: integer): real;
begin
  if n mod 2 <> 0 then
    raise new Exception('n должно быть четным');

  var h := (b - a) / n;
  var x := new real[n+1];
  var y := new real[n+1];

  for var i := 0 to n do
    x[i] := a + i * h;

  foreach var i in 0..n do
    y[i] := f(x[i]);

  var total := y[0] + y[n];

  foreach var i in 1..n-1 do
    if i mod 2 = 1 then
      total += 4 * y[i]
    else
      total += 2 * y[i];

  Result := (h / 3) * total;
end;

function Area(a, b: real; n: integer): real;
begin
  var f: real -> real := x -> Max(2*Power(x, 3) - Sqr(x) + x + 2, 0);
  Result := Simpson(f, a, b, n);
end;

end.