class BooksController < ApplicationController
  layout "books"
  before_action :authenticate_admin!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_book, only: [:show, :new, :edit, :create, :update, :destroy]
  before_action :clear_search_index, only: [:index]


  # GET /books
  # GET /books.json
  def index
    authorize :index

    @search = Book.ransack(search_params)
    # make name the default sort column
    @search.sorts = "title" if @search.sorts.empty?
    @component = @search.result().page(params[:page])
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
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

    def pundit_user
      current_admin || nil
    end
end
