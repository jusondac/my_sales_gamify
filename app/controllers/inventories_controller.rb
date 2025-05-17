class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[ show edit update destroy ]

  # GET /inventories
  def index
    @q = Inventory.ransack(params[:q])
    @pagy, @inventories = pagy(@q.result(distinct: true).order(created_at: :desc))
    @inventory_form = Inventory.new
  end

  # GET /inventories/1
  def show
  end

  # GET /inventories/new
  def new
    @inventory = Inventory.new
  end

  # GET /inventories/1/edit
  def edit
  end

  # POST /inventories
  def create
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      redirect_to inventories_path, notice: "Inventory was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /inventories/1
  def update
    if @inventory.update(inventory_params)
      redirect_to inventories_path, notice: "Inventory was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /inventories/1
  def destroy
    @inventory.destroy!
    redirect_to inventories_path, notice: "Inventory was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory
      @inventory = Inventory.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def inventory_params
      params.expect(inventory: [ :product_id, :stock ])
    end
end
