class TLexController < ApplicationController
  def new

  end

  def create
    FileManipulation.save params[:file]
    @tlex = TLex.new params[:file].original_filename

    render :new
  end

end
