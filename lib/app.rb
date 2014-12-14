require_relative 'idea_box'

require "sinatra/config_file"


class IdeaBoxApp < Sinatra::Base
	set :method_override, true
	set :root, 'lib/app'

	configure :development do
		register Sinatra::Reloader
	end

	register Sinatra::ConfigFile

  config_file '../config.yml'

	not_found do
		erb :error
	end

	get '/' do
		erb :index, locals: { ideas: IdeaStore.all.sort }
	end

	post '/' do
		IdeaStore.create(params[:idea], settings.dbpath)
		redirect '/'
	end

	get '/:id/edit' do |id|
		idea = IdeaStore.find(id.to_i, settings.dbpath)
		erb :edit, locals: {idea: idea}
	end

	delete '/:id' do |id|
		IdeaStore.delete(id.to_i, settings.dbpath)
		redirect '/'
	end

	put '/:id' do |id|
		IdeaStore.update(id.to_i, params[:idea], settings.dbpath)
		redirect '/'
	end

	post '/:id/like' do |id|
		idea = IdeaStore.find(id.to_i, settings.dbpath)
		idea.like!
		IdeaStore.update(id.to_i, idea.to_h, settings.dbpath)
		redirect '/'
	end

end
