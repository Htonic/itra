class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.includes(:campaigns)
  end

  # # GET /users/1
  # # GET /users/1.json
  def show
    if current_user.try(:admin?)
      @user = User.find(params[:id])
    else
    @user = current_user
      end
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end
  def create
    @user = User.new(user_params) #(params[:user])

    respond_to do |format|
      if resource.save
        # Tell the UserMailer to send a welcome email after save
        # {@user.send_admin_mail
        # @user.send_user_welcome_mail}

        format.html { redirect_to(profile_path(@user.profile))}
        #, notice: 'We have received your registration. We will be in touch shortly.') }
        #format.json { render json: root_path, status: :created, location: @user }
      else
        #format.html { redirect_to(root_path, alert: 'Sorry! There was a problem with your registration. Please contact us to sort it out.') }
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def block
    @users = User.where(id: params[:users])
    @users.update_all(is_active: 0)
  end

  def give_admin_rights
    @users = User.where(id: params[:users])
    @users.update_all(admin: true)
  end

  def revoke_admin_rights
    @users = User.where(id: params[:users])
    @users.update_all(admin: false)
  end

  def unblock
    @users = User.where(id: params[:users])
    @users.update_all(is_active: 1)
  end
  def what_to_do
    if current_user.try(:admin?)
      if params[:commit] ==t('admin.delete')
      destroy_multiple
    elsif params[:commit] ==t('admin.block')
      block
    elsif params[:commit] ==t('admin.unblock')
      unblock
    elsif params[:commit] ==t('admin.give_rights')
      give_admin_rights
    elsif params[:commit] ==t('admin.revoke_rights')
      revoke_admin_rights
    end
    end
    redirect_back(fallback_location: root_path)
  end
  def destroy_multiple
    begin
      @user = User.where(id: params[:users]).destroy_all
      @user.destroy
      respond_to do |format|
        format.html { redirect_to welcome_index_path }
        format.json { head :no_content }
      end
    rescue # optionally: `rescue Exception => ex`
      puts 'I am rescued.'
    end
    redirect_back(fallback_location: root_path)
  end
  def sign_out
    session.destroy
  end
  def delete
    @user = User.find(params[:id])
    @user.destroy
    redirect_to welcome_index_path
  end
  # # PATCH/PUT /users/1
  # # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :name, :email, :password)
    end

  def set_select_collections
    @campaigns = current_user.campaigns
  end

end
