class ClassCard  < ApplicationRecord
  belongs_to :user
  belongs_to :class_type
end
