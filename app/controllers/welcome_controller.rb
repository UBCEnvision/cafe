class WelcomeController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
  	@order = Order.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :aasm_state)
    end

end
