class GameDefinitionsController < ApplicationController

  def index
    @game_definitions = GameDefinition.all
  end

  def new
    @game_definition = GameDefinition.new
  end

  def create
    @game_definition = GameDefinition.new(permissible_params)

    if @game_definition.save
      redirect_to @game_definition, notice: 'Game definition was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    @game_definition = GameDefinition.find(params[:id])
  end

  def update
    @game_definition = GameDefinition.find(params[:id])
    if @game_definition.update_attributes(permissible_params)
      redirect_to @game_definition, notice: 'Game definition was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def show
    @game_definition = GameDefinition.find(params[:id])
  end

  def destroy
    @game_definition = GameDefinition.find(params[:id])
    @game_definition.destroy
    redirect_to game_definitions_path
  end

  private

  def permissible_params
    params.require(:game_definition).permit(:name, :description, :author, :version)
  end
end
