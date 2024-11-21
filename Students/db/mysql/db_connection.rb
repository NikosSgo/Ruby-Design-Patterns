class DBConnection
  require 'mysql2'

  @client = nil

  private_class_method :new

  def self.instance
    @client ||= Mysql2::Client.new(
      host: 'localhost',
      username: 'nikos',
      password: '123',
      database: 'students'
    )
    @client
  end
end
 