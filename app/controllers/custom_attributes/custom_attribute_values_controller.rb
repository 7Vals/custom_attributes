module CustomAttributes
  class CustomAttributeValuesController < ApplicationController
    def create
      ca = @owner.custom_attributes.find {|ca| ca.name==params[:name]}

      respond_to do |format| 
        ca.value = params[:value]
        if ca.save
          format.json { render json: ca.to_json(methods: [:value, :selected_option_id]), status: :created }
        else
          format.json { render json: ca, status: :unprocessable_entity }
        end
      end
    end
  end
end