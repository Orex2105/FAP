unit FileManagerUtility;

interface
uses System.IO;

type
  FileManager<T> = class
    private
      fRootDir: string;
      fFilePath: string;
    public
      /// Создает менеджер для работы с файлом заданного типа
      constructor Create(FileName: string);
      /// Полный путь к управляемому файлу
      property FilePath: string read fFilePath;
      /// Проверяет, работает ли менеджер со строковыми файлами (T = string)
      function IsFileOfString(): boolean;
      /// Читает все элементы файла и возвращает массив
      function ReadAll(): array of T;
      /// Читает диапазон элементов файла от индекса a до b
      function ReadInterval(a: integer := 0; b: integer := 1): array of T;
      /// Возвращает элемент файла по указанному индексу
      function Get(index: integer): T;
      /// Возвращает текущее количество элементов в файле
      function Size(): integer;
      /// Возвращает последовательность для прямого обхода элементов файла
      function Iterate(): sequence of T;
      /// Возвращает последовательность для обратного обхода элементов файла
      function ReverseIterate(): sequence of T;
      /// Для строковых файлов: возвращает длину самой длинной строки
      function MaxLength(): integer;
      /// Для строковых файлов: возвращает все строки максимальной длины
      function LongestStrings(): array of T;
      /// Возвращает элементы, расположенные в файле на четных позициях
      function EvenIndexItems(): array of T;
      /// Возвращает элементы, расположенные в файле на нечетных позициях
      function OddIndexItems(): array of T;
      /// Заменяет символы на четных позициях в файлах типа char или string
      procedure ReplaceEvenIndex(ch: char);
      /// Выводит все элементы файла в консоль
      procedure PrintFile();
      /// Выводит все элементы файла в консоль с предварительным заголовком
      procedure PrintFile(caption: string);
      /// Выводит элементы файла и добавляет указанное количество пустых строк
      procedure PrintlnFile(count: integer := 1);
      /// Выводит элементы файла с заголовком и добавляет пустые строки
      procedure PrintlnFile(caption: string; count: integer := 1);
      /// Меняет местами минимальный и максимальный элемент в файлах типа real
      procedure SwapMinMaxElements();
      /// Полностью перезаписывает файл содержимым переданного массива
      procedure Overwrite(data: array of T);
      /// Полностью перезаписывает файл одним переданным элементом
      procedure Overwrite(data: T);
      /// Очищает файл
      procedure Clear();
      /// Заполняет файл n случайными элементами соответствующего типа
      procedure RandomFill(n: integer);
      /// Добавляет один элемент в конец файла
      procedure Append(data: T);
      /// Добавляет все элементы массива в конец файла
      procedure Append(data: array of T);
      /// Связывает файловую переменную с физическим файлом на диске
      procedure AssignFile(f: file of T);
      /// Закрывает файловую переменную
      procedure CloseFile(f: file of T);
  end;

/// Возвращает последовательность пар (индекс, элемент) для массива
function Enumerate<T>(arr: array of T): sequence of (integer, T);
/// Возвращает последовательность пар (индекс, элемент) для массива в обратном порядке
function ReverseEnumerate<T>(arr: array of T): sequence of (integer, T);
/// Находит первый локальный максимум в массиве вещественных чисел
function FirstLocalMax(arr: array of real): real;
/// Находит последний локальный максимум в массиве вещественных чисел
function LastLocalMax(arr: array of real): real;

implementation

function FirstLocalMax(arr: array of real): real;
begin
  if arr.Length < 3 then
    raise new System.ArgumentException('Массив должен содержать минимум 3 элемента');
  
  for var i := 1 to arr.Length - 2 do
  begin
    if (arr[i] > arr[i-1]) and (arr[i] > arr[i+1]) then
    begin
      Result := arr[i];
      exit;
    end;
  end;
  
  raise new System.InvalidOperationException('Локальный максимум не найден');
end;

function LastLocalMax(arr: array of real): real;
begin
  if arr.Length < 3 then
    raise new System.ArgumentException('Массив должен содержать минимум 3 элемента');
  
  var lastFound: real;
  var found := false;
  
  for var i := 1 to arr.Length - 2 do
  begin
    if (arr[i] > arr[i-1]) and (arr[i] > arr[i+1]) then
    begin
      lastFound := arr[i];
      found := true;
    end;
  end;
  
  if not found then
    raise new System.InvalidOperationException('Локальный максимум не найден');
  
  Result := lastFound;
end;

constructor FileManager<T>.Create(FileName: string);
begin
  self.fRootDir := Directory.GetCurrentDirectory();
  self.fFilePath := Path.Combine(fRootDir, FileName);

  if not System.IO.File.Exists(self.fFilePath) then
  begin
    var f: file of T;
    Assign(f, self.fFilePath);
    Rewrite(f);
    Close(f);
  end;
end;

procedure FileManager<T>.SwapMinMaxElements();
begin
  if typeof(T) <> typeof(real) then
    raise new System.InvalidOperationException('Метод доступен только для файлов вещественных чисел');
  
  var f: file of T;
  AssignFile(f);
  try
    Reset(f);
    
    var minValue: real := real.MaxValue;
    var maxValue: real := -real.MaxValue;
    var minIndex: integer := -1;
    var maxIndex: integer := -1;
    var currentIndex: integer := 0;
    
    while not Eof(f) do
    begin
      var item: T;
      Read(f, item);
      var itemReal := real(object(item));
      
      if itemReal < minValue then
      begin
        minValue := itemReal;
        minIndex := currentIndex;
      end;
      
      if itemReal > maxValue then
      begin
        maxValue := itemReal;
        maxIndex := currentIndex;
      end;
      
      Inc(currentIndex);
    end;
    
    if (minIndex = -1) or (maxIndex = -1) or (minIndex = maxIndex) then
      exit;
    
    Reset(f);
    
    Seek(f, minIndex);
    Write(f, T(object(maxValue)));
    
    Seek(f, maxIndex);
    Write(f, T(object(minValue)));
    
  finally
    CloseFile(f);
  end;
end;

function FileManager<T>.IsFileOfString(): boolean;
begin
  Result := typeof(T) = typeof(string);
end;

function FileManager<T>.ReadAll(): array of T;
begin
  var f: file of T;
  try
    var Data := new List<T>;
    
    Assign(f, self.fFilePath);
    Reset(f);
    
    while not Eof(f) do
    begin
      var item: T;
      Read(f, item);
      Data.Add(item);
    end;
    
    Result := Data.ToArray;
  finally
    Close(f);
  end;
end;

function FileManager<T>.ReadInterval(a: integer; b: integer): array of T;
begin
  if (a < 0) or (b < a) then
    raise new System.ArgumentException('Неверные параметры');
  
  var f: file of T;
  
  Assign(f, self.fFilePath);
  Reset(f);

  try
    var Data := new List<T>;
    var CurrentPos := 0;
    var item: T;
    
    if self.IsFileOfString() then
    begin
    
      while (CurrentPos <= b) and (not Eof(f)) do
      begin
        Read(f, item);
        if CurrentPos >= a then Data.Add(item);
        Inc(CurrentPos);
      end;
    end
    
    else
    begin
      Seek(f, a);
      CurrentPos := a;
      
      while (CurrentPos <= b) and (not Eof(f)) do
      begin
        Read(f, item);
        Data.Add(item);
        Inc(CurrentPos);
      end;
    end;
    
    Result := Data.ToArray();
  finally
    Close(f);
  end;
end;

function FileManager<T>.Get(index: integer): T;
begin
  var f: file of T;
  
  Assign(f, self.fFilePath);
  Reset(f);
  
  try
    if not self.IsFileOfString() then
    begin
      Seek(f, index);
      Read(f, Result)
    end
    
    else
    begin
      var CurrentPos := 0;
      
      while CurrentPos <= index do
      begin
        Read(f, Result);
        Inc(CurrentPos);
      end;
    end;
  finally
      Close(f);
  end;
end;

function FileManager<T>.Size(): integer;
begin
  var f: file of T;
  try
    Assign(f, self.fFilePath);
    Reset(f);
    Result := FileSize(f);
  finally
    Close(f);
  end;
end;

function FileManager<T>.Iterate(): sequence of T;
begin
  var f: file of T;
  var item: T;
  
  Assign(f, self.fFilePath);
  Reset(f);
  
  while not Eof(f) do
  begin
    Read(f, item);
    yield item;
  end;
  
  Close(f);
end;

function FileManager<T>.LongestStrings(): array of T;
begin
  if typeof(T) <> typeof(string) then
    raise new System.InvalidOperationException('Метод доступен только для строковых файлов');
  
  var MaxLength := self.MaxLength();
  var StringsList := new List<T>;
  
  foreach var item in self.Iterate() do
  begin
    var str := string(object(item));
    if str.Length = MaxLength then 
      StringsList.Add(T(object(str)));
  end;
  
  Result := StringsList.ToArray();
end;

function FileManager<T>.ReverseIterate(): sequence of T;
begin
  var data := self.ReadAll();
  
  for var i := data.Length - 1 downto 0 do
    yield data[i];
end;

function FileManager<T>.MaxLength(): integer;
begin
  if typeof(T) <> typeof(string) then
    raise new System.InvalidOperationException('Метод доступен только для строковых файлов');
  
  Result := 0;
  
  foreach var str in self.Iterate() do
  begin
    if string(object(str)).Length > Result then
      Result := string(object(str)).Length;
  end;
end;

function RandomString(length: integer): string;
begin
  Result := '';
  for var i := 1 to length do
    Result += Chr(Random(26) + 97);
end;

function FileManager<T>.EvenIndexItems(): array of T;
begin
  var index := 0;
  var Items := new List<T>;
  
  foreach var item in self.Iterate() do
  begin
    if index mod 2 = 0 then
      Items.Add(item);
    Inc(index);
  end;
  
  Result := Items.ToArray();
end;

function FileManager<T>.OddIndexItems(): array of T;
begin
  var index := 0;
  var Items := new List<T>;
  
  foreach var item in self.Iterate() do
  begin
    if index mod 2 = 1 then
      Items.Add(item);
    Inc(index);
  end;
  
  Result := Items.ToArray();
end;

procedure FileManager<T>.Clear();
begin
  var f: file of T;
  Assign(f, self.fFilePath);
  Rewrite(f);
  Close(f);
end;

procedure FileManager<T>.Overwrite(data: T);
begin
  var f: file of T;
  try
    Assign(f, self.fFilePath);
    Rewrite(f);
    Write(f, data);
  finally
    Close(f);
  end;
end;

procedure FileManager<T>.PrintFile();
begin
  foreach var item in self.Iterate() do
    Print(item);
end;

procedure FileManager<T>.PrintFile(caption: string);
begin
  Println(caption);
  foreach var item in self.Iterate() do
    Print(item);
end;

procedure FileManager<T>.PrintlnFile(count: integer);
begin
  foreach var item in self.Iterate() do
    Print(item);
  for var i := 1 to count do
    Println();
end;

procedure FileManager<T>.PrintlnFile(caption: string; count: integer);
begin
  Println(caption);
  foreach var item in self.Iterate() do
    Print(item);
  for var i := 1 to count do
    Println();
end;

procedure FileManager<T>.Overwrite(data: array of T);
begin
  var f: file of T;
  try
    Assign(f, self.fFilePath);
    Rewrite(f);
    
    foreach var item in data do
      Write(f, item);
  finally
    Close(f);
  end;
end;

procedure FileManager<T>.ReplaceEvenIndex(ch: char);
begin
  if (typeof(T) <> typeof(char)) and (typeof(T) <> typeof(string)) then
    raise new System.InvalidOperationException('Метод доступен только для текстовых файлов');
  
  var FileSize := self.Size();
  var f: file of T;
  Assign(f, self.fFilePath);
  
  try
    Reset(f);
    
    for var i := 0 to FileSize - 1 do
    begin
      if i mod 2 = 0 then
      begin
        Seek(f, i);
        
        if typeof(T) = typeof(char) then
          Write(f, T(object(ch)))
        else
          Write(f, T(object(ch)));
      end;
    end;
    
  finally
    Close(f);
  end;
end;

procedure FileManager<T>.RandomFill(n: integer);
begin
  var f: file of T;
  Assign(f, self.fFilePath);
  Rewrite(f);
  
  try
    if typeof(T) = typeof(char) then
    begin
      for var i := 0 to n-1 do
      begin
        var item: char;
        if Random(10) = 0 then 
          item := ' '
        else
          item := Chr(Random(26) + 65);
        
        Write(f, T(object(item)));
      end;
    end
    
    else if typeof(T) = typeof(string) then
    begin
      for var i := 0 to n-1 do
      begin
        var str := RandomString(Random(6) + 2);
        Write(f, T(object(str)));
      end;
    end
    
    else if typeof(T) = typeof(integer) then
    begin
      for var i := 0 to n-1 do
      begin
        var item: T := T(object(Random(101)));
        Write(f, item);
      end;
    end
    
    else if typeof(T) = typeof(real) then
    begin
      for var i := 0 to n-1 do
      begin
        var item: real := Random * 100;
        Write(f, T(object(item)));
      end;
    end;
  finally
    Close(f);
  end;
end;

procedure FileManager<T>.Append(data: T);
begin
  var f: file of T;
  try
    var ExistingData := self.ReadAll();
    var NewData := ExistingData + data;
    
    Assign(f, self.fFilePath);
    Rewrite(f);
    
    foreach var item in NewData do
      Write(f, item);
  finally
    Close(f);
  end;
end;

procedure FileManager<T>.Append(data: array of T);
begin
  var f: file of T;
  try
    var ExistingData := self.ReadAll();
    var NewData := ExistingData + data;
    
    Assign(f, self.fFilePath);
    Rewrite(f);
    
    foreach var item in NewData do
      Write(f, item);
  finally
    Close(f);
  end;
end;

procedure FileManager<T>.AssignFile(f: file of T);
begin
  Assign(f, self.fFilePath);
end;

procedure FileManager<T>.CloseFile(f: file of T);
begin
  Close(f);
end;


function Enumerate<T>(arr: array of T): sequence of (integer, T);
begin
  for var i := 0 to arr.Length - 1 do
    yield (i, arr[i]);
end;

function ReverseEnumerate<T>(arr: array of T): sequence of (integer, T);
begin
  for var i := arr.Length - 1 downto 0 do
    yield (i, arr[i]);
end;

end.