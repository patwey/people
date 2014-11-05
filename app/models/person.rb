class Person < ActiveRecord::Base
  has_many :projects
  has_many :location_interests
  has_many :locations, :through => :location_interests
  belongs_to :cohort
  validates_uniqueness_of :slug
  mount_uploader :resume, ResumeUploader

  before_save :generate_slug

  def self.active
    where(:hidden => false)
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def generate_slug
    self.slug = full_name.downcase.gsub(" ", "_")
  end

  def to_param
    slug
  end

  def self.editable_attributes
    [:first_name,
     :last_name,
     :email_address,
     :github_url,
     :looking_for,
     :best_at,
     :cohort_id,
     :photo_slug,
     :hidden]
  end

  def image_url
    if photo_slug
      "students/#{photo_slug}"
    else
      "students/no_photo.jpg"
    end
  end

  # def location_names
  #   locations.order(:name).pluck(:name)
  # end
end
