class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @price_min = Product.minimum(:price).floor.to_i
    @price_max = Product.maximum(:price).ceil.to_i

    params[:pmi] ||= @price_min
    params[:pma] ||= @price_max

    order_col = :price
    order_g = :asc
    boost_c = 1.0
    
    if params[:sf] && !params[:sf].nil? && !params[:sf].empty?
      sf = params[:sf].split("-")

      if sf[0] != "relevance"
        order_col = sf[0].to_sym
        order_g = sf[1].to_sym
      else
        boost_c = 2.0
      end
    end

    @search = Product.search do
      fulltext params[:search] do
        boost_fields :title => boost_c
      end

      with(:country, params[:cf]) if params[:cf].present?

      with(:price, params[:pmi]..params[:pma])

      order_by order_col, order_g
      paginate(:page => params[:page] || 1, :per_page => 10)
    end
    @products = @search.results

    @countries = Product.select(:country).distinct.order(:country).collect { |p| [p.country, p.country.downcase] }
    @sort_opts = [["Relevance", "relevance-asc"], ["Price: Low to High", "price-asc"], ["Price: High to Low", "price-desc"], ["Newest Arrivals", "created_at-desc"]]
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:title, :description, :country, :tags, :price)
  end
end
