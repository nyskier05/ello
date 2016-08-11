class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  	:recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "250x250>", thumb: "100x100>", small: "50x50>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :first_name, :last_name, :date_of_birth, :height, :church, :church_status, :interests, :non_negotiables, :cellphone, :avatar, :presence => true
	validates :cellphone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format, must be in ###-####-### format" }, :uniqueness => true
	validates :is_female, inclusion: { in: [ true, false ] }
	#validates_inclusion_of :is_female, in: [true, false]

  has_many :conversations, :foreign_key => :sender_id
end
