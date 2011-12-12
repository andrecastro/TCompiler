class FileManipulation
  
  def self.save(file)
    path = File.join(Rails.root,"public/files",file.original_filename)
    File.open(path, "wb") do |f|
      f.write(file.read)
    end
  end
  
end


