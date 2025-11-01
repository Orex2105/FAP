function IsMonotone(Arr: array of integer): boolean;
begin
  var pairs := Arr.Pairwise();
  var decreasing := pairs.All(p -> p[0] >= p[1]);
  var increasing := pairs.All(p -> p[0] <= p[1]);
  
  Result := decreasing or increasing
end;


procedure TaskOne;
begin
  var n := ReadInteger('Размер массива: ');
  Print('Элементы массива: ');
  var Arr := ReadArrInteger(n);
  
  Println(IsMonotone(Arr[::2]));
end;


procedure TaskTwo;
begin
  var Str := ReadString('Введите строку');
  var StrSet: set of string := [];
  var counter := 0;
  
  for var i := 1 to Str.Length do
  begin
    if i mod 3 <> 0 then continue;
    if Str[i-2:i+1] in StrSet then
      continue
    else
    begin
      StrSet.Add(Str[i-2:i+1]);
      Inc(counter);
    end
  end;
  Println(counter);
end;