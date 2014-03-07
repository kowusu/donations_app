class VoucherService
  def initialize params
    @params = params
  end
  def create
    Voucher.create(voucher_params)
  end
  def load
    if @params[:donation][:donatable][:id]
      voucher = Voucher.find(@params[:donation][:donatable][:id])
      voucher.update(voucher_params)
      voucher
    else
      create
    end
  end
  def voucher_params
    @params[:donation][:donatable].permit([:expiration_date])
  end
end
