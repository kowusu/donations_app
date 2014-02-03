class DonationsController < ApplicationController
  
  before_filter :get_types, :include => [:new,:create,:edit,:update]
  before_filter :authenticate_user!
  
  def index
    @donations = Donation.paginate :page => params[:page], :order => 'created_at DESC'
  end

  def new
    @donation = Donation.new
  end
  
  def create
    donatable = create_donatable
    @donation = Donation.new params[:donation].merge(:donatable => donatable)
    #@donation.donatable = donatable
    if @donation.save
      redirect_to donations_path
    else
      generate_errors @donation
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
      generate_errors @donation
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
  def get_types
    @donation_types = ["Voucher","Experience","PhysicalItem"]
  end
  def create_donatable
    #debugger
    donatable_type = params[:donation].delete :donatable_type if params[:donation][:donatable_type]
    @donatable = if donatable_type == "Voucher"
      remove_unused_donatable_types params[:donation][:donatable], donatable_type
      Voucher.create(params[:donation].delete :donatable)
    elsif donatable_type == "Experience"
      remove_unused_donatable_types params[:donation][:donatable], donatable_type
      Experience.create(params[:donation].delete :donatable)
    elsif donatable_type == "PhysicalItem"
      remove_unused_donatable_types params[:donation][:donatable], donatable_type
      PhysicalItem.create(params[:donation].delete :donatable)
    end
    
  end
  def load_donatable
    donatable_type = params[:donation].delete :donatable_type if params[:donation][:donatable_type]
    
    @donatable = if donatable_type == "Voucher"
      remove_unused_donatable_types params[:donation][:donatable], donatable_type
      if params[:donation][:donatable][:id]
        Voucher.find(params[:donation][:donatable][:id]).update_attributes(params[:donation].delete :donatable)
      else
        Voucher.create(params[:donation].delete(:donatable))
      end
    elsif donatable_type == "Experience"
      remove_unused_donatable_types params[:donation][:donatable], donatable_type
      if params[:donation][:donatable][:id]
        Experience.find(params[:donation][:donatable][:id]).update_attributes(params[:donation].delete :donatable) 
      else
        Experience.create(params[:donation].delete :donatable)
      end
    elsif donatable_type == "PhysicalItem"
      remove_unused_donatable_types params[:donation][:donatable], donatable_type
      if params[:donation][:donatable][:id]
        PhysicalItem.find(params[:donation][:donatable][:id]).update_attributes(params[:donation].delete :donatable)
      else
        PhysicalItem.create(params[:donation].delete :donatable)
      end
    end
  end
  def remove_unused_donatable_types donatable_types, donatable_type
    if donatable_type == "Voucher"
      [:weight, :height, :width, :location, :latitude, :longitude, :primary_contact_name].each do |sym|
        donatable_types.delete sym
      end
    elsif donatable_type == "Experience"
      [:weight, :height, :width,:'expiration_date(2i)', :'expiration_date(3i)', :'expiration_date(1i)'].each do |sym|
        donatable_types.delete sym
      end
    elsif donatable_type == "PhysicalItem"
      [:location, :latitude, :longitude,:'expiration_date(2i)', :'expiration_date(3i)', :'expiration_date(1i)', :primary_contact_name].each do |sym|
        donatable_types.delete sym
      end
    end
  end
  
  def generate_errors donation
    #debugger
    flash[:error] = "Unable to successfully save the donation<br/>".html_safe
    flash[:error] += "<h4> #{view_context.pluralize(donation.errors.count,'Error')} prohibited this job from being saved </h4>".html_safe
  
    flash[:error] += "<ul>".html_safe
    donation.errors.full_messages.each do |msg| 
      flash[:error] += "<li>#{msg}</li>".html_safe
    end
    flash[:error] += "</ul>".html_safe
  end
  
  
end
