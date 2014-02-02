class DonationsController < ApplicationController
  
  def index
    @donations = Donation.all
  end

  def new
    @donation = Donation.new
  end
  
  def create
    donatable = create_donatable
    @donation = Donation.new params[:donation]
    @donation.donatable = donatable
    if @donation.save
      redirect_to donations_path
    else
      render :action => :new
    end
  end
  
  def edit
    @donation = Donation.find(params[:id])
  end
  
  def update
    @donation = Donation.find(params[:id])
    @donation.donatable = load_donatable
    @donation.update_attributes(params[:donation])
    if @donation.save
      redirect_to donations_path
    else
      render :action => :edit
    end
  end
  
  def show
    begin
      @donation = Donation.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @donation 
    end
    unless @donation
      redirect_to donations_path
    end
  end
  
  def destroy
    @donation = Donation.find(params[:id])
    @donation.destroy
    redirect_to donations_path
  end
  
  private
  def create_donatable
    donatable_type = params[:donation].delete :donatable_type if params[:donation][:donatable_type]
    @donatable = if donatable_type == "Voucher"
      Voucher.new(params[:donation].delete :donatable)
    elsif donatable_type == "Experience"
      Experience.new(params[:donation].delete :donatable)
    elsif donatable_type == "PhysicalItem"
      PhysicalItem.new(params[:donation].delete :donatable)
    end
    
  end
  def load_donatable
    donatable_type = params[:donation].delete :donatable_type if params[:donation][:donatable_type]
    
    @donatable = if donatable_type == "Voucher"
      if params[:donation][:donatable][:id]
        Voucher.find(params[:donation][:donatable][:id]).update_attributes(params[:donation].delete :donatable)
      else
        Voucher.new(params[:donation].delete(:donatable))
      end
    elsif donatable_type == "Experience"
      if params[:donation][:donatable][:id]
        Experience.find(params[:donation][:donatable][:id]).update_attributes(params[:donation].delete :donatable) 
      else
        Experience.new(params[:donation].delete :donatable)
      end
    elsif donatable_type == "Experience"
      if params[:donation][:donatable][:id]
        PhysicalItem.find(params[:donation][:donatable][:id]).update_attributes(params[:donation].delete :donatable)
      else
        PhysicalItem.new(params[:donation].delete :donatable)
      end
    end
  end
  
  
end
