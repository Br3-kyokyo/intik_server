# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :followees, class_name: 'User', through: :active_relationships, source: :followed
  has_many :followers, class_name: 'User', through: :negative_relationships, source: :follower

  has_many :active_relationships, class_name: 'Follow',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy

  has_many :negative_relationships, class_name: 'Follow',
                                    foreign_key: 'followed_id',
                                    dependent: :destroy

  has_secure_password
end
