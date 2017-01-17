module BlueprintAgreement
  module APIServices
    class Drakov
      attr_reader :pid, :port, :hostname, :root_path, :allow_headers, :path

      def initialize
        @port = Config.port
        @allow_headers = Config.allow_headers
        @hostname = Config.hostname
        @root_path = Config.server_path
        @pid = nil
      end

      def start(path)
        @path = path
        @pid = Process.spawn "drakov -f #{root_path}/#{path} -p #{port} #{allow_headers}".strip, options
      end

      def stop
        Process.kill 'TERM', @pid
        @pid = nil
        @path = nil
      end

      def restart(new_path)
        stop if running?
        start(new_path)
      end

      def host
        "#{hostname}:#{port}"
      end

      def installed?
        !`which drakov`.empty?
      end

      def running?
        !@pid.nil?
      end

      def install
        print "installing drakov..."
        pid = Process.spawn "sudo npm install -g drakov"
        Process.wait pid
        print "Drakov installed 🍺  "
      end

      private

      def options
        return {} if ENV["AGREEMENT_LOUD"]

        { out: '/dev/null' }
      end
    end
  end
end
