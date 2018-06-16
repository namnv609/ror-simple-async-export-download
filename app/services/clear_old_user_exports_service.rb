class ClearOldUserExportsService
  EXPIRED_TIME_IN_HOUR = 1

  class << self
    def clear
      user_export_files = Dir[Rails.root.join("tmp", "users_export_*.xlsx")]
      expired_files = []

      user_export_files.each do |file|
        created_time = File::Stat.new(file).ctime
        hour_ago = ((Time.now - created_time) / EXPIRED_TIME_IN_HOUR.hour)

        next if hour_ago < EXPIRED_TIME_IN_HOUR
        expired_files << file
        FileUtils.rm file
      end

      write_log user_export_files.size, expired_files
    end

    private
    def write_log total_files, expired_files
      logger = Logger.new Rails.root.join("log", "clear_user_export.log")
      log_content = "\n==========ClearOldStaffExportsService==========\n"
      log_content << "Total files: #{total_files}\n"
      log_content << "Expired files: #{expired_files.size}\n"
      log_content << expired_files.map{|f| "- #{f}"}.join("\n")
      log_content << "\n==========***************************==========\n"

      logger.info log_content
    end
  end
end
