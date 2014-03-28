class Shop < ActiveRecord::Base
	attr_accessor :number, :street, :city, :state, :zip, :cntry

  belongs_to :user

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :comments, dependent: :destroy
  has_many :favorites
  # has_many :images, dependent: :destroy
  # accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['image'].nil? }
  has_and_belongs_to_many :categories

  has_many :activities


  validates :name, presence: true
  validates :address, presence: true


  ### File Uploads
    has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
