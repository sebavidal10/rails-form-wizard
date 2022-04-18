 class ProductStepsController < ApplicationController
    include Wicked::Wizard

    before_action :product

    steps :name, :price, :color

    def show
      render_wizard
    end

    def update
      product.update(product_steps_params)
      
      render_wizard @product
    end

    def finish_wizard_path
        product_path(product)
    end

    private

    def product
      @product ||= Product.find(params[:product_id])
    end

    def product_steps_params
      params[:product].permit(:name, :color, :price)
    end

  end
