class DonationsController < ApplicationController
  
  before_filter :get_types, :include => [:new,:create,:edit,:update]
  before_filter :authenticate_user!
  
  def index
    @donations = Donation.order('created_at DESC').paginate :page => params[:page]
  end

  def new
    @donation = Donation.new
  end
  
  def create
    donatable = create_donatable
    @donation = Donation.new donation_params.merge(:donatable => donatable)
    
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
    @donation.update_attributes(donation_params)
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
    donatable_type = params[:donation].delete :donatable_type if params[:donation][:donatable_type]
    @donatable = if donatable_type == "Voucher"
      Voucher.create(voucher_params)
    elsif donatable_type == "Experience"
      Experience.create(experience_params)
    elsif donatable_type == "PhysicalItem"
      PhysicalItem.create(physical_item_params)
    end
    
  end
  def load_donatable
    donatable_type = params[:donation].delete :donatable_type if params[:donation][:donatable_type]
    
    @donatable = if donatable_type == "Voucher"
      if params[:donation][:donatable][:id]
        Voucher.find(params[:donation][:donatable][:id]).update_attributes(voucher_params)
      else
        Voucher.create(voucher_params)
      end
    elsif donatable_type == "Experience"
      if params[:donation][:donatable][:id]
        Experience.find(params[:donation][:donatable][:id]).update_attributes(experience_params) 
      else
        Experience.create(experience_params)
      end
    elsif donatable_type == "PhysicalItem"
      if params[:donation][:donatable][:id]
        PhysicalItem.find(params[:donation][:donatable][:id]).update_attributes(physical_item_params)
      else
        PhysicalItem.create(physical_item_params)
      end
    end
  end
  
  def generate_errors donation
    flash[:error] = "Unable to successfully save the donation<br/>".html_safe
    flash[:error] += "<h4> #{view_context.pluralize(donation.errors.count,'Error')} prohibited this job from being saved </h4>".html_safe
  
    flash[:error] += "<ul>".html_safe
    donation.errors.full_messages.each do |msg| 
      flash[:error] += "<li>#{msg}</li>".html_safe
    end
    flash[:error] += "</ul>".html_safe
  end
  
  def donation_params
    params.require(:donation).permit(:title, :description)
  end
  
  def voucher_params
    params[:donation][:donatable].permit([:expiration_date])
  end
  
  def experience_params
    params[:donation][:donatable].permit(:latitude, :location, :longitude, :primary_contact_name)
  end
  
  def physical_item_params
    params[:donation][:donatable].permit(:height, :weight, :width)
  end
end
