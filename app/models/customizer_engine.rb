class CustomizerEngine

  def set_user_skills (skills)
    @user_skills = []
    skills.each { |skill|
      @user_skills.append([skill, "", 0])
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
    @keywords = {'web development' => ['web development', 'web design'], 'program management' => ['program management',
                                                                                                  'project management'],
                 'UX' => ['user experience', 'UED', 'UX', 'user experience design', 'HCI',
                          'human computer interaction'], 'iOS apps' => ['iOS apps', 'mobile app development', 'objective c'],
                 'git' => ['git', 'github'],
                 'agile' => ['agile', 'scrum', 'co-location', 'pair programming','tdd',
                             'test driven development', 'refactor', 'code refactoring',
                             'continuous integration', 'XP',
                             'extreme programming', 'story', 'velocity'],
                 'rest' => ['rest', 'rest api', 'get post put delete','representational state transfer', 'web API'],
                 'json' => ['json', 'javascript object notation'],
                 'csm' => ['scrum master certified', 'csm', 'certification for scrum'],
                 'sdlc' => ['sdlc','software development life cycle', 'application development life cycle',
                            'software development life-cycle'], 'html' => ['html', 'css']
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
    @keywords = {'web development' => ['web development', 'web design'], 'program management' => ['program management',
                                                                                                  'project management'],
                 'UX' => ['user experience', 'UED', 'UX', 'user experience design', 'HCI',
                                                                                                                                  'human computer interaction'], 'iOS apps' => ['iOS apps', 'mobile app development', 'objective c'],
                 'git' => ['git', 'github'],
                 'agile' => ['agile', 'scrum', 'co-location', 'pair programming','tdd',
                                                         'test driven development', 'refactor', 'code refactoring',
                                                         'continuous integration', 'XP',
                                                         'extreme programming', 'story', 'velocity'],
                 'rest' => ['rest', 'rest api', 'get post put delete','representational state transfer', 'web API'],
                 'json' => ['json', 'javascript object notation'],
                 'csm' => ['scrum master certified', 'csm', 'certification for scrum'],
                 'sdlc' => ['sdlc','software development life cycle', 'application development life cycle',
                            'software development life-cycle'], 'html' => ['html', 'css']
    }
    @keywords.each { |key, synonyms|
      synonyms.each { |synonym|
        @user_skills.each { |user_skill|
          if user_skill[0].include?(synonym)
            user_skill[1] = key
          end
        }
      }
    }
    @user_skills
  end

  def highlight_user_skills_based_on_job_skills(job_skills)
    @user_skills.each { |skill|
      if job_skills.include?(skill[1])
        skill[2] = 1
      end
    }
    @user_skills
  end
end