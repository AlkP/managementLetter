class Letter < ActiveRecord::Base
  # has_many :letter, dependent: :restrict_with_exception

  belongs_to :type_letter
  belongs_to :cb_mail

  has_many :attached

  # belongs_to :letter
  # has_many :letter
  belongs_to :letter
  has_many :letters, :foreign_key => "letter_id"

  #scope :all(option=nil), -> { options ? where(type_letters: ) }

  # def self.all(option=nil)
  #   if (option.nil?)
  #     where(:type_letter_id => ['select id: from type_letter where direction==1'])
  #   else
  #   end
  # end

end
