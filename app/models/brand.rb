class Brand < ActiveRecord::Base
  has_many :perfumes, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
