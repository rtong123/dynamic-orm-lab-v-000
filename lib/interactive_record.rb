require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    # DB[:conn].results_as_hash = true
    sql = <<-SQL
    PRAGMA table_info('#{table_name}')
    SQL

    table_info = DB[:conn].execute(sql)
    column_names = []
    table_info.each do |row|
      column_names << row["name"]
    end
    column_names.compact
  end

  def initialize(options={})
    options.each do |property, value|
      self.send("#{property}=", value)
    end
  end

  def save
    sql = "INSERT INTO #{table_name_for_insert} (#{col_names_for_insert})
    VALUES (#{values_for_insert})"
    DB[:conn].execute(sql)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{table_name_for_insert}")[0][0]
  end

  def table_name_for_insert
    self.class.table_name
  end

  def col_names_for_insert
    self.class.column_names.delete_if {|col| col == "id"}.join(", ")
  end

  def values_for_insert
    values = []
    self.class.column_names.each do |col_name|
      values << "'#{send(col_name)}'" unless send(col_name).nil?
    end
    values.join(", ")
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM #{self.table_name} WHERE name = '#{name}'"
    DB[:conn].execute(sql)
  end

  def self.find_by(options={})
    # col_name = nil
    # col_value = nil

    # options.each do |property, value|
      # col_name = property.to_s
      # value.is_a?(Integer) ? col_value = value : col_value = value.strip
    # end

    # DB[:conn].execute("SELECT * FROM #{self.table_name} WHERE #{col_name} = ?", col_value)
#==============================================
    # we are receiving a arguement of a hash called options
    # example argment: {name: "Rebecca"} or {grade: 10}

    # What do we want to do?
    # Find data that matches based on the argument passed in
    # We want to end up with a SQL command.  What do we need in order to build the SQL query?

    # DB[:conn].execute("SELECT * FROM students WHERE name = ?", "Rebecca")
    # but we need to make this generic - it needs to always work
    DB[:conn].execute("SELECT * FROM #{self.table_name} WHERE #{options.keys[0].string} = ?", my_hash.values[0].to_s)
  end

end
