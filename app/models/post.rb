class Post < ActiveRecord::Base
  belongs_to :user
  has_one :category
end
