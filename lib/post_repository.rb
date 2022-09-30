require_relative "../lib/database_connection.rb"
require_relative "../lib/comment.rb"
require_relative "../lib/post.rb"

class PostRepository
  def find_with_comments(id)
    query = "SELECT posts.id,
                    posts.title,
                    posts.content,
                    comments.id AS comment_id,
                    comments.content AS comment_content,
                    comments.author_name
                      FROM comments
                        JOIN posts 
                        ON posts.id = comments.post_id
                      WHERE posts.id = $1;"

    params = [id] 
    result = DatabaseConnection.exec_params(query, params)
    
    post = record_to_post(result[0])

    result.each { |record|
    post.comments << record_to_comment(record)
    }

    post
  end

  private

  def record_to_post(record)
    post = Post.new
    post.id = record["id"]
    post.content = record["content"]
    post.title = record["title"]
    
    post
  end

  def record_to_comment(record)
    comment = Comment.new
    comment.id = record["comment_id"]
    comment.content = record["comment_content"]
    comment.author_name = record["author_name"]

    comment
  end
end