class TypeLetter < ActiveRecord::Base
  has_many :letter
  validates :service_number, :name, presence: true, uniqueness: true

  before_save     :check_basis, :check_basis_false
  before_update   :check_basis, :check_basis_false
  before_destroy  :check_basis

  protected
  def check_basis
    arr = TypeLetter.where('basis = ?', true).map(&:id)
    !arr.include?(self.id)
  end
  def check_basis_false
    if self.id.nil?
      self.basis = nil
    else
      typeLetter = TypeLetter.find_by_id(self.id)
      if !typeLetter.basis
        self.basis = nil
      end
    end
  end
end
