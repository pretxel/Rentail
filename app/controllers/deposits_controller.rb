require 'net/http'
require 'digest'
class DepositsController < ApplicationController
  before_action :set_deposit, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /deposits
  # GET /deposits.json
  def index

    if (current_user.role == 1)
      @deposits = Deposit.all
    else
      @deposits = Deposit.where(user: current_user.email).order(fecha: :asc)
    end
  end

  # GET /deposits/1
  # GET /deposits/1.json
  def show
  end

  # GET /deposits/new
  def new
    @deposit = Deposit.new
    @deposit.hash = ""
  end

  # GET /deposits/1/edit
  def edit
  end

  # POST /deposits
  # POST /deposits.json
  def create
    @deposit = Deposit.new(deposit_params)
    @deposit.user = current_user.email

    mes = @deposit.fecha.split("/")
    @deposit.mes = mounth_insert(mes[1])
    md5 = Digest::MD5.new
    md5.update @deposit.fecha.to_s
    @deposit.hash = md5.hexdigest

    if request.POST.include? "g-recaptcha-response"
      #gresponse = request.get_fields('g-recaptcha-response')


      uri = URI('http://www.google.com/recaptcha/api/siteverify')
      req = Net::HTTP::Post.new(uri)
      req.set_form_data('secret' => '6Lc6qgcTAAAAAO9dAM1kaHvyI3UNoOYDHkI-olJY', 'response' => params["g-recaptcha-response"])

      res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(req)
      end
      logger.info "RESPUESTA_POST_1 : #{res.body}"
      # url = URI.parse('https://www.google.com/recaptcha/api/siteverify')
      # req = Net::HTTP::Post.new(url.to_s)
      # res = Net::HTTP.start(url.host, url.port) {|http|
      #   response =  http.post('/cgi-bin/search.rb', 'query='.gresponse)
      # }
      # logger.info "RESPUESTA_POST : #{res.body}"

    end

    respond_to do |format|
      if @deposit.save
        format.html { redirect_to @deposit, notice: 'Deposit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @deposit }
      else
        format.html { render action: 'new' }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deposits/1
  # PATCH/PUT /deposits/1.json
  def update
    respond_to do |format|
      if @deposit.update(deposit_params)
        format.html { redirect_to @deposit, notice: 'Deposit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deposits/1
  # DELETE /deposits/1.json
  def destroy
    @deposit.destroy
    respond_to do |format|
      format.html { redirect_to deposits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deposit
      @deposit = Deposit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deposit_params
      params.require(:deposit).permit(:monto, :fecha, :photo, "g-recaptcha-response")
    end

    def mounth_insert(num_mounth)
      if num_mounth == "01"
        mes = "Enero"
      elsif num_mounth == "02"
        mes = "Febrero"
      elsif num_mounth == "03"
        mes = "Marzo"
      elsif num_mounth == "04"
        mes = "Abril"
      elsif num_mounth == "05"
        mes = "Mayo"
      elsif num_mounth == "06"
        mes = "Junio"
      elsif num_mounth == "07"
        mes = "Julio"
      elsif num_mounth == "08"
        mes = "Agosto"
      elsif num_mounth == "09"
        mes = "Septiembre"
      elsif num_mounth == "10"
        mes = "Octubre"
      elsif num_mounth == "11"
        mes = "Noviembre"
      elsif num_mounth == "12"
        mes = "Diciembre"
      end
    end

end
