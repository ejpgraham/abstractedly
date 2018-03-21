class JournalsController < ApplicationController

  def index
    @journals = Journal.all
  end

  def show
    @journal = Journal.find(params[:id])
  end

  def delete

  end

  def destroy
    #TODO admin only action
    Journal.find(params[:id]).destroy
  end

end
