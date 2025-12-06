uses FileManagerUtility;

procedure Task1();
begin
  var InputFile := new FileManager<char>('task_1.input');
  InputFile.RandomFill(100);
  
  var file_data := InputFile.ReadAll();
  var space_index: integer;
  
  foreach var (i, chr) in ReverseEnumerate(file_data) do
    if chr = ' ' then
    begin
      space_index := i;
      break;
    end;
  
  var OutputFile := new FileManager<char>('task_1.output');
  OutputFile.Overwrite(file_data[:space_index]);
end;

procedure Task2();
begin
  var InputFile := new FileManager<string>('task_2.input');
  InputFile.RandomFill(100);
  
  var OutputFile := new FileManager<string>('task_2.output');
  OutputFile.Overwrite(InputFile.LongestStrings().Reverse().ToArray());
end;

procedure Task3();
begin
  var InputFile := new FileManager<real>('task_3.input');
  InputFile.RandomFill(10);
  
  var OutputFile1 := new FileManager<real>('task_3_1.output');
  var OutputFile2 := new FileManager<real>('task_3_2.output');
  
  OutputFile1.Overwrite(InputFile.OddIndexItems());
  OutputFile2.Overwrite(InputFile.EvenIndexItems());
end;

procedure Task4();
begin
  var InputFile := new FileManager<real>('task_4.input');
  InputFile.RandomFill(100);
  
  Print(InputFile.EvenIndexItems().Sum());
end;

procedure Task5();
begin
  var InputFile := new FileManager<real>('task_5.dat');
  InputFile.RandomFill(10);
  Print(LastLocalMax(InputFile.ReadAll()));
  
  foreach var i in InputFile.Iterate() do
    Print(i);
end;

procedure Task6();
begin
  var InputFile := new FileManager<real>('task_6.input');
  InputFile.RandomFill(10);
  InputFile.SwapMinMaxElements();
end;

procedure Task7();
begin
  var InputFile := new FileManager<char>('task_7.input');
  InputFile.RandomFill(100);
  InputFile.ReplaceEvenIndex('!');
end;

begin
  Task5;
end.