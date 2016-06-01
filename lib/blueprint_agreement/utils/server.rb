module BlueprintAgreement
  module Utils
    class Server
      attr :pid, :port, :hostname, :root_path

      def initialize(hostname = 'http://localhost')
        @port = Config.port
        @hostname = hostname
        @root_path = Config.server_path
      end

      def start(path='*.apib')
        install_drakov unless has_drakov?
        @pid = spawn "drakov -f  #{root_path}/#{path} -p #{port} --header Authorization", options
      end


      def stop
        Process.kill 'TERM', pid
      end

      def host
        "http://localhost:#{port}"
      end

      private

      def options
        return {} if ENV["AGREEMENT_LOUD"]

        { out: '/dev/null' }
      end

      def has_drakov?
        `which drakov`.length > 0
      end

      def install_drakov
        print "installing drakov.."
        pid = Process.spawn "sudo npm install -g drakov"
        Process.wait pid
        print "Drakov installed 🍺  "
      end

    end
  end
end
