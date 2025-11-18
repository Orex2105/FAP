uses GraphABC;

const
Width = 800;
Height = 600;

type
Apex = record
  X: integer;
  Y: integer;
end;

Triangle = class
  private
    fA: Apex;
    fB: Apex;
    fC: Apex;
  public
    constructor Create(a: Apex; b: Apex; c: Apex);
    begin
      self.fA := a;
      self.fB := b;
      self.fC := c;
    end;
    
    property A: Apex read fA;
    property B: Apex read fB;
    property C: Apex read fC;
    
  procedure Draw();
  begin
    MoveTo(self.fA.X, self.fA.Y);
    LineTo(self.fB.X, self.fB.Y);
    LineTo(self.fC.X, self.fC.Y);
    LineTo(self.fA.X, self.fA.Y);
  end;
end;

TCircle = class
  private
    fCenter: Apex;
    fR: integer;
  public
    constructor Create(Center: Apex; R: integer);
    begin
      self.fCenter := Center;
      self.fR := R;
    end;
    
    property Center: Apex read fCenter;
    property R: integer read fR;
  
  procedure Draw();
  begin
    Circle(self.fCenter.X, self.fCenter.Y, self.fR);
  end;
  
  procedure RandomFill();
  begin
    SetBrushColor(rgb(random(256), random(256), random(256)));
    FillCircle(self.fCenter.X, self.fCenter.Y, self.fR);
  end;
end;

procedure SetDefaultPen();
begin
  SetPenColor(clblack);
  SetPenWidth(2);
end;


procedure Task1(Width: integer; Height: integer);
begin  
  SetDefaultPen();
  // Первая окружность
  var center: Apex;
  (center.X, center.Y) := (Width div 10, Height div 2);
  var Crl1 := new TCircle(center, 50);
  
  Crl1.Draw();
  FloodFill(Crl1.Center.X, Crl1.Center.Y, clred);
  
  // Вторая окружность
  (center.X, center.Y) := (Width - Width div 10, Height div 2);
  var Crl2 := new TCircle(center, 50);

  Crl2.Draw();
  FloodFill(Crl2.Center.X, Crl2.Center.Y, RGB(255, 255, 0));
  
  // Нижний треугольник
  var a, b, c: Apex;
  (a.X, a.Y) := (Crl1.Center.X + Crl1.R, Crl1.Center.Y);
  (b.X, b.Y) := (Crl2.Center.X - Crl2.R, Crl2.Center.Y);
  (c.X, c.Y) := (Width div 2, Crl1.Center.Y + Crl1.R * 2);
  var Trl1 := new Triangle(a, b, c);
  
  Trl1.Draw();
  FloodFill(Width div 2, Crl1.Center.Y + Crl1.R, RGB(1, 254, 0));
  
  // Верхний треугольник
  (a.X, a.Y) := (Crl1.Center.X + Crl1.R, Crl1.Center.Y);
  (b.X, b.Y) := (Crl2.Center.X - Crl2.R, Crl2.Center.Y);
  (c.X, c.Y) := (Width div 2, Crl1.Center.Y - Crl1.R * 2);
  var Trl2 := new Triangle(a, b, c);
  
  Trl2.Draw();
  FloodFill(Width div 2, Crl1.Center.Y - Crl1.R, RGB(50, 51, 254));
end;


procedure Task2(Width: integer; Height: integer);
begin
  var a, b, c: Apex;
  var r := 30;
  SetDefaultPen();
  // Основание
  var (BaseLX, BaseRX) := (Width div 4, Width - Width div 4);
  var BaseY := Height;
  var BaseDelta := Width - BaseLX * 2;
  
  MoveTo(BaseLX, BaseY);
  LineTo(BaseRX, BaseY);
  
  // Левый треугольник
  (a.X, a.Y) := (BaseLX div 3, r * 3);
  (b.X, b.Y) := (BaseLX, BaseY);
  (c.X, c.Y) := (BaseLX + (BaseDelta div 4) * 3, BaseY);
  var Triangle1 := new Triangle(a, b, c);
  
  Triangle1.Draw();
  FloodFill(BaseLX, BaseY - r, RGB(0, 0, 255));
  
  // Правый труегольник
  (a.X, a.Y) := (BaseLX + (BaseDelta div 4), BaseY);
  (b.X, b.Y) := (BaseRX + (BaseLX div 3) * 2, r * 3);
  (c.X, c.Y) := (BaseRX, BaseY);
  var Triangle2 := new Triangle(a, b, c);
  
  Triangle2.Draw();
  FloodFill(BaseRX, BaseY - r, RGB(0, 255, 0));
  
  // Центральный треугольник
  (a.X, a.Y) := (BaseLX + (BaseDelta div 4), BaseY);
  (b.X, b.Y) := (Width div 2, r);
  (c.X, c.Y) := (Triangle1.C.X, BaseY);
  var Triangle3 := new Triangle(a, b, c);
  
  Triangle3.Draw();
  
  var points := new Point[3];
  points[0] := new Point(Triangle3.A.X, Triangle3.A.Y);
  points[1] := new Point(Triangle3.B.X, Triangle3.B.Y);
  points[2] := new Point(Triangle3.C.X, Triangle3.C.Y);
  
  SetBrushColor(clRed);
  FillPolygon(points);
  
  // Оркужности
  var center: Apex;
  (center.X, center.Y) := (Triangle1.A.X, Triangle1.A.Y);
  var Crl1 := new TCircle(center, r);
  Crl1.Draw();
  SetBrushColor(clBlue);
  FillCircle(Triangle1.A.X, Triangle1.A.Y, r);
  
  (center.X, center.Y) := (Triangle2.B.X, Triangle2.B.Y);
  var Crl2 := new TCircle(center, r);
  Crl2.Draw();
  SetBrushColor(RGB(0, 255, 0));
  FillCircle(Triangle2.B.X, Triangle2.B.Y, r);
  
  (center.X, center.Y) := (Triangle3.B.X, Triangle3.B.Y);
  var Crl3 := new TCircle(center, r);
  Crl3.Draw();
  SetBrushColor(clRed);
  FillCircle(Triangle3.B.X, Triangle3.B.Y, r);
end;


function CircleGenerator(pattern: integer): sequence of TCircle;
begin
  case pattern of
    1:
      for var i := 50 to Width - 30 step 30 do
      begin
        var center := new Apex;
        (center.X, center.Y) := (i, 100);
        yield new TCircle(center, 10);
      end;
    2:
      begin
        var center := new Apex;
        (center.X, center.Y) := (Random(Width), Random(Height));
        for var i := 1 to 20 do
        begin
          yield new TCircle(center, Random(200));
        end;
      end;
    3:
      begin
        var center := new Apex;
        (center.X, center.Y) := (Width div 10, Height div 10);
        var r := 10;
        yield new TCircle(center, r);
        
        for var i := 1 to 7 do
        begin
          (center.X, center.Y) := (Ceil(center.X*1.3), Ceil(center.Y*1.3));
          r := Ceil(r*1.3);
          yield new TCircle(center, r)
        end;
      end;
  end;
end;


procedure Task3(Width: integer; Height: integer);
begin
  foreach var crl in CircleGenerator(1) do
  begin
    crl.Draw();
    crl.RandomFill();
  end;
end;


procedure Task4(Width: integer; Height: integer);
begin
  foreach var crl in CircleGenerator(2) do
    crl.draw();
end;


procedure Task5(Width: integer; Height: integer);
begin
  foreach var crl in CircleGenerator(3) do
  begin
    crl.Draw();
    crl.RandomFill();
  end;
end;


procedure Task6(Width: integer; Height: integer);
begin
  var (x1, y1) := (0, 0);
  var (x2, y2) := (Width, Height);
  var N := 8;
  var h := (x2 - x1) / N;
  
  for var i := 0 to N-1 do
    for var j := 0 to N-1 do
    begin
      if (i + j) mod 2 = 0 then
        Brush.Color := clWhite
      else
        Brush.Color := clBlack;
      
      FillRect(Round(x1 + j * h), Round(y1 + i * h),
      Round(x1 + (j+1) * h), Round(y1 + (i+1) * h));
    end;
  
  Pen.Color := clBlack;
  var x := x1;
  for var i := 0 to N do
  begin
    Line(round(x), y1, round(x), y2);
    x += Round(h);
  end;
  
  var y := y1;
  for var i := 0 to N do
  begin
    Line(x1, Round(y), x2, Round(y));
    y += Round(h)
  end;
end;


procedure Task7(Width: integer; Height: integer);
begin
  var (x, y) := (Width div 10, Height);
  
  while y > 0 do
  begin
    SetPenColor(clWhite);
    Rectangle(x, y, x+5, y+5);
    SetPenColor(clBlack);
    Rectangle(x, y, x+10, y+10);
    x += 1;
    y -= 2;
  end;
  
  while y < Height do
  begin
    SetPenColor(clWhite);
    Rectangle(x, y, x+5, y+5);
    SetPenColor(clBlack);
    Rectangle(x, y, x+10, y+10);
    x += 1;
    y += 2;
  end;
end;


begin
  SetWindowWidth(Width);
  SetWindowHeight(Height);
  
  Task5(Width, Height);
end.