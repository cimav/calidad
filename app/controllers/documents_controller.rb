class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :new_reminder, :create_reminder]

  # GET /documents
  # GET /documents.json
  def index
    department = Department.first
    redirect_to "/#{department.name.downcase}/documentos"
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @department = @document.department
  end

  def index_by_department
    @department = Department.find_by_name(params[:department_name])
    @documents = @department.documents
  end

  # GET /documents/new
  def new
  end

  # GET /documents/1/edit
  def edit
    @department = @document.department
    render layout:false
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to "/#{@document.department.name.downcase}/documentos", notice: 'Documento creado' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, alert:@document.errors }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to "/#{@document.department.name.downcase}/documentos", notice: 'Documento actualizado' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_reminder
    @document_owner = DocumentOwner.new
    render layout: false
  end

  def edit_reminder
    @document_owner = DocumentOwner.find(params[:id])
    render layout: false
  end

  def create_reminder
    document_owner = @document.document_owners.new
    document_owner.owner_name = params[:document_owner][:owner_name]
    document_owner.owner_email = params[:document_owner][:owner_email]

    respond_to do |format|
      if document_owner.save
        format.html { redirect_to "/#{@document.department.name.downcase}/documentos", notice: 'Recordatorio creado' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end

  end

  def update_reminder
    document_owner = DocumentOwner.find(params[:id])
    document_owner.owner_name = params[:document_owner][:owner_name]
    document_owner.owner_email = params[:document_owner][:owner_email]

    respond_to do |format|
      if document_owner.save
        format.html { redirect_to "/#{document_owner.document.department.name.downcase}/documentos", notice: 'Recordatorio actualizado' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:name, :code, :revision, :revision_date, :document_type, :department_id)
    end
end
