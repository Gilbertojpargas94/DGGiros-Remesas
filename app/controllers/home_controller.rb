class HomeController < ApplicationController
    def index
    	@rate = Rate.all
    end
end
