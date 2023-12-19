class AutosController < ApplicationController

    def index
        @autos = Auto.all
    end

    def new
        @auto = Auto.new
    end

    def show
        @auto = Auto.find(params[:id])
    end

    def create
        @auto = Auto.new(:title => params[:title], :car_text => params[:auto], :user_id => current_user.id, :image => params[:image])

        if(@auto.save)
            redirect_to @auto
        else
            render 'new'
        end
    end

    def edit
        @auto = Auto.find(params[:id])
    end

    def update
        @auto = Auto.find(params[:id])
        if(@auto.update(:title => params[:title], :car_text => params[:car_text], :image => params[:image]))
            redirect_to @auto
        else
            render 'edit'
        end
    end

    def destroy
        @auto = Auto.find(params[:id])
        
        @auto.destroy
        redirect_to autos_path
    end

end
