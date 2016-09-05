module BlueprintAgreement
  class DrakovService
    attr :pid, :port, :hostname, :root_path

    def initialize(hostname = 'http://localhost')
      @port = Config.port
      @hostname = hostname
      @root_path = Config.server_path
    end

    def start(path='*.apib')
      @pid = spawn "drakov -f  #{root_path}/#{path} -p #{port} --header Authorization", options
    end

    def stop
      Process.kill 'TERM', pid
    end

    def host
      "http://localhost:#{port}"
    end

    def installed?
      `which drakov`.length > 0
    end

    def install
      print "installing drakov.."
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
