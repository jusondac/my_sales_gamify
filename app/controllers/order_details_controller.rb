class OrderDetailsController < ApplicationController
  before_action :set_order_detail, only: %i[ show edit update destroy ]

  # GET /order_details
  def index
    @q = OrderDetail.ransack(params[:q])
    @pagy, @order_details = pagy(@q.result(distinct: true).order(created_at: :desc))
    @order_detail_form = OrderDetail.new
  end

  # GET /order_details/1
  def show
  end

  # GET /order_details/new
  def new
    @order_detail = OrderDetail.new
  end

  # GET /order_details/1/edit
  def edit
  end

  # POST /order_details
  def create
    @order_detail = OrderDetail.new(order_detail_params)

    if @order_detail.save
      redirect_to order_details_path, notice: "Order detail was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_details/1
  def update
    if @order_detail.update(order_detail_params)
      redirect_to order_details_path, notice: "Order detail was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /order_details/1
  def destroy
    @order_detail.destroy!
    redirect_to order_details_path, notice: "Order detail was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_detail
      @order_detail = OrderDetail.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def order_detail_params
      params.expect(order_detail: [ :order_id, :product_id, :payment_id, :discount, :service_fee ])
    end
end
