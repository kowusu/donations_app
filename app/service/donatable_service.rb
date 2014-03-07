class DonatableService
  
  def initialize(params)
    @params = params
    @donatable_service = case @params[:donation][:donatable_type]
    when "Voucher"
      VoucherService.new @params
    when "Experience"
      ExperienceService.new @params
    when "PhysicalItem"
      PhysicalItemService.new @params
    end
  end
  
  def create
    @donatable_service.create if @donatable_service
  end
  
  def load
    @donatable_service.load if @donatable_service
  end
end