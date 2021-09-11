pipeline{
	agent any
	stages{
		stage('Git checkout'){
			steps{
				git checkout 'https://github.com/VasanthaRaman/example-voting-app.git'
			}
		}
		stage('Build docker images'){
			steps{
				sh 'docker-compose build'
			}
		}
		stage('Copy built docker images'){
			steps{
				sh './savImgTar.sh'
			}
		}
		stage('Download and install docker'){
			steps{
				sh 'ansible-playbook install-docker.yml -i hosts'
			}
		}	
		stage('Download minikube and kubectl packages'){
			steps{
				sh 'ansible-playbook minikube.yml -i hosts'
			}
		}
		stage('Start minikube and apply deployments'){
			steps{
				sh 'ansible-playbook ansible-minikube.yml -i hosts'
			}
		}
	}
}
