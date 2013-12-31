class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    # raise request.inspect.to_yaml
    # raise rack.request.query_hash.inspect

    # @url = request.original_url
    if Rails.env.development?
      base = 'http://localhost:3000/users/search.json'
    else
      base = 'http://imm-server.herokuapp.com.herokuapp.com/users/search.json'
      
    end

    query = request.env["QUERY_STRING"]
    @response = HTTParty.get(base + "?" + query)
    @http_code =  @response.code.inspect

     @users={}
    unless @response.blank? || @http_code == 200
      @users[:person_id]  = @response.parsed_response.first['person_id']
      @users[:state]      = @response.parsed_response.first['state']
      @users[:severity]   = @response.parsed_response.first['severity']
      @users[:status]     = @response.parsed_response.first['status']      
    end

    
  end

  def search
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
