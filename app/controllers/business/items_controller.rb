class Business::ItemsController < BusinessController
  before_action :set_item, only: [:show, :edit, :destroy, :update]

  def index
    @items = Item.all
  end

  def create
    business = Business.find_by(slug: params[:slug])
    @item = business.items.new(item_params_to_dollars)
    if @item.save
      params[:category_ids].each do |category|
        category_id = category.to_i
        ItemCategory.create(item_id: @item.id, category_id: category_id)
      end
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def new
    @item = Item.new
    @business = current_user.businesses.first
  end

  def edit
    @business = Business.find_by(slug: params[:slug])
  end

  def show
  end

  def update
    @business = Business.find_by(slug: params[:slug])
    if @item.update(item_params_to_dollars)
      ItemCategory.destroy_all(item_id: @item.id)
      params[:category_ids].each do |category|
        category_id = category.to_i
        ItemCategory.create(item_id: @item.id, category_id: category_id)
      end

      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to admin_items_path
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title,
                                 :description,
                                 :image,
                                 :price_in_dollars,
                                 :item_status_id,
                                 :category_ids,
                                 :business_id)
  end

  def item_params_to_dollars
    { title: item_params[:title],
      description: item_params[:description],
      image: item_params[:image],
      business_id: item_params[:business_id],
      item_status_id: item_params[:item_status_id],
      category_ids: item_params[:category_ids],
      price: item_params[:price_in_dollars].to_f * 100 }
  end
end
