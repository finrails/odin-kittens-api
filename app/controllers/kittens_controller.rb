class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.json { render json: @kittens }
      format.html
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.json { render json: @kitten }
      format.html
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      redirect_to root_path, notice: "You've created a new cat with success!"
    else
      flash.now[:alert] = "Something went wrong, please try do it again."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      redirect_to root_path, notice: "The kitten has been updated with success!"
    else
      flash.now[:alert] = "Something went wrong! Try do it again."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])

    if @kitten.destroy
      redirect_to root_path, notice: "That kitten has been deleted with success."
    end

  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
