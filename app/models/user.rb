class User < ActiveRecord::Base
  attr_accessor   :tos_confirmation

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :phone_number, :email,
                  :password, :password_confirmation, :country, :tos_confirmation,
                  :email, :password, :password_confirmation, :remember_me

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :country, :presence => true
  validates :first_name, :last_name, :length => { :maximum => 30 }

  validates :tos_confirmation, :acceptance => true, :if => :new_record?
  validates :country, :inclusion => { :in => Carmen::country_names }

  has_many :acumen_tests
  has_many :accounts
  has_many :transactions
  has_many :budgets
  has_many :answers, :through => :acumen_tests
  has_many :goals

  def transactions_sum_by_category(category)
    arr = []
    self.transactions.each do |transaction|
      arr << transaction if transaction.category == category
    end
    arr.map{|tr| tr.amount}.sum
  end

  def transactions_categories
    self.transactions.map{ |transaction| transaction.category }.uniq!
  end

  def spending_amount
    transactions.spending_transactions.map(&:amount).sum
  end

  def most_purchased
    most_category = ''
    elems = 0
    transactions_categories.each do |category|
      if transactions.by_category(category).count > elems
        most_category = category
        elems = transactions.by_category(category).count
      end
    end
    return most_category, elems
  end

  def top_merchant
    top_category = ''
    amount = 0
    (transactions_categories-['Income']).each do |category|
      if transactions.by_category(category).map(&:amount).sum > amount
        top_category = category
        amount = transactions.by_category(category).map(&:amount).sum
      end
    end
    return top_category, amount.to_f
  end

  def total_income
    transactions_sum_by_category("Income")
  end
end
