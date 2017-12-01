class JournalsController < ApplicationController

  def index
    @journals = Journal.all
  end

  def edit
  end

  def update
  end

  private

  def journal_params
  end

end
