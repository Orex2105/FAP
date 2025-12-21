unit Sorting;

interface
uses System.Diagnostics;

/// Сортировка методом выбора
function SelectionSort<T>(arr: array of T; comparator: (T,T) -> boolean): array of T;
/// Сортировка методом слияния
function MergeSort<T>(a: array of T; comparator: (T, T) -> boolean): array of T;
/// Замеряет время выполнения кода
procedure MeasureExecutionTime(action: () -> (); caption: string := 'Время выполнения');

implementation

function SelectionSort<T>(arr: array of T; comparator: (T,T) -> boolean): array of T;
begin
  Result := arr;
  for var i := 0 to Result.High - 1 do
  begin
    var idx := i;
    for var j := i + 1 to Result.High do
      if comparator(Result[j], Result[idx]) then
        idx := j;
    
    if idx <> i then
      Swap(Result[i], Result[idx]);
  end;
end;


function Merge<T>(left, right: array of T; comparator: (T, T) -> boolean): array of T;
begin
  var ResultList := new List<T>;
  var i := 0;
  var j := 0;
  
  // Сравниваем и добавляем элементы
  while (i < left.Length) and (j < right.Length) do
  begin
    if comparator(left[i], right[j]) then
    begin
      ResultList.Add(left[i]);
      Inc(i);
    end
    else
    begin
      ResultList.Add(right[j]);
      Inc(j);
    end;
  end;
  
  while i < left.Length do
  begin
    ResultList.Add(left[i]);
    Inc(i);
  end;

  while j < right.Length do
  begin
    ResultList.Add(right[j]);
    Inc(j);
  end;
  
  Result := ResultList.ToArray();
end;


function MergeSort<T>(a: array of T; comparator: (T, T) -> boolean): array of T;
begin
  if a.Length <= 1 then
    exit(a);
  
  Result := a;
  
  var mid := a.Length div 2;
  
  var left := new T[mid];
  for var i := 0 to mid - 1 do
    left[i] := a[i];
  
  var right := new T[a.Length - mid];
  for var i := 0 to right.Length - 1 do
    right[i] := a[mid + i];
  
  left := MergeSort(left, comparator);
  right := MergeSort(right, comparator);
  
  Result := Merge(left, right, comparator);
end;

procedure MeasureExecutionTime(action: () -> (); caption: string);
begin
  var start := MillisecondsDelta;
  
  try
    action();
  finally
    Print('');
  end;
  
  var elapsed := MillisecondsDelta;
  Println();
  Println();
  Println($'{caption} {elapsed} мс');
end;

end.