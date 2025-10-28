function MultipleOfFive(Arr: array of integer): integer;
begin
  for var i := 0 to Arr.Length - 1 do
    if Arr[i] mod 5 = 0 then
    begin
      Result := i;
      exit
    end;
  raise new Exception('В массиве ' + Arr.ToString + ' нет числа, кратного 5');
end;


procedure ReplaceMaxWithZero(var Arr: array of integer);
begin
  Arr[Arr.IndexMax] := 0;
end;


procedure DoubleElements(var Arr: array of integer);
begin
  var IMin := Arr.IndexMin;
  Arr := Arr[:IMin+1] + Arr.Skip(IMin+1).Select(x -> x*2).ToArray;
end;


procedure RowFill(var mat: array[,] of integer; rowIndex: integer; val: integer);
begin
  for var j := 0 to mat.GetLength(1) - 1 do
    mat[rowIndex, j] := val;
end;


procedure task_one();
begin
  var (n, a, b) := readinteger3('Введите размер массивов и диапазон заполнения (от a до b): ');
  var ArrOne := ArrRandomInteger(n, a, b);
  var ArrTwo := ArrRandomInteger(n, a, b);
  
  Println('Массив A: ', ArrOne);
  Println('Массив B: ', ArrTwo);
  
  if MultipleOfFive(ArrOne) < MultipleOfFive(ArrTwo) then
  begin
    ReplaceMaxWithZero(ArrOne);
    DoubleElements(ArrTwo);
  end
  else if MultipleOfFive(ArrOne) > MultipleOfFive(ArrTwo) then
  begin
    ReplaceMaxWithZero(ArrTwo);
    DoubleElements(ArrOne);
  end
  else
    raise new Exception('Индексы первых числел, кратных 5, совпали у обоих массивов');

  Println('Массив A после изменений: ', ArrOne);
  Println('Массив B после изменений: ', ArrTwo);
end;


procedure task_two();
begin
  var (a, b) := ReadInteger2('Введите диапазон заполнения (от a до b)');
  var matrix := new integer[8,8];
  var MaxValue: integer;
  var row: array of integer;
  
  matrix.FillRandom(a, b);
  Println('Исходная матрица:', matrix);
  for var i := 0 to matrix.GetLength(0) - 1 do
  begin
    row := matrix.Row(i);
    MaxValue := row.Max;
    if row.Count(x -> x = MaxValue) = 1 then
      RowFill(matrix, i, 1)
    else
      RowFill(matrix, i, -1);
  end;
  Println('Конечная матрица', matrix);
end;