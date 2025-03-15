class Place < ApplicationRecord
  belongs_to :user
  has_many :entries
  has_one_attached :image  # Enables image attachment
end