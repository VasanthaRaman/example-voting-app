pipeline{
	agent any
	    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mavenn"
    }
	stages{
		stage('Git checkout'){
			steps{
				git 'https://github.com/VasanthaRaman/example-voting-app.git'
			}
		}
  stage('SonarQ') {
  environment {
    SCANNER_HOME = tool 'sonarr'
  }
  steps {
  dir('worker'){
    withSonarQubeEnv('sonarr') {
        sh '''  mvn sonar:sonar \
  -Dsonar.projectKey=proj \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=9629a9747338853ce85aa3fb16993ffe6b741551 '''
    }
    }
  }
}
 
		stage('Build docker images'){
			steps{
				sh 'docker-compose build'
			}
		}
		stage('Copy built docker images'){
			steps{
				sh '/home/vasanth/projectFinal3/example-voting-app/saveImgTar.sh'
			}
		}
		stage('check hosts'){
			steps{
			sshagent(credentials : ['azureprivkey']){
				sh 'ansible azure -m ping -i /home/vasanth/projectFinal3/example-voting-app/hostschk'
			}
				//sh 'ansible azure -m ping -i /home/vasanth/projectFinal3/example-voting-app/hostschk'
			}
		}
		stage('Download and install docker'){
			steps{
				//sh 'ansible-playbook docker-install.yml -i /home/vasanth/projectFinal3/example-voting-app/hosts --vault-password-file /home/vasanth/projectFinal3/example-voting-app/ansibleVaultPass.yml'
			//	ansiblePlaybook credentialsId: 'azureprivkey', disableHostKeyChecking: true, installation: 'ansible2', inventory: 'hosts', playbook: 'docker-install.yml'
			//	ansiblePlaybook become: true, credentialsId: 'azureprivkey', disableHostKeyChecking: true, installation: 'ansible2', inventory: 'hosts', playbook: 'docker-install.yml'
			//	ansiblePlaybook become: true, credentialsId: 'azureprivkey', disableHostKeyChecking: true, extras: 'ansible_sudo_pass=Password@123', installation: 'ansible2', inventory: 'hosts', playbook: 'docker-install.yml'
			//	sh 'ansible-playbook docker-install.yml -i /home/vasanth/projectFinal2/example-voting-app/hosts --vault-pass-file ansibleVaultPass.yml'
				//added comment
				ansiblePlaybook become: true, credentialsId: 'azureprivkey', disableHostKeyChecking: true, installation: 'ansible2', inventory: '/home/vasanth/projectFinal3/example-voting-app/hosts', playbook: 'docker-install.yml', vaultCredentialsId: 'ansVault'
			}
		}	
		stage('Download minikube and kubectl packages'){
			steps{
				//sh 'ansible-playbook minikube.yml -i /home/vasanth/projectFinal3/example-voting-app/hosts --extra-vars "ansible_become_pass=Password@123"'
			//	sh 'ansible-playbook minikube.yml -i /home/vasanth/projectFinal3/example-voting-app/hosts --vault-password-file /home/vasanth/projectFinal3/example-voting-app/ansibleVaultPass.yml'
			ansiblePlaybook become: true, credentialsId: 'azureprivkey', disableHostKeyChecking: true, installation: 'ansible2', inventory: '/home/vasanth/projectFinal3/example-voting-app/hosts', playbook: 'minikube.yml', vaultCredentialsId: 'ansVault'
			}
		}
		stage('Start minikube and apply deployments'){
			steps{
				//sh 'ansible-playbook ansible-minikube.yml -i /home/vasanth/projectFinal2/example-voting-app/hosts --extra-vars "ansible_become_pass=Password@123"'
			//	sh 'ansible-playbook ansible-minikube.yml -i /home/vasanth/projectFinal3/example-voting-app/hosts --vault-password-file /home/vasanth/projectFinal3/example-voting-app/ansibleVaultPass.yml'
			ansiblePlaybook become: false, credentialsId: 'azureprivkey', disableHostKeyChecking: true, installation: 'ansible2', inventory: '/home/vasanth/projectFinal3/example-voting-app/hosts', playbook: 'ansible-minikube.yml', vaultCredentialsId: 'ansVault'
			}
		}
	}
}
