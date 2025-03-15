class Entry < ApplicationRecord
  belongs_to :place
  has_one_attached :photo  # Enables photo attachment
end