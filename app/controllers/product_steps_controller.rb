 class ProductStepsController < ApplicationController
    include Wicked::Wizard

    before_action :product

    steps :name, :price, :color

    def show
      # con views
      # render_wizard

      # con cells
      render_cell 'product_step', @product, action: :name
    end

    def update
      product.update(product_steps_params)
      # con views
      # render_wizard @product
      
      # con cells
      if params[:step] == 'end'
        if @product.name == ''
          @product.destroy
        end
        redirect_to root_path
      else
        render_cell 'product_step', @product, action: params[:step]
      end
    end

    def finish_wizard_path
      if @product.name == ''
        @product.destroy
      end
      root_path
    end

    private

    def product
      @product ||= Product.find(params[:product_id])
    end

    def product_steps_params
      params[:product].permit(:name, :color, :price)
    end

  end
