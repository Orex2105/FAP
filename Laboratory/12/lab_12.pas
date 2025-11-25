function IsPrime(x: integer): boolean;
var i: integer;
begin
  if x < 2 then
    IsPrime := false
  else if x = 2 then
    IsPrime := true
  else if x mod 2 = 0 then
    IsPrime := false
  else
  begin
    IsPrime := true;
    i := 3;
    while i * i <= x do
    begin
      if x mod i = 0 then
      begin
        IsPrime := false;
        exit;
      end;
      i := i + 2;
    end;
  end;
end;


procedure TaskOne();
begin
  var filetext: text;
  var a: string;
  assign(filetext,'C:\Users\pokom\OneDrive\Practice\FAP\Laboratory\12\one.txt');
  
  rewrite(filetext);
  for var i:=1 to 10 do
    writeln(filetext, i);
  close(filetext);
  
  reset(filetext);
  while not Eof(filetext) do
  begin
    Readln(filetext, a);
    Writeln(a);
  end;

  close(filetext);
end;


procedure TaskTwo();
begin
  var (n, k) := (ReadInteger, ReadInteger);
  var filetext: text;
  assign(filetext,'C:\Users\pokom\OneDrive\Practice\FAP\Laboratory\12\two.txt');
  
  rewrite(filetext);
  for var i := 1 to n do
    writeln(filetext, '*'*k);
  close(filetext);
end;


procedure TaskThree();
begin
  var filetext: text;
  var s := ReadString;
  assign(filetext,'C:\Users\pokom\OneDrive\Practice\FAP\Laboratory\12\three.txt');
  
  filetext.Append();
  Write(filetext, s);
  close(filetext);
end;


procedure TaskFour();
begin
  var k := ReadInteger();
  var lines := ReadAllLines('C:\Users\pokom\OneDrive\Practice\FAP\Laboratory\12\four.txt');
  lines := lines[:k-1] + [''] + lines[k-1:];
  WriteAllLines('C:\Users\pokom\OneDrive\Practice\FAP\Laboratory\12\four.txt', lines);
end;


procedure TaskFive();
begin
  var lines := ReadAllLines('C:\Users\pokom\OneDrive\Practice\FAP\Laboratory\12\input.txt');
  var int_lines := lines.ConvertAll(a -> a.ToInteger);  
  var mn_arr := | int_lines.Max(), int_lines.Min() |;
  
  WriteAllLines('C:\Users\pokom\OneDrive\Practice\FAP\Laboratory\12\output.txt', mn_arr.ConvertAll(a -> a.ToString));
end;


procedure TaskSix();
begin
  var lines := ReadAllLines('C:\Users\pokom\OneDrive\Practice\FAP\Laboratory\12\six.txt');
  lines := lines.Where(t -> not string.IsNullOrWhiteSpace(t)).ToArray;
  WriteAllLines('C:\Users\pokom\OneDrive\Practice\FAP\Laboratory\12\six.txt', lines);
end;


procedure TaskSeven();
begin
  var n, p, sum: integer;
  var inputFile, outputFile: text;
  var filePath: string;
  
  filePath := 'C:\Users\pokom\OneDrive\Practice\FAP\Laboratory\12\z3.in';
  Assign(inputFile, filePath);
  Reset(inputFile);
  Read(inputFile, n);
  Close(inputFile);
  
  sum := 0;
  p := 2;
  
  while p * p * p * p <= n do
  begin
    if IsPrime(p) then
    begin
      sum := sum + p * p * p * p;
    end;
    
    if p = 2 then
      p := 3
    else
      p := p + 2;
  end;
  
  filePath := 'C:\Users\pokom\OneDrive\Practice\FAP\Laboratory\12\z3.out';
  Assign(outputFile, filePath);
  Rewrite(outputFile);
  Write(outputFile, sum);
  Close(outputFile);
end;


begin
  TaskSeven();
end.