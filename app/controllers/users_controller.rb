class UsersController < ApplicationController
  def index
    # render json: UserBlueprint.render(users)
  end

  def show
  	puts User.find(params[:id]).name
    @user = User.find(params[:id])
    render json: UserBlueprint.render(@user, view: :normal)
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    
    if @user.save
      redirect_to @user, notice: 'User was successfully created.' # Redirect on success
    else
      # Re-render the form if validation fails
      render :new, status: :unprocessable_entity 
    end
  end

  private
  # This method was missing or misspelled. It enforces Strong Parameters.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
