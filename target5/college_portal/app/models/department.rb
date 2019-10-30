class Department < ApplicationRecord
	has_many :sections, dependent: :destroy
	has_many :students, :through => :sections, dependent: :destroy
end
