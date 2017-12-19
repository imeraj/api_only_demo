class Order < ApplicationRecord
  before_validation :set_total

  belongs_to :user
  has_many :placements
  has_many :products, through: :placements

  validates :total, numericality: { greater_than: 0 }

  private
  def set_total
    self.total = products.map(&:price).sum
  end

end
