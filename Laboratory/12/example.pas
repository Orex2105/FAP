type
FileManager<T> = class
  private
    RootDir: string;
    FileName: string;
    FileType: (TextFile, BinaryFile);
    f_text: Text;
    f_file: file;
    
  public
    constructor Create(name: string := 'f'; fileType: string := 'text');
    begin
      self.RootDir := System.Environment.CurrentDirectory();
      self.FileName := name;
      case fileType.ToLower of
        'text':
          begin
            self.FileType := TextFile;
            Assign(f_text, $'{self.RootDir}/{FileName}';
          end;
        'binary':
          begin
            self.FileType := BinaryFile;
            Assign(f_file, $'{self.RootDir}/{FileName}';
          end;
      end;
    end;
  
  property Dir: string read RootDir;
  property FileName: string read FileName;
  property FileType:string read GetFileType();
  
  function GetFileType(): string;
  begin
    case fFileType of
      TextFile: Result := 'TextFile';
      BinaryFile: Result := 'BinaryFile';
    end;
  end;
end;