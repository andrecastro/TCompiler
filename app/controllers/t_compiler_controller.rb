class TCompilerController < ApplicationController
  
  def index
    
  end
  
  def compile
    file = params[:file]
    FileManipulation.save file
    tlex = TLex.new file.original_filename
    
    grammar = DefinedGrammar.get
    sintatic_table = SintacticTable.new(grammar)
    trec = TRecog.new(sintatic_table,tlex)
    
    response = trec.recognize
    
    flash[:compiled] = response[:status] && trec.semantic_errors.empty?
    flash[:line] = response[:line] if response[:status] == false
    flash[:semantic_errors] = trec.semantic_errors if !trec.semantic_errors.empty?
   
    redirect_to t_compiler_url
  end

end
