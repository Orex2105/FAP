uses Sorting, FileManagerUtility;

procedure SelectionSortMethod();
begin
  var comparator: (integer, integer) -> boolean := (x, y) -> x <= y;
  var InputFile := new FileManager<integer>('SelectionSort.dat');
  InputFile.RandomFill(10000);
  var arr := InputFile.ReadAll();
  
  InputFile.PrintlnFile('Исходный массив:', 2);
  
  MeasureExecutionTime(() -> SelectionSort(arr, comparator), 'Сортировка методом выбора заняла:');
  
  InputFile.Overwrite(SelectionSort(arr, comparator));
  InputFile.PrintFile('Отсортированный массив:');
end;

procedure MergeSortMethod();
begin
  var comparator: (integer, integer) -> boolean := (x, y) -> x <= y;
  var InputFile := new FileManager<integer>('MergeSort.dat');
  InputFile.RandomFill(10000);
  var arr := InputFile.ReadAll();
  
  InputFile.PrintlnFile('Исходный массив:', 2);
  
  MeasureExecutionTime(() -> MergeSort(arr, comparator), 'Сортировка методом выбора заняла:');
  
  InputFile.Overwrite(MergeSort(arr, comparator));
  InputFile.PrintFile('Отсортированный массив:');
end;

begin
  SelectionSortMethod();
  MergeSortMethod();
end.