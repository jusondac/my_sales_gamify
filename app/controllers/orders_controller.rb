class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders
  def index
    @q = Order.ransack(params[:q])
    @pagy, @orders = pagy(@q.result(distinct: true).where(user: Current.user).order(created_at: :desc))
    @order_form = Order.new
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  def create
    @order = Orders::Create.call(params)
    if @order.save
      redirect_to orders_path, notice: "Order was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def approve_order
    @order = Order.find(params[:id])
    @order.update(status: 1)
    redirect_to orders_path, notice: "Order was successfully approved."
    # render turbo_stream: turbo_stream.replace(
    #   "order_#{@order.id}",
    #   partial: "order",
    #   locals: { order: @order }
    # )
    # render json: {}, status: :ok
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to orders_path, notice: "Order was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy!
    redirect_to orders_path, notice: "Order was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.expect(order: [ :order_id, :amount, :status, :user_id, :ordered_at ])
    end
end
