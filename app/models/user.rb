class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  	:recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :avatar, styles: { medium: "250x250>", thumb: "100x100>", small: "50x50>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :first_name, :last_name, :date_of_birth, :height, :church, :church_status, :neighborhood, :interests, :cellphone, :avatar, :status, :presence => true
	validates :cellphone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format, must be in ###-####-### format" }, :uniqueness => true
	validates :is_female, inclusion: { in: [ true, false ] }
	#validates_inclusion_of :is_female, in: [true, false]

  has_many :conversations, :foreign_key => :sender_id

  def active_for_authentication? 
    super && approved? 
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end
  
  after_create :send_admin_mail
  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(self).deliver
  end

  CHURCHES = ['(Currently looking for a church)', '(Visiting churches still deciding)', 'All Angels Church', 
    'Apostles Brooklyn', 'Apostles Union Square', 'Apostles Upper East Side', 'Brooklyn Tabernacle', 
    'C3 Brooklyn', 'Calvary Baptist', 'Central Presbyterian ', 'Chinese Evangel Mission', 'Christ Church', 
    'Church of Transfiguration', 'CityLight Brooklyn', 'CityLight East Village', 'CityLight Queens', 
    'Community of Grace', 'Covenant Fellowship Church', 'Dwell Church', 'Episcopal Diocese of New York', 
    'Every Nation NYC', 'Exilic Presbyterian', 'Forefront Brooklyn', 'Forefront Manhattan', 'Gallery Church', 
    'Grace Community Chapel ', 'Graceway Presbyterian Church', 'Hillsong Astoria', 'Hillsong CT', 
    'Hillsong NJ', 'Hillsong NYC', 'Hillsong Time Square', 'Hillsong Union Square', 'Hope Church Astoria', 
    'Hope Church NYC', 'Iglesia Metropolitana de Hermosillo', 'JHOP NYC', 'Joy Christian Fellowship NJ', 
    'Joy Christian Fellowship NYC', 'Liberty Church Brooklyn', 'Liberty Church NYC', 
    'Manhattan Church of Christ', 'New Life Fellowship', 'New York Chinese Baptist Church', 
    'Redeemer Downtown', 'Redeemer Upper East Side', 'Redeemer Upper West Side', 
    'Resurrection Presbyterian Church', 'Seek Church', 'Sojourner Presbyterian Church', 
    'St. James Episcopal', 'St. Peters Catholic Church', 'Times Square Church', 'Trinity Baptist Church', 
    'Trinity Church Harlem', 'Trinity Grace Church Chelsea', 'Trinity Grace Church Crown Heights', 
    'Trinity Grace Church Midtown', 'Trinity Grace Church Midtown', 'Trinity Grace Church Park Slope', 
    'Trinity Grace Church Park Slope', 'Trinity Grace Church Queens', 'Trinity Grace Church Tribeca', 
    'Trinity Grace Church Upper East Side', 'Trinity Grace Church Upper West Side', 
    'Trinity Grace Church Washington Heights', 'Trinity Grace Church Williamsburg', 
    'Torcc Church', 'Other Not Listed']

  NEIGHBORHOODS = ['Manhattan - Alphabet City', 'Manhattan - Battery Park City', 'Manhattan - Chelsea', 
    'Manhattan - Chinatown', 'Manhattan - Clinton', 'Manhattan - East Harlem', 'Manhattan - East Village', 
    'Manhattan - Financial District', 'Manhattan - Gramercy Park', 'Manhattan - Greenwich Village', 
    'Manhattan - Hamilton Heights', 'Manhattan - Harlem', 'Manhattan - Inwood', 'Manhattan - Kips Bay', 
    'Manhattan - Lenox Hill', 'Manhattan - Lincoln Square', 'Manhattan - Little Italy', 
    'Manhattan - Lower East Side', 'Manhattan - Midtown', 'Manhattan - Morningside Heights', 
    'Manhattan - Murray Hill', 'Manhattan - NoHo', 'Manhattan - Peter Cooper Village', 'Manhattan - Roosevelt Island', 
    'Manhattan - SoHo', 'Manhattan - Spanish Harlem', 'Manhattan - Stuyvesant Town', 'Manhattan - Sutton Place', 
    'Manhattan - TriBeCa', 'Manhattan - Tudor City', 'Manhattan - Turtle Bay', 'Manhattan - Upper East Side', 
    'Manhattan - Upper West Side', 'Manhattan - Wards Island', 'Manhattan - Washington Heights', 
    'Manhattan - Waterside Plaza', 'Manhattan - West Village', 'Manhattan - Yorkville', 'Manhattan - Other', 
    'Brooklyn - Bedford-Stuyvesant', 'Brooklyn - Boerum Hill', 'Brooklyn - Brooklyn Heights', 
    'Brooklyn - Brooklyn Navy Yard', 'Brooklyn - Bushwick', 'Brooklyn - Carroll Gardens', 'Brooklyn - Clinton Hill', 
    'Brooklyn - Cobble Hill', 'Brooklyn - Crown Heights', 'Brooklyn - DUMBO', 'Brooklyn - Flatbush', 
    'Brooklyn - Fort Greene', 'Brooklyn - Gowanus', 'Brooklyn - Greenpoint', 'Brooklyn - Park Slope', 
    'Brooklyn - Prospect Heights', 'Brooklyn - Red Hook', 'Brooklyn - Vinegar Hill', 'Brooklyn - Williamsburg', 
    'Brooklyn - Other', 'Bronx', 'Queens - Astoria', 'Queens - Elmhurst', 'Queens - Flushing', 'Queens - Hunters Point', 
    'Queens - Long Island City', 'Queens - Maspeth', 'Queens - Ridgewood', 'Queens - Steinway', 'Queens - Sunnyside', 
    'Queens - Woodside', 'Queens - Other', 'Staten Island', 'New Jersey', 'Connecticut', 'Other']
end
