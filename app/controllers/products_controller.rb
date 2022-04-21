class ProductsController < ApplicationController
    def index
        @products = Product.all
    end
    
    def create
        product = Product.create
        redirect_to product_product_step_path(product, :name)
    end

    def show
        @product = Product.find(params[:id])
    end
end
