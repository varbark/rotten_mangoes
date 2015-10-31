# require 'carrierwave/orm/activerecord'

class Movie < ActiveRecord::Base
  has_many :reviews, dependet: :destroy
  validates :title, 
    presence: true
  validates :director, 
    presence: true
  validates :runtime_in_minutes , 
    numericality: {only_integer: true}
  validates :description,
    presence: true
  # validates :image,
  #   presence: true  

  # validates :poster_image_url,
  #   presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  mount_uploader :image, MovieCoverUploader

  
  def review_average
    reviews.sum(:rating_out_of_ten) / reviews.size if reviews.size > 0
  end

  class << self
    def search(search)
      title = search[:title]
      director = search[:director]
      runtime = search[:runtime]
      return search_title(title).search_director(director).search_runtime_range(runtime)
    end

    def search_title(title)
      if title.present?
        where('title like ?', "%#{title}%")
    else
        where('')
      end
    end

    def search_director(director)
      if director.present?
        where("director like ?", "%#{director}%")
      else
        where('')
      end
    end

    def search_runtime_range(options)
      case options
      when nil
        where('')
      when "between90_120"
        then search_runtime_under(120).search_runtime_over(90)
      when "over120"
        then search_runtime_over(120)
      when "under90"
        then search_runtime_under(90)
      else
        where('')
      end    
    end
    
    def search_runtime_under(mins)
      where('runtime_in_minutes <= ?', mins)
    end

    def search_runtime_over(mins)
      where('runtime_in_minutes >= ?', mins)
    end
    
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end
