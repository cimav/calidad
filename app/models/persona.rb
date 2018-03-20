class Persona < NetmultixRecord

  self.table_name = "#{self.connection.current_database}.personas"

end