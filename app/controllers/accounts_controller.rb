class AccountsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @accounts = current_user.accounts.all
    @income_amount = current_user.transactions.by_category("income").map(&:amount).sum
    @spending_amount = current_user.transactions.spending_transactions.map(&:amount).sum
    if params[:search]
      if Account.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"]).first.present?
        @account_name = Account.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"]).first.name
        @transactions = Account.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"]).first.transactions.all
      else
        @account_name = "all accounts"
        @transactions = current_user.transactions.all
      end
    else
      @account_name = "all accounts"
      @transactions = current_user.transactions.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @accounts }
    end
  end

  def show
    @account = Account.find(params[:id])
    @bank = Bank.find_by_id(@account.bank_id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @account }
    end
  end

  def new
    @account = Account.new
    @user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @account }
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def create
    @account = current_user.accounts.build params[:account]

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, :notice => 'Account was successfully created.' }
        format.json { render :json => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.json { render :json => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to @account, :notice => 'Account was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :ok }
    end
  end

  def list
    @accounts = current_user.accounts.all
  end
end
