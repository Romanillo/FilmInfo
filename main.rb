$:.unshift "."
require 'sinatra'
require "sinatra/reloader" if development?
require 'sinatra/flash'
require 'database'
require 'pp'

set :reserved_words, %w{test}
set :max_files, 8        # no more than max_files will be saved

helpers do
  def current?(path='/')
    (request.path==path || request.path==path+'/') ? 'class = "current"' : ''
  end
end

get '/grammar' do
  erb :\Gramatica\grammar
end

get '/test' do
  erb :test
end

get '/:selected?' do |selected|
  programs = PL0Program.all
  pp programs
  puts "selected = #{selected}"
  c  = PL0Program.first(:name => selected)
  source = if c then c.source else "Inserte aqui los datos." end
  erb :index, 
      :locals => { :programs => programs, :source => source }
end

post '/save' do
  pp params
  name = params[:fname]
  c  = PL0Program.first(:name => name)
  puts "prog <#{c.inspect}>"
  if c
    c.source = params["input"]
    c.save
  else
    if PL0Program.all.size > settings.max_files
      c = PL0Program.all.sample
      c.destroy
    end
    c = PL0Program.new
    c.name = params["fname"]
    c.source = params["input"]
    c.save
  end
  pp c
  redirect '/'
end
