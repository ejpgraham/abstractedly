class AbstractsController < ApplicationController

  def index

    if params[:search]
      @abstracts = Abstract.search_by_body(params[:search]).map {|abstract| abstract}
      @abstracts.uniq! {|abstract| abstract.body }
      @abstracts.uniq! {|abstract| abstract.title }
    else
    end
  end
end
