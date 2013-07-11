class MajorsController < ApplicationController
  load_and_authorize_resource :except=>:index
  # GET /majors
  # GET /majors.json
  def index
    if is_home?
      @params_q = {}
      @q = Major.search @params_q
      @title = I18n.t('home')
      @majors = Major.page.per(30).includes(:school)
    elsif params[:xuexiao].present?
      @school = School.find_by_name params[:xuexiao]
      params[:school_name] = @school.name
      @title = @school.name
      @majors = @school.majors.page.per(30).includes(:school)
    else
      @params_q = params[:q].present? ? params[:q].clone : {}
      %w(duixiang leibie moshi).each do |str|
          @params_q["#{str}_eq".to_sym] = eval("Major::#{str.upcase}")[params[str].to_sym] if params[str].present?
      end
      %w(name school_name).each do |str|
          @params_q["#{str}_cont".to_sym] = params[str] if params[str].present?
      end
      logger.debug @params_q
      @q = Major.search @params_q
      @majors = @q.result.includes(:school).page(params[:page] || 1).per(30)
      @title_key = (params.keys - %w(controller action page commit q utf8))
      @title_key += (params[:q].keys - %w(duixiang_eq leibie_eq moshi_eq rescue_format)) if params[:q].present?
      @title_key = @title_key.empty? ? 'default' : @title_key.sort.join('_')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @majors }
    end
  end

  # GET /majors/1
  # GET /majors/1.json
  def show
    @major = Major.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @major }
    end
  end

  # GET /majors/new
  # GET /majors/new.json
  def new
    @major = Major.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @major }
    end
  end

  # GET /majors/1/edit
  def edit
    @major = Major.find(params[:id])
  end

  # POST /majors
  # POST /majors.json
  def create
    @major = Major.new(params[:major])

    respond_to do |format|
      if @major.save
        format.html { redirect_to @major, notice: 'Major was successfully created.' }
        format.json { render json: @major, status: :created, location: @major }
      else
        format.html { render action: "new" }
        format.json { render json: @major.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /majors/1
  # PUT /majors/1.json
  def update
    @major = Major.find(params[:id])

    respond_to do |format|
      if @major.update_attributes(params[:major])
        format.html { redirect_to @major, notice: 'Major was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @major.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /majors/1
  # DELETE /majors/1.json
  def destroy
    @major = Major.find(params[:id])
    @major.destroy

    respond_to do |format|
      format.html { redirect_to majors_url }
      format.json { head :no_content }
    end
  end
end
