class ExperienceService
  def initialize params
    @params = params
  end
  def create
    Experience.create(experience_params)
  end
  def load
    if params[:donation][:donatable][:id]
      experience = Experience.find(params[:donation][:donatable][:id])
      experience.update(experience_params)
      experience
    else
      Experience.create(experience_params)
    end
  end
  def experience_params
    @params[:donation][:donatable].permit(:latitude, :location, :longitude, :primary_contact_name)
  end
end
