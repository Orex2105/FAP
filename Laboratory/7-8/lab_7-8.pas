procedure one();
begin
  var str := readstring();
  println($'Первый символ: {str[1]}');
  println($'Последний символ: {str[length(str)]}');
  if (length(str) >= 3) and (length(str) mod 2 <> 0) then
    println($'Средний символ: {str[(length(str) div 2) + 1]}');
end;


procedure two();
begin
  var str := readstring();
  var pm_counter: integer := 0;
  var zero_after_pm := 0;
  
  for var i := 1 to length(str) do
  begin
    if (str[i] = '+') or (str[i] = '-') then
    begin
      inc(pm_counter);
      if i < length(str) then
        if str[i+1] = '0' then inc(zero_after_pm);
    end;
  end;
  
  println($'Плюсов и минусов: {pm_counter}');
  println($'Ноль после + или - встретился {zero_after_pm} раз(а)');
end;


procedure three();
begin
  var str := readstring();
  var counter := 0;
  
  for var i := length(str)-2 downto 1 do
    if (str[i]+str[i+1]+str[i+2]) = 'aba' then
      inc(counter);
  println($'aba встретилось {counter} раз(а)')
end;


begin
end.