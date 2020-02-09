class ModelFactory < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def build_model(schema:, table:)
      full_name = "#{schema}.#{table}"

      model = Class.new(ModelFactory) do
        self.table_name = full_name
      end

      create_database_objects(schema, model, full_name)

      model
    end

    private

    def create_database_objects(schema, model, full_name)
      connection = ModelFactory.connection

      # Create Schema 
      unless connection.schema_exists?(schema)
        begin
          connection.create_schema(schema)
        rescue PG::DuplicateSchema
        end
      end

      # Create Table
      new_table = false
      unless connection.table_exists?(full_name)
        new_table = true
        begin
          connection.create_table(model.table_name) do |table|
            table.column :name, :string, limit: 50, null: false
            table.column :address, :string, limit: 300, null: false
          end
        rescue PG::DuplicateTable
        end
      end
    end
  end

end