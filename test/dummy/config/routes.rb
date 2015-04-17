Rails.application.routes.draw do

  mount CustomAttributes::Engine => "/custom_attributes"
end
