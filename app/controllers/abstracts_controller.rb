class AbstractsController < ApplicationController

  def index

    if params[:search]
      @abstracts = PgSearch.multisearch(params[:search]).map {|abstract| abstract.searchable}
    else

    end
  end
end
