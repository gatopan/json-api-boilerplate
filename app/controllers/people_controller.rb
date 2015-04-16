class PeopleController < ApplicationController
  before_action :authenticate, only: [:secret]
  before_action :set_person, only: [:show, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all

    render json: @people
  end

  # GET /people/1
  # GET /people/1.json
  def show
    render json: @person
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    if @person.save
      render json: @person, status: :created, location: @person
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    if @person.update(person_params)
      head :no_content
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy

    head :no_content
  end

  def login
    unless @person = Person.find_by(email: params[:email])
      return render json: { message: "No user with this email was found" }
    end

    if @person.authenticate(params[:password])
      render json: { token: @person.token }
    else
      render json: { message: "Password does not match for this user"}, status: 401
    end
  end

  def secret
    render json: { message: "Secret message for #{@current_person.name}" }
  end

  private

    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.permit(:name, :email, :password, :password_confirmation, :role)
    end
end
