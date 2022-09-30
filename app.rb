require_relative "lib/database_connection.rb"
require_relative "lib/post_repository.rb"

class Application
  def initialize(database_name, io, post_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @post_repository = post_repository
  end

  def run
    post = @post_repository.find_with_comments(1)

    @io.puts post.title
    @io.puts post.content
    @io.puts "Comments:"

    post.comments.each { |record|
      @io.puts "#{record.id} - #{record.content} from #{record.author_name}" 
    }
  end
end

if __FILE__ == $0
  app = Application.new(
    'blog',
    Kernel,
    PostRepository.new
  )
  app.run
end