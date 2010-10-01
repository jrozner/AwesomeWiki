class WikiController < BaseController


  before do
    @repo ||= BaseController.repository
    @contents     = {} 
  end  

  get('/tree/*') do |path|
    path.empty? ? (blob = @repo.tree) : (blob = @repo.tree./(path))

    case blob
      when nil
        halt(200, 'awesome') 
      when Grit::Tree
        @contents = traverse_tree(blob)
        erb(:index, :layout => :wiki_layout)
      when Grit::Blob
        @authors = authors(@repo, blob.name)  
        @text    = Kramdown::Document.new(blob.data).to_html
        erb(:topic, :layout => :wiki_layout)  
      end
  end

  not_found do 
    erb(:four_oh_four, :layout => :wiki_layout)
  end

end

