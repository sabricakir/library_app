class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    @books = Book.all.order(created_at: :desc)
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.turbo_stream do
          render turbo_stream:[
            turbo_stream.update('new_book',partial:"books/form",locals:{book:Book.new}),
            turbo_stream.prepend('books',partial:"books/book",locals:{book:@book}),
            turbo_stream.update('book_counter',Book.count),
            turbo_stream.update('book_notice',"Book #{@book.id} created")
          ]
        end
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.turbo_stream do
          render turbo_stream:[
            turbo_stream.update('new_book',partial:"books/form",locals:{book:@book})
          ]
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@book,partial:"books/book",locals:{book:@book}),
            turbo_stream.update('book_notice',"Book #{@book.id} updated")
          ]
        end
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@book,
                                                  partial:"books/form",
                                                  locals:{book:@book})
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.turbo_stream {render turbo_stream: [
        turbo_stream.remove(@book),
        turbo_stream.update('book_counter',Book.count),
        turbo_stream.update('book_notice',"Book #{@book.id} destroyed")] 
        }
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:name, :page, :author_id, :book_type_id, :publisher_id)
    end
end
