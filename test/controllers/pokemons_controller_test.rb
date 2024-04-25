require 'rails_helper'

RSpec.describe PokemonsController, type: :controller do
  describe "GET #index" do
    it "should get index" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "should get show" do
      category = Category.create!(name: 'fire')
      pokemon = Pokemon.create!(name: 'Pikachu', base_experience: 10, height: 15, weight: 20, category: category)
      get :show, params: { id: pokemon.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:pikachu_url) { "https://pokeapi.co/api/v2/pokemon/pikachu" } # URL for Pikachu

    context 'with valid API response for Pikachu' do
      before do
        # Stub the GET request to the Pokémon API for Pikachu
        stub_request(:get, pikachu_url)
          .to_return(status: 200, body: {
            name: 'Pikachu',
            base_experience: 112,
            height: 4,
            weight: 60,
            types: [{ type: { name: 'electric' } }]
          }.to_json)

        # Assuming `get_random_pokemon` should now always fetch 'Pikachu'
        allow(controller).to receive(:get_random_pokemon).and_return(PokeApi.get(pokemon: 'pikachu'))
      end

      it 'creates a new Pokémon' do
        expect {
          post :create
        }.to change(Pokemon, :count).by(1)
      end

      it 'redirects to the created Pokémon' do
        post :create
        expect(response).to redirect_to(Pokemon.last)
      end

      it 'sets a success notice' do
        post :create
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid API response' do
      before do
        # Simulate an API failure for Pikachu
        stub_request(:get, pikachu_url).to_return(status: 500, body: "")

        # Handling nil or error response
        allow(controller).to receive(:get_random_pokemon).and_return(nil)
      end

      it 'does not create a new Pokémon' do
        expect {
          post :create
        }.not_to change(Pokemon, :count)
      end

      it 'redirects to the Pokémon index' do
        post :create
        expect(response).to redirect_to(pokemons_path)
      end

      it 'sets an alert message' do
        post :create
        expect(flash[:alert]).to be_present
      end
    end
  end
end
