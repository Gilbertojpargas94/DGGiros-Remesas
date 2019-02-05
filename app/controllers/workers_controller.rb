class WorkersController < ApplicationController
  before_action :set_worker, only: [:show, :edit, :update, :destroy]
  before_action :ony_worker, only: [:show, :edit, :destroy, :new, :index, :update, :create]
  before_action :only_admin, only: [:edit, :destroy, :new, :update, :create, :index, :show]

  def index
    @users = User.where.not(type_person: 'normal')
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(worker_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to worker_path(@user), notice: 'El trabajador fue creada exitosamente.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(worker_params)
        format.html { redirect_to worker_path(@user), notice: 'El trabajador fue actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to workers_path, notice: 'El trabajador fue eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    def ony_worker
      if not current_user.nil?
        if current_user.type_person == 'normal'
          redirect_to root_path, notice: "No tienes permiso para acceder a esta sección, debes ser un trabajador", status: :unauthorized
        end
      else
        redirect_to new_user_session_path, notice: "Debes iniciar sesion para acceder", status: :unauthorized
      end
    end

    def only_admin
      if not current_user.nil?
        if current_user.type_person == 'worker'
          redirect_to workers_path, notice: "No tienes permiso para acceder a esta sección, debes ser administrador", status: :unauthorized
        end
      end
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_worker
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def worker_params
      params.require(:user).permit(:email, :name, :password, :phone, :status, :type_person)
    end
end
