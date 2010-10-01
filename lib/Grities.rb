module Grities

  def authors(repo, name)
    r     = {}
    ret   = []
    commits = Grit::Commit.find_all(repo, nil)
    commits.each do |commit|
      commit.tree.trees.each do |tree|
        r.merge!(traverse_tree(tree))
      end

      r.each do |location, blobs|
        blobs.each do |blob|
          if blob.name == name
            ret << { :name  => commit.author.name, 
                     :email => Digest::MD5.hexdigest(commit.author.email) }
          end
        end
      end

      commit.tree.blobs.each do |blob|
        if blob.name == name
          ret << { :name => commit.author.name, 
                   :email => Digest::MD5.hexdigest(commit.author.email) }
        end
      end
    end
    ret.uniq!
  end

  
  def traverse_tree(tree, name = [], contents = {})
    if tree.name.nil?
      name << '/'
      contents['/'] = tree.blobs
      name.clear
    end

    if tree.trees.empty?
      name << tree.name
      contents[name.join('/')] = tree.blobs
      name.clear
    else
      name << tree.name
      tree.trees.each do |tree|
        traverse_tree(tree, name, contents)
      end
    end

    contents
  end

end
