module CustomAttributes
  class CustomAttributeValuesController < ApplicationController
    def create
      ca = @owner.custom_attributes.find {|ca| ca.name==params[:name]}

      respond_to do |format| 
        ca.value = params[:value]
        format.json do
          if ca.save
            render json: ca.to_json(methods: [:display_value, :value, :selected_option_id]), status: :created
          else
            render json: ca, status: :unprocessable_entity
          end
        end
      end
    end
  end
end