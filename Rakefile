
desc "Run unicorn and tail output"
namespace :server do

    def start_server
        server = fork do
            exec "unicorn -c config/unicorn.conf.rb"
        end

        Process.detach(server)
        server
    end

    desc "Start the server and tail the logs. Most often used for development"

    task :dev do
        begin
            server = start_server

            tail = fork do
                exec 'tail -f /var/log/trilby.log'
            end

            Process.wait2(tail)

        rescue SystemExit, Interrupt
            puts "Caught Ctrl-C, Ending server with pid #{server}"
            Process.exit(server)
            Process.exit(tail)
        end
    end
    
    desc "Start the server in the background"
    task :start do
        start_server        
    end
    
    desc "Kill all the unicorns"
    task :stop do
        `ps ax | grep unicorn | grep -v grep | cut -d ' ' -f1 | xargs kill`
    end
end