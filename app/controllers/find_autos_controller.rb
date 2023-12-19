class FindAutosController < ApplicationController
  
  def show
      @autos = Auto.where("title LIKE ?", "%" + Auto.sanitize_sql_like(params[:title]) + "%")
  end
end
