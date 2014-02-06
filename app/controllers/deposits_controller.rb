# encoding: utf-8
class DepositsController < ApplicationController
  before_action :set_deposit, only: [:show, :edit, :update, :destroy]
  before_action :set_pag, only: [:next, :index]

  @@count = 0

  # GET /deposits
  # GET /deposits.json
  def index

    logger.info "entrada pa #{@pag}"

    offs = @pag.to_i * 5;

    @deposits = Deposit.limit(5).offset(offs)
    @deposits2 = Deposit.all

    @paginas = @deposits2.size / 5
    if @deposits2.size % 5 != 0  
         @paginas += 1
    end
    logger.info "Siguiente pagina : #{offs}"
    logger.info "TAMAÑO lista : #{@paginas}"



  end

  # GET /deposits/1
  # GET /deposits/1.json
  def show
  end

  # GET /deposits/new
  def new
    @deposit = Deposit.new
  end

  # GET /deposits/1/edit
  def edit
  end

  # POST /deposits
  # POST /deposits.json
  def create
    @deposit = Deposit.new(deposit_params)
  
      respond_to do |format|
        if @deposit.save
          format.html { redirect_to @deposit, notice: t("deposit_created") }
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

    def set_pag
      @pag = params[:pag]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deposit_params
      params.require(:deposit).permit(:nombre, :monto, :fecha, :photo)
    end

end
