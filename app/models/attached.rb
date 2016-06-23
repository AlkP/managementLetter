class Attached < ActiveRecord::Base
  belongs_to :letter
  has_attached_file :attached
  do_not_validate_attachment_file_type  :attached
end
