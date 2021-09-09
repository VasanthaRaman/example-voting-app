pipeline{
	agent any
	
	stages{
		stage('Checkout'){
			steps{
			git 'https://github.com/VasanthaRaman/example-voting-app.git'
			}
		}
		stage('Remove existing containers'){
			steps{
			 	sh 'docker rm -f nodeJS worker db redis pythonFlask'
			}
		}
		stage('Docker compose call'){
			steps{
			 	sh 'docker-compose build'
			 	sh 'docker-compose up -d'
			}
		}
	}
}
