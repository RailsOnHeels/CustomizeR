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

#@saved_jobs.all[0].job.description_snippet
#@job_description = "Bachelors or a Master's degree with minimum of 6+ years' experience in web development and program management.
#Experience in both B2B and B2C online marketing"

#tolower

#Populate from profile.skills: skill[0].name
#@people_skills = ['web development', 'program management', 'B2B', 'B2C', 'online marketing', 'marketing', 'java', ]

#Populate from profile.positions[0].title. profile.Headline? is showing current title I think.
#@people_positions = []

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

  def group_by_keyword(skills_info)
    @groups = []
    @skills = {}
    skills_info.each{ |skills|
      @groups.append(skills[2])
    }
    @groups.uniq
    @groups.each { |group|
      @skills_under_group = []
      skills_info.each{ |skill|
        if skill[2] == group
          @skills_under_group.append(skill[1])
        end
      @skills.merge!(group => @skills_under_group)
      }
    }
  end
end