class CreateRegiones < ActiveRecord::Migration
  def change
    create_table :regiones do |t|
      t.string :nombre, :null => false
      t.decimal :long
      t.decimal :lat
      
      t.timestamps
    end
    
    regiones = ["Amazonas", "Ancash", "Apurimac", "Arequipa", "Ayacucho", "Cajamarca",
      "Callao", "Cusco", "Huancavelica", "Huanuco", "Ica", "Junin", "La Libertad",
      "Lambayeque", "Lima", "Loreto", "Madre de Dios", "Moquegua", "Pasco", "Piura",
      "Puno", "San martin", "Tacna", "Tumbes", "Ucayali"]
    regiones.each do |r| Region.create!(:nombre => r) end
  end
  
  def self.down
    drop_table :regiones
  end
end
