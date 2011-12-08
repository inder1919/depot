class Product < ActiveRecord::Base
  default_scope :order => 'title'
  has_many :line_items
  has_many :orders, :through => :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  
private
# ensure that there are no line items referencing this product
def ensure_not_referenced_by_any_line_item
  if line_items.empty?
      return true
        else
           errors.add(:base, 'Line Items present')
      return false
  end
end
  
  ALLOWED_CATEGORY = ['Books', 'Movies', 'Music']
  
   
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true, :length => { :minimum => 10,
    :too_short => "%{count} characters is the minimum you can enter"  }
 
  
  validates :image_url, :format =>{
                                :with => %r{\.(gif|jpg|png)$}i,
                                :message => 'must be a URL for GIF, JPG or PNG image.'}
  validates_presence_of :category
  
 #validates_inclusion_of :category, :in => ALLOWED_CATEGORY
 
 def self.reversed_all
    order('created_at DESC').all
 end
 
 scope :books, where(:category => 'Books')
 scope :movies, where(:category => 'Movies')
 scope :music, where(:category => 'Music')
 
end
