class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy
  
  validates :name, uniqueness: true, presence: true
end