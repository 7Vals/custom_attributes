module CustomAttributes
  class CustomAttributeValuesController < ApplicationController
    def create
      ca = @owner.custom_attributes.find {|ca| ca.name==params[:name]}

      respond_to do |format| 
        ca.value = params[:value]
        if ca.save
          format.json { render json: ca.to_json(methods: [:display_value, :value, :selected_option_id]), status: :created }
          format.api { render json: { message: "Successfully Updated" }, status: 200 }
        else
          format.json { render json: ca, status: :unprocessable_entity }
          format.api { render json: { message: "Failed to update" }, status: :unprocessable_entity }
        end
      end
    end
  end
end
