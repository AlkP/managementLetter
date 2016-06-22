class TypeLettersController < ApplicationController
  def index
    @typeLetters = TypeLetter.all
  end
  def new
    @typeLetter = TypeLetter.new
  end
  def edit
    @typeLetter = TypeLetter.find(params[:id])
  end
  def update
    typeLetter = TypeLetter.find(params[:id])
    if typeLetter.update(type_letter_params)
      redirect_to type_letters_path
    else
      @typeLetter = TypeLetter.find(params[:id])
      render "edit"
    end
  end
  def create
    typeLetter = TypeLetter.new(type_letter_params)
    if typeLetter.save
      redirect_to type_letters_path
    else
      @typeLetter = TypeLetter.find(params[:id])
      render "new"
    end
  end
  private
  def type_letter_params
    params.require(:type_letter).permit( :direction, :name, :service_number )
  end
end
