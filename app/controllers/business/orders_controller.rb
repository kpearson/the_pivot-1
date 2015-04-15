class Business::OrdersController < BusinessController
  def index
    @statuses = Status.all
    @orders = params[:status_id] ? Status.find(params[:status_id]).
              orders : Order.all
  end

  def show
    @business = Business.find(slug: params[:slug])
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_orders_path
    else
      redirect_to admin_orders_path
    end
  end

  def order_params
    params.require(:order).permit(:status_id)
  end
end
