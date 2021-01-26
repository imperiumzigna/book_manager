class BooksController < ApplicationController
  layout "books"
  before_action :set_book, only: [:show]
  before_action :clear_search_index, only: [:index]


  # GET /books
  # GET /books.json
  def index
    @search = Book.search(search_params)
    # make name the default sort column
    @search.sorts = "title" if @search.sorts.empty?
    @component = @search.result().page(params[:page])
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def search_params
      params[:q]
    end

    def clear_search_index
      if params[:search_cancel]
        params.delete(:search_cancel)
        if !search_params.nil?
          search_params.each do |key, param|
            search_params[key] = nil
          end
        end
      end
    end
end
