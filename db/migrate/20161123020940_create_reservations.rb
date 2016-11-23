class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :user, index: true, foregin_key: true
      t.references :facility, index: true, foregin_key: true
      t.datetime :strat_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
