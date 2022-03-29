class BookTypesController < ApplicationController
    before_action :set_book_type, only: %i[ show edit update destroy ]
  
    # GET /book_types or /book_types.json
    def index
      @book_types = BookType.all
    end
  
    # GET /book_types/1 or /book_types/1.json
    def show
    end
  
    # GET /book_types/new
    def new
      @book_type = BookType.new
    end
  
    # GET /book_types/1/edit
    def edit
    end
  
    # POST /book_types or /book_types.json
    def create
      @book_type = BookType.new(book_type_params)
  
      respond_to do |format|
        if @book_type.save
            format.turbo_stream do
            render turbo_stream:[
              turbo_stream.update('new_book_type',partial:"book_types/form",locals:{book_type:BookType.new}),
              turbo_stream.prepend('book_types',partial:"book_types/book_type",locals:{book_type:@book_type}),
              turbo_stream.update('book_type_counter',BookType.count),
              turbo_stream.update('book_type_notice',"BookType #{@book_type.id} created")
            ]
          end
          format.html { redirect_to book_type_url(@book_type), notice: "BookType was successfully created." }
          format.json { render :show, status: :created, location: @book_type }
        else
            format.turbo_stream do
            render turbo_stream:[
              turbo_stream.update('new_book_type',partial:"book_types/form",locals:{book_type:@book_type})
            ]
          end
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @book_type.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /book_types/1 or /book_types/1.json
    def update
      respond_to do |format|
        if @book_type.update(book_type_params)
            format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update(@book_type,partial:"book_types/book_type",locals:{book_type:@book_type}),
              turbo_stream.update('book_type_notice',"BookType #{@book_type.id} updated")
            ]
          end
          format.html { redirect_to book_type_url(@book_type), notice: "BookType was successfully updated." }
          format.json { render :show, status: :ok, location: @book_type }
        else
            format.turbo_stream do
            render turbo_stream: turbo_stream.update(@book_type,
                                                    partial:"book_types/form",
                                                    locals:{book_type:@book_type})
          end
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @book_type.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /book_types/1 or /book_types/1.json
    def destroy
      @book_type.destroy
  
      respond_to do |format|
          format.turbo_stream {render turbo_stream: [
          turbo_stream.remove(@book_type),
          turbo_stream.update('book_type_counter',BookType.count),
          turbo_stream.update('book_type_notice',"BookType #{@book_type.id} destroyed")] 
          }
        format.html { redirect_to book_types_url, notice: "BookType was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_book_type
        @book_type = BookType.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def book_type_params
        params.require(:book_type).permit(:typeName)
      end
  end
  