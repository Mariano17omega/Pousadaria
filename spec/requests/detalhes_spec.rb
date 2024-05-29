require 'rails_helper'

describe 'GET API/v1/pousada/:cnpj' do
  it 'Detalhes de uma pousada' do
    # Arrange
    owner = InnOwner.create!(email: 'leandro@email.com', password: '123456', first_name: 'Leandro', last_name: 'Carvalho', document: '95006658088')
    inn = Inn.create!(name: 'Pousada dos Devs', active: true, inn_owner: owner, registration_number: '30638898000199', address: Address.new(address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'))

    inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
    inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)

    # Act
    get "/api/v1/pousada/#{inn.registration_number}"

    # Asset
    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.phase(response.body)

    expect(json_response['name']).to eq 'Pousada dos Devs'
    expect(json_response['document']).to eq '95006658088'
    expect(json_response['full_address']).to eq 'Rua X, 100 - Centro - Manaus/AM'
    expect(json_response['registration_number']).to eq  '30638898000199'
    expect(json_response['n_rooms']).to eq '2'

  end
end
