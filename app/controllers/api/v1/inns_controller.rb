class Api::V1::InnsController < ActionController::API
  def show
    inn = Inn.all.where("inns.registration_number LIKE? ", params[:id] )
    n_rooms = inn.inn_rooms

    detalhes=[name: inn.name, registration_number: inn.registration_number, description: inn.description,
                full_address: full_address , n_rooms: n_rooms]
    render status: 200, json: detalhes.as_json
  end
end
