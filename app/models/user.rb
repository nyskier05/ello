class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  	:recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :date_of_birth, :height, :church, :church_status, :interests, :non_negotiables, :cellphone, :presence => true
	validates :cellphone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" }, :uniqueness => true
	validates :is_female, inclusion: { in: [ true, false ] }
	#validates_inclusion_of :is_female, in: [true, false]
end
