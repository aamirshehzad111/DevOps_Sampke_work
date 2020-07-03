pipelineJob('dev_terraform') {

  logRotator {
      numToKeep(10)
  }

  definition {
    cpsScm {
      scm {
        git {
          remote {
                url('git@ec2-100-27-49-122.compute-1.amazonaws.com:root/terraform-project.git')
                credentials('jenkins')
            }
            branches('origin/master')
        }
      }
      scriptPath('Jenkinsfile')
      lightweight(false)
    }
  }
}

