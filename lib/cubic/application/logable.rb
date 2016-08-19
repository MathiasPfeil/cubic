module Cubic
  # Responsibe for logging information to the current environment log file.
  module Logable

    def log(message)
      File.open(log_path, 'a') { |file| file.write(message) }
    end

    private

    def log_path
      File.join(APP_PATH, "log/#{env}.log")
    end

    def env
      ENV['name'] || 'test'
    end
  end
end
