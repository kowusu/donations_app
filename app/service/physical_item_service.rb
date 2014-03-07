class PhysicalItemService
  def initialize params
    @params = params
  end
  def create
    PhysicalItem.create(physical_item_params)
  end
  def load
    if params[:donation][:donatable][:id]
      physical_item = PhysicalItem.find(params[:donation][:donatable][:id])
      physical_item.update(physical_item_params)
      physical_item
    else
      PhysicalItem.create(physical_item_params)
    end
  end
  def physical_item_params
    @params[:donation][:donatable].permit(:height, :weight, :width)
  end
end
