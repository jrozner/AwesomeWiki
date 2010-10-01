class BaseController < Sinatra::Base

  include Grities

  set(:views      , 'app/views') 
  set(:base_path  , File.expand_path( File.join('..', '..')   , File.dirname(__FILE__)))
  set(:static     , true)
  set(:public     , File.join(BaseController.base_path, 'public') ) 
  set(:repository , Grit::Repo.new( File.join(BaseController.base_path, 'wiki') ) )
  
  get('/?') do
    redirect('/wiki/tree/') 
  end

end
