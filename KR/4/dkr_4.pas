uses GraphPlotter, GraphApp;

begin
  var f: real -> real := x -> Max(2*Power(x, 3) - Sqr(x) + x + 2, 0);
  var App := new App(800, 600, 'График функции');
  
  Print('Введите a:');
  var a := ReadInteger();
  Println('Введите b:');
  var b := ReadInteger();
  
  App.Clear();
  App.BuildApp();
  
  var Graph := new CartesianSystem(40, 1, 200 , 500);
  Graph.Render();
  
  App.FontSize := 10;
  App.FontColor := RGBConvert(255, 0, 0);
  
  Graph.RenderFunctionSimpson(f, a, b, '2*x^3 - x^2 + x + 2');
end.