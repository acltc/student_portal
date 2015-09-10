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

  validates :first_name, presence: true
  validates :last_name, presence: true


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

  def full_name
    "#{first_name} #{last_name}"
  end




end
