class AuthlinksController < ApplicationController

    def link
      client = LinkedIn::Client.new('dgdg77vt2f48', 'ToYDzQsG95imJXk6')
      request_token = client.request_token(:oauth_callback => "http://#{request.host_with_port}/Authlinks/authenticate_link")
      session[:rtoken] = request_token.token
      session[:rsecret] = request_token.secret
      redirect_to client.request_token.authorize_url
    end

    def show

    end


    def authenticate_link
      client = LinkedIn::Client.new('dgdg77vt2f48', 'ToYDzQsG95imJXk6')
      if session[:atoken].nil?
        pin = params[:oauth_verifier]
        atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
        session[:atoken] = atoken
        session[:asecret] = asecret
      else
        client.authorize_from_access(session[:atoken], session[:asecret])
      end
      @profile = client.profile(:fields => %w(first-name last-name headline positions educations skills location:(name) summary specialties ))
      @connections = client.connections

      @full_profile = client.profile(:fields => [:associations, :honors, :interests, :patents, :certifications, :courses, :volunteer, :date_of_birth, :honors_awards,:phone_numbers, :main_address, :email_address, :three_current_positions, :three_past_positions])
      @positions = client.profile(:fields => [:positions]).positions.all
      @saved_jobs = client.job_bookmarks(:fields => [:job, :is_applied, :is_saved])

      render :action => :info

    end


  end