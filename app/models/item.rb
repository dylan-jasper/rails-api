class Item < ApplicationRecord
  # Default Scope ensures that deleted records are not returned
  default_scope { where(deleted_at: nil) }

  def soft_delete
    update_column(:deleted_at, Time.now)
  end

  def restore
    update_column(:deleted_at, nil)
  end
end
