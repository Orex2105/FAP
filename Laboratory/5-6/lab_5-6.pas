function removeat(var arr: array of integer; index: integer): array of integer;
begin
  var n := arr.high();
  for var i := index to n-1 do
    arr[i] := arr[i + 1];
  SetLength(arr, arr.High);
  result := arr;
end;


procedure one();
begin
  var A := arrrandom(n := 30, a := -99, b := 67);
  var B := A.where(x -> x mod 2 = 0);
  writeln('Массив A: ', A);
  writeln('Массив B: ', B);
end;


procedure two();
begin
  writeln('Размер массива: ');
  var n := readinteger();
  writeln('Элементы массива: ');
  var arr := readarrinteger(n);
  println(arr.SequenceEqual(arr.sorted()));
end;


procedure three();
begin
  var arr := arrrandom(n := 20, a := -50, b := 100);
  println('Массив: ', arr);
  
  var index := -1;
  for var i := arr.High downto 0 do
  begin
    if arr[i] > 0 then
    begin
      index := i;
      arr := removeat(arr, index);
      break;
    end;
end;
  println('Без последнего положительного элемента', arr);
  arr := removeat(arr, arr.IndexMax());
  print('Без наибольшего элемента', arr);
end;


begin
  one();
  two();
  three();
end.