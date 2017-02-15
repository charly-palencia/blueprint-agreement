module BlueprintAgreement
  module Services
    class Drakov
      PACKAGE = "drakov".freeze

      def initialize
        @contract = nil
        @pid = nil
        @config = BlueprintAgreement.configuration
      end

      def start(new_contract)
        install unless installed?
        return if @contract == new_contract
        stop if running?
        @contract = new_contract
        @pid = Process.spawn "#{PACKAGE} -f #{@config.root_path}/#{@contract} -p #{@config.port} #{@config.allow_headers}".strip, start_options
      end

      def runnning?
        !stopped?
      end

      def stopped?
        @pid.nil?
      end

      def stop
        Process.kill 'TERM', @pid
        @contract = nil
        @pid = nil
      end

      private

      def install
        print "installing #{PACKAGE}..."
        pid = Process.spawn "npm install -g #{PACKAGE}"
        Process.wait pid
        print "#{PACKAGE} installed 🍺"
      end

      def installed?
        `which #{PACKAGE}`.length > 0
      end

      def start_options
        {}.tap do |hsh|
          hsh[:out] = '/dev/null' unless ENV['AGREEMENT_LOUD']
        end
      end
    end
  end
end
