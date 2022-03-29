class AuthorsController < ApplicationController
  before_action :set_author, only: %i[ show edit update destroy ]

  # GET /authors or /authors.json
  def index
    @authors = Author.all
  end

  # GET /authors/1 or /authors/1.json
  def show
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors or /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
          format.turbo_stream do
          render turbo_stream:[
            turbo_stream.update('new_author',partial:"authors/form",locals:{author:Author.new}),
            turbo_stream.prepend('authors',partial:"authors/author",locals:{author:@author}),
            turbo_stream.update('author_counter',Author.count),
            turbo_stream.update('author_notice',"Author #{@author.id} created")
          ]
        end
        format.html { redirect_to author_url(@author), notice: "Author was successfully created." }
        format.json { render :show, status: :created, location: @author }
      else
          format.turbo_stream do
          render turbo_stream:[
            turbo_stream.update('new_author',partial:"authors/form",locals:{author:@author})
          ]
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1 or /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
          format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@author,partial:"authors/author",locals:{author:@author}),
            turbo_stream.update('author_notice',"Author #{@author.id} updated")
          ]
        end
        format.html { redirect_to author_url(@author), notice: "Author was successfully updated." }
        format.json { render :show, status: :ok, location: @author }
      else
          format.turbo_stream do
          render turbo_stream: turbo_stream.update(@author,
                                                  partial:"authors/form",
                                                  locals:{author:@author})
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1 or /authors/1.json
  def destroy
    @author.destroy

    respond_to do |format|
        format.turbo_stream {render turbo_stream: [
        turbo_stream.remove(@author),
        turbo_stream.update('author_counter',Author.count),
        turbo_stream.update('author_notice',"Author #{@author.id} destroyed")] 
        }
      format.html { redirect_to authors_url, notice: "Author was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:name, :age, :birthPlace)
    end
end
