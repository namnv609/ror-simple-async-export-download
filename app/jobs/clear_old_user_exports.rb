class ClearOldUserExports
  @queue = :clear_old_user_exports

  def self.perform
    ClearOldUserExportsService.clear
  end
end
