class TypeLettersController < ApplicationController
  def index
    @typeLetters = TypeLetter.all.order('service_number ASC')
  end
  def new
    @typeLetter = TypeLetter.new
  end
  def edit
    @typeLetter = TypeLetter.find(params[:id])
  end
  def update
    @typeLetter = TypeLetter.find(params[:id])
    if @typeLetter.update(type_letter_params)
      flash[:success] = 'Тип письма успешно отредактирован.'
      redirect_to type_letters_path
    else
      flash[:error] = check_basis(@typeLetter.id) ? 'Данный тип является "Базовым": Редактирование невозможно' : 'Ошибка при сохранении'
      # @typeLetter = TypeLetter.find(params[:id])
      @typeLetter.errors.full_messages
      render "edit"
    end
  end
  def create
    @typeLetter = TypeLetter.new(type_letter_params)
    if @typeLetter.save
      flash[:error] = 'Тип письма успешно создан.'
      redirect_to type_letters_path
    else
      flash[:error] = 'Тип письма не удалось создать.'
      @typeLetter.errors.full_messages
      render "new"
    end
  end
  def destroy
    typeLetter = TypeLetter.find(params[:id])
    begin
      typeLetter.destroy!
    rescue
      flash[:error] = check_basis(typeLetter.id) ? 'Данный тип письма "Базовый", удаление невозможно' : 'Данный тип письма удалить невозможно'
    else
      flash[:success] = 'Тип письма успешно удален.'
    end
    redirect_to type_letters_path
  end
  private
  def check_basis(id)
    arr = TypeLetter.where('basis = ?', true).map(&:id)
    arr.include?(id) ? (return true) : (return false)
  end
  def type_letter_params
    params.require(:type_letter).permit( :direction, :name, :service_number, :basis )
  end
end
