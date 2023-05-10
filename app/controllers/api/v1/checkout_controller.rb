class Api::V1::CheckoutController < Api::ApiController
include OrderHelper

  def checkout 
    # CON: Not using Rails permitted params, e.g.:
    #
    # params.require(:cart).permit(:reference, lineItems: [:name, :price, :collection])
    cart = params["cart"]

    if cart.present? 

      if cart["lineItems"].present?
        # CON: Could avoid all of these map operations with permitted params
        line_items = cart["lineItems"].map(&:to_enum).map(&:to_h).map(&:symbolize_keys!)
        
        response = calculate_discount(line_items)
        render json: {data: response}, status: :ok
      else
        render json: {error: 'Cart without products', message: "Can't calculate discount without items in cart"}, status: :bad_request
      end
      
    else
      render json: {error: 'Does not exist a cart', message: "Can't calculate discount without a cart"}, status: :bad_request
    end  
  end

end
