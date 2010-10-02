module Grities

  # TODO:
  # Document me
  # Refactor me more
  def authors(repo, filename)
    ret = []
    all_commits = Grit::Commit.find_all(repo, nil)
    all_commits.each do |single_commit|
      tree = traverse_tree(single_commit.tree)
      tree.values.each do |blobs|
        blobs.each do |blob|
          if blob.name == filename
            ret << { :name  => single_commit.author.name,
                     :email => single_commit.author.email }
          end
        end
      end
    end
    ret = ret.uniq
  end 

  # TODO: 
  # Document me.
  def traverse_tree(tree, name = "", contents = {})
    if tree.trees.empty?
      name << tree.name.to_s
      contents[name] = tree.blobs
      name.clear
    else
      tree.name.nil? ? (contents['/'] = tree.blobs) : (name << tree.name + '/')
      tree.trees.each do |tree|
        traverse_tree(tree, name, contents)
      end
    end
    contents
  end

end
