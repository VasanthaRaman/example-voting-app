pipeline{
	agent any
	stages{
		stage('Git checkout'){
			steps{
				git 'https://github.com/VasanthaRaman/example-voting-app.git'
			}
		}
		stage('Build docker images'){
			steps{
				sh 'docker-compose build'
			}
		}
		stage('Copy built docker images'){
			steps{
				sh '/home/vasanth/projectFinal/example-voting-app/saveImgTar.sh'
			}
		}
		stage('check hosts'){
			steps{
				sh 'ansible azure -m ping -i /home/vasanth/projectFinal2/example-voting-app/hosts'
			}
		}
		stage('Download and install docker'){
			steps{
				//sh 'ansible-playbook docker-install.yml -i /home/vasanth/projectFinal2/example-voting-app/hosts'
			//	ansiblePlaybook credentialsId: 'azureprivkey', disableHostKeyChecking: true, installation: 'ansible2', inventory: 'hosts', playbook: 'docker-install.yml'
			//	ansiblePlaybook become: true, credentialsId: 'azureprivkey', disableHostKeyChecking: true, installation: 'ansible2', inventory: 'hosts', playbook: 'docker-install.yml'
			//	ansiblePlaybook become: true, credentialsId: 'azureprivkey', disableHostKeyChecking: true, extras: 'ansible_sudo_pass=Password@123', installation: 'ansible2', inventory: 'hosts', playbook: 'docker-install.yml'
				sh 'ansible-playbook docker-install.yml -i /home/vasanth/projectFinal2/example-voting-app/hosts --extra-vars "ansible_become_pass=Password@123"'
			}
		}	
		stage('Download minikube and kubectl packages'){
			steps{
				sh 'ansible-playbook minikube.yml -i /home/vasanth/projectFinal2/example-voting-app/hosts --extra-vars "ansible_become_pass=Password@123"'
			}
		}
		stage('Start minikube and apply deployments'){
			steps{
				sh 'ansible-playbook ansible-minikube.yml -i /home/vasanth/projectFinal2/example-voting-app/hosts --extra-vars "ansible_become_pass=Password@123"'
			}
		}
	}
}
