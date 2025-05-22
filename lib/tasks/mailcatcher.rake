namespace :mailcatcher do
  desc 'Inicia o MailCatcher'
  task :start do
    if system("netstat -tln | grep -q ':1080 '")
     
    else
      system("mailcatcher")
    end
  end

  desc 'Para o MailCatcher'
  task :stop do
    if system("netstat -tln | grep -q ':1080 '")
      system("mailcatcher -k")
    end
  end

  desc 'Reinicia o MailCatcher'
  task :restart => [:stop, :start]
end 