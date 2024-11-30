class RemoveDoctorIdFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :doctor_id, :integer
  end
end
