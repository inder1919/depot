class StoreController < ApplicationController
  def index
    @products = Product.all
    @cart = current_cart
    
  end
def books
    @products = Product.books
    @cart = current_cart
end
def movies
    @products = Product.movies
        @cart = current_cart

end
def music
    @products = Product.music
        @cart = current_cart
end
def search
            @cart = current_cart
end
def find_products
  @cart = current_cart
   @category = params[:category]
   @title = params[:keywords]
   
    if @category == "All"
      @products = Product.where("title LIKE ?","%#{@title}%")        
    else 
      @products = Product.where("title LIKE ? AND category = ?" , "%#{@title}%", @category)
    end
    
     if @products.empty?
      flash[:notice] = "no products found"       
      redirect_to(:action => 'search')      
     end  
end
end
