class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[ show edit update destroy ]

  # GET /suppliers
  def index
    @q = Supplier.ransack(params[:q])
    @pagy, @suppliers = pagy(@q.result(distinct: true).order(created_at: :desc))
    @supplier_form = Supplier.new
  end

  # GET /suppliers/1
  def show
    @products = @supplier.products.ransack(params[:q])
    @pagy, @products = pagy(@products.result(distinct: true).order(created_at: :desc), limit: 5)
  end

  # GET /suppliers/new
  def new
    @supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
  end

  # POST /suppliers
  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      redirect_to suppliers_path, notice: "Supplier was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /suppliers/1
  def update
    if @supplier.update(supplier_params)
      redirect_to suppliers_path, notice: "Supplier was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /suppliers/1
  def destroy
    @supplier.destroy!
    redirect_to suppliers_path, notice: "Supplier was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def supplier_params
      params.expect(supplier: [ :name ])
    end
end
