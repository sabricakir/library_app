class PublishersController < ApplicationController
    before_action :set_publisher, only: %i[ show edit update destroy ]
  
    # GET /publishers or /publishers.json
    def index
      @publishers = Publisher.all
    end
  
    # GET /publishers/1 or /publishers/1.json
    def show
    end
  
    # GET /publishers/new
    def new
      @publisher = Publisher.new
    end
  
    # GET /publishers/1/edit
    def edit
    end
  
    # POST /publishers or /publishers.json
    def create
      @publisher = Publisher.new(publisher_params)
  
      respond_to do |format|
        if @publisher.save
            format.turbo_stream do
            render turbo_stream:[
              turbo_stream.update('new_publisher',partial:"publishers/form",locals:{publisher:Publisher.new}),
              turbo_stream.prepend('publishers',partial:"publishers/publisher",locals:{publisher:@publisher}),
              turbo_stream.update('publisher_counter',Publisher.count),
              turbo_stream.update('publisher_notice',"Publisher #{@publisher.id} created")
            ]
          end
          format.html { redirect_to publisher_url(@publisher), notice: "Publisher was successfully created." }
          format.json { render :show, status: :created, location: @publisher }
        else
            format.turbo_stream do
            render turbo_stream:[
              turbo_stream.update('new_publisher',partial:"publishers/form",locals:{publisher:@publisher})
            ]
          end
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @publisher.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /publishers/1 or /publishers/1.json
    def update
      respond_to do |format|
        if @publisher.update(publisher_params)
            format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update(@publisher,partial:"publishers/publisher",locals:{publisher:@publisher}),
              turbo_stream.update('publisher_notice',"Publisher #{@publisher.id} updated")
            ]
          end
          format.html { redirect_to publisher_url(@publisher), notice: "Publisher was successfully updated." }
          format.json { render :show, status: :ok, location: @publisher }
        else
            format.turbo_stream do
            render turbo_stream: turbo_stream.update(@publisher,
                                                    partial:"publishers/form",
                                                    locals:{publisher:@publisher})
          end
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @publisher.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /publishers/1 or /publishers/1.json
    def destroy
      @publisher.destroy
  
      respond_to do |format|
          format.turbo_stream {render turbo_stream: [
          turbo_stream.remove(@publisher),
          turbo_stream.update('publisher_counter',Publisher.count),
          turbo_stream.update('publisher_notice',"Publisher #{@publisher.id} destroyed")] 
          }
        format.html { redirect_to publishers_url, notice: "Publisher was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_publisher
        @publisher = Publisher.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def publisher_params
        params.require(:publisher).permit(:name)
      end
  end
  