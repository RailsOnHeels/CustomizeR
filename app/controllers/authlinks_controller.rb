class AuthlinksController < ApplicationController


    def link
      client = LinkedIn::Client.new('dgdg77vt2f48', 'ToYDzQsG95imJXk6')
      request_token = client.request_token(:oauth_callback => "http://#{request.host_with_port}/Authlinks/authenticate_link")
      session[:rtoken] = request_token.token
      session[:rsecret] = request_token.secret
      redirect_to client.request_token.authorize_url
    end

    def index

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

      #@updated_profile = reorganize_profile(@profile, @saved_jobs.all[0])
      render :action => :info

    end

    def create_resume
      authenticate_link()
      if job == 0
        @skills = reorganizing_profile(@profile,@saved_jobs.all[0])
      end


      if job ==1
        @skills = reorganizing_profile(@profile,@saved_jobs.all[0])
      end

      if job ==2
        @skills = reorganizing_profile(@profile,@saved_jobs.all[0])
      end

    end

    def reorganize_profile(user_profile, saved_job)
      @customizer_engine = CustomizerEngine.new
      @customizer_engine.set_user_skills(user_profile.skills)
      @customizer_engine.set_job_description(saved_job.job.description_snippet)
      @job_skills = @customizer_engine.get_keywords_from_job_description
      @customizer_engine.match_keywords_to_user_skills
      @highlighted_skills = @customizer_engine.highlight_user_skills_based_on_job_skills(@job_skills)
      @output = @customizer_engine.group_by_keyword

    end

  end