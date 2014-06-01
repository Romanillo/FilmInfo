desc "Run server"
task :default => :jison do
  sh "rackup"
end

task :jison => %w{public/FilmInfo.js}

desc "Compila Jison"
file "public/FilmInfo.js" => %w{public/FilmInfo.jison} do
  sh "jison public/FilmInfo.jison -o public/FilmInfo.js"
end

desc "Borrar base de datos"
task :rmdb do
  sh "rm -f database.db"
end

desc "Compile public/styles.scss into public/styles.css using sass"
task :sass do
  sh "sass  public/styles.scss public/styles.css"
end