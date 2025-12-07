uses GraphPlotter, GraphApp;

begin
  var f: real -> real := x -> Max(2*Power(x, 3) - Sqr(x) + x + 2, 0);
  var App := new App(800, 600, 'График функции');
  App.BuildApp();
  
  var Graph := new CartesianSystem(20, 1);
  Graph.Render();
  
  App.FontSize := 10;
  App.FontColor := RGBConvert(255, 0, 0);
  
  Graph.RenderFunction(f, -10, 10, '2*x^3 - x^2 + x + 2');
end.