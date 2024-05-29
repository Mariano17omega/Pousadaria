class Api::V1::InnsController < ActionController::API
  def show
    inn = Inn.all.where("inns.registration_number LIKE? ", params[:id] )

    render status: 200, json: inn.as_json
  end
end
