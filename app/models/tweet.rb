class Tweet < ApplicationRecord
    is_impressionable
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    validates :deletekey, length: { is: 4}, presence: true
    validates :content, presence: true
end
