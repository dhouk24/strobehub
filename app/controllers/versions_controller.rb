class VersionsController < ApplicationController
	skip_before_filter	:require_login, :only => [:index, :show]
	respond_to :json

	def index
		@repository = Repository.find(params[:repository_id])
		@versions = @repository.versions
	end

	def new
		@version = Version.new
	end

	def create
		# creates a new version of a repo
	end

	def show
		@repository = Repository.find(params[:repository_id])
		@version = Version.find(params[:id])
		@tracks = @version.tracks
	end

	def edit
		@repository = Repository.find(params[:repository_id])

		@version = Version.find(params[:id])
		@tracks = @version.tracks.order("id ASC")
		respond_to do |format|
			format.html
			format.json { render json: @tracks.to_json(:only => [:id, :url, :offset, :duration, :delay, ]) }
		end
		current_version = Version.find(params[:id])
		if current_version.user == current_user
			@version = current_version
		else
			@version = current_version.clone(current_user)
		end
	end

	def update
		Version.update_version(params[:tracks], params[:id])
		respond_to do |format|
			format.json { render :json => "Saved Succesfully" }
		end
	end

	def destroy
		# deletes the version
	end

end
