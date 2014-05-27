desc "Run server"
task :default => :jison do
  sh "rackup"
end

task :jison => %w{public/parseExam.js}

desc "Compila Jison"
file "public/parseExam.js" => %w{public/parseExam.jison} do
  sh "jison public/parseExam.jison public/parseExam.l -o public/parseExam.js"
end

desc "Borrar base de datos"
task :rmdb do
  sh "rm -f database.db"
end

desc "Compile public/styles.scss into public/styles.css using sass"
task :sass do
  sh "sass  public/styles.scss public/styles.css"
end