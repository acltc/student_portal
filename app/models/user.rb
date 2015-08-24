class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :submissions
  has_many :assignments, through: :submissions
  belongs_to :role
  belongs_to :cohort
  has_many :comments


  def instructor
    true if role.category == "instructor"
  end

  def administrator
    true if role.category == "administrator"
  end

  def instructor_or_administrator
    true if role.category == "instructor" || role.category == "administrator"
  end

  def student
    true if role.category == "student"
  end




end
