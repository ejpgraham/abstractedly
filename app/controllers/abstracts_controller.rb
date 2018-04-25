class AbstractsController < ApplicationController

  def index

    if params[:search]
      @abstracts = PgSearch.multisearch(params[:search]).map {|abstract| abstract.searchable}
      @abstracts.uniq! {|abstract| abstract.body }
    else
    end
  end
end
