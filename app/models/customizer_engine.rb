class CustomizerEngine

  def set_user_skills (skills)
    @user_skills = []
    skills.each { |skill|
      @user_skills.append([1, skill, ""])
    }
  end

  def set_user_positions (positions)
    @user_position = positions
  end

  def set_job_description (description)
    @job_description = description
  end

  def set_job_title(title)
    @job_title = title
  end

  def get_keywords_from_job_description
    @skills_keywords_in_job = []
    @keywords = {'web developer' => ['web developer', 'web design', 'html', 'html5', 'css', 'css3', 'javascript','ajax','jquery','jsp','php','java','python','ruby on rails'],
                 'ios developer' => ['ios developer', 'ios sdk','objective-c', 'xml','json','git','github'],
                 'project manager' => ['project manager', 'project management','scrum','pmp certification','agile', 'sdlc']
    }
    @keywords.each { |key, synonyms|
      synonyms.each { |synonym|
        if @job_description.match(synonym)
          @skills_keywords_in_job.append(key)
        end
      }
    }
    @skills_keywords_in_job
  end

  def match_keywords_to_user_skills
    @keywords = {'web developer' => ['web developer', 'web design', 'html', 'html5', 'css', 'css3', 'javascript','ajax','jquery','jsp','php','java','python','ruby on rails'],
                 'ios developer' => ['ios developer', 'ios sdk','objective-c', 'xml','json','git','github'],
                 'project manager' => ['project manager', 'project management','scrum','pmp certification','agile', 'sdlc']
    }
    @keywords.each { |key, synonyms|
      synonyms.each { |synonym|
        @user_skills.each { |user_skill|
          if user_skill[1].include?(synonym)
            user_skill[2] = key
          end
        }
      }
    }
    @user_skills
  end

  def highlight_user_skills_based_on_job_skills(job_skills)
    @user_skills.each { |skill|
      if job_skills.include?(skill[2])
        skill[0] = 0
      end
    }
    @user_skills.sort
  end

  def group_by_keyword(skills_info, job_id)
    @skills = {}
    if job_id == "0"
      @skills = { "Project management" => [ "Scrum", "Agile Methodolgy"],
                  "iOS development" => [ "Objective-C", "iOS"], "Web development"=> ["HTML", "HTML 5", "CSS", "CSS3","JavaScript"]

      }
    end


    if job_id =="1"
      @skills = {"iOS development" => ["Objective-C", "iOS"], "Web development"=> [ "HTML", "HTML 5", "CSS", "CSS3",
                                                                                    "JavaScript"],
                 "Project Management" => [ "Scrum", "Agile Methodolgy"]}

    end

    if job_id =="2"
      @skills = {"Web development"=> [ "HTML", "HTML 5", "CSS", "CSS3",
                                       "JavaScript"], "iOS development" => ["Objective-C", "iOS"], "Project management" => [ "Scrum", "Agile Methodolgy"]}

    end
    @skills
  end
end