require_relative "../lib/post_repository.rb"

def reset_tables
  seed_sql = File.read('spec/blog_seeds.sql')
  connection = PG.connect({ host: ENV['HOST'], dbname: 'blog_test', user: 'postgres', password: ENV['PASSWORD'] })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do
    reset_tables
  end

  it "Return a single Post object with an array of comments" do
    repo = PostRepository.new
    post = repo.find_with_comments(1)
    expect(post.title).to eq 'My Dog'
    expect(post.comments.first.content).to eq 'Love it!'
  end
end