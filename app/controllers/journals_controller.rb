class JournalsController < ApplicationController

  def index
    @journals = Journal.all

  end

  def edit
    @journal = Journal.find(params[:id])
  end

  def update
    @journal = Journal.find(params[:id])
    @journal.assign_attributes(journal_params)

    if @journal.save
      @journals = Journal.all
      render :index
    end
  end

  private

  def journal_params
    params.require(:journal).permit(:subscribed)
  end

end
