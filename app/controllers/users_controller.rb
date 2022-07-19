class UsersController < ApplicationController
  def index
    @users = User.all 
    render json: {data: UserSerializer.new(@users, each_serializer: UserSerializer), 
      message: "All Users fetched successfully", 
      status: 200, 
      type: 'Success'}
    end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)

    if @user.save 
      #render json: {user: @user, message: ""}
      render json: {data: UserSerializer.new(@user, each_serializer: UserSerializer), 
        message: "User created successfully", 
        status: 200, 
        type: 'Success'}
    else
      render json: {error: "Failure to create a User"}
    end
  end
  

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      #render json: {user: @user, message: "User updated successully"}
      render json: {data: UserSerializer.new(@user, each_serializer: UserSerializer), 
        message: "User updated successully", 
        status: 200, 
        type: 'Success'}
    else
      render json: {error: "Failure to update the user details."}
    end   
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      # render json: {user: @user, message: "User successfully destroyed."}
      render json: {data: UserSerializer.new(@user, each_serializer: UserSerializer), 
        message: "User deleted successully", 
        status: 200, 
        type: 'Success'}

    else
      render json: {error: "Unable to delete user."}
    end
  end

  private 
  def user_params
    params.require(:user).permit(:name, :age, :gender, :email)
  end
end
