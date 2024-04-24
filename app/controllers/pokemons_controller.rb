class PokemonsController < ApplicationController
  require 'poke-api-v2'

  def index
    @pokemons = Pokemon.includes(:category).all
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def create
    begin
      api_response = get_random_pokemon

      # If API response is empty or incomplete, select another Pokémon
      while api_response.nil? || incomplete_data?(api_response)
        api_response = get_random_pokemon
      end

      @pokemon = Pokemon.new(
        name: api_response.name,
        base_experience: api_response.base_experience,
        height: api_response.height,
        weight: api_response.weight,
        category_id: ensure_category(api_response.types)
      )

      if @pokemon.save
        redirect_to @pokemon, notice: 'Pokémon was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    rescue StandardError => e
      # Handle errors if API call fails or data is incomplete
      redirect_to pokemons_path, alert: "Failed to fetch Pokémon from API: #{e.message}"
    end
  end


  private

  def get_random_pokemon
    pokemon_name = Pokemon::POKEMONS.sample.downcase
    api_response = PokeApi.get(pokemon: pokemon_name)
  end

  # Ensure the category exists or create a new one if it does not
  def ensure_category(types)
    # We're just using the first type for simplicity
    type_name = types.first.type.name.capitalize
    Category.find_or_create_by(name: type_name).id
  end

  # Check if API response is incomplete or nil
  def incomplete_data?(api_response)
    api_response.nil? || api_response.name.nil? || api_response.base_experience.nil? || api_response.height.nil? || api_response.weight.nil?
  end
end
