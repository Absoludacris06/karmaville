class User < ActiveRecord::Base
  has_many :karma_points

  attr_accessible :first_name, :last_name, :email, :username, :total_karma, :full_name

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
            :presence => true,
            :length => {:minimum => 2, :maximum => 32},
            :format => {:with => /^\w+$/},
            :uniqueness => {:case_sensitive => false}

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false}


  def self.by_karma
    order('total_karma DESC')
  end

  def update_total_karma
    puts "you're here"
    puts self
    self.update_attribute(:total_karma, self.karma_points.sum(:value))
    puts self.id
  end

  def create_full_name
    self.update_attribute(:full_name, "#{self.first_name} #{self.last_name}")
    puts self.id
  end
end
