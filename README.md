# FlaskTest

MAin COde

from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(port="0.0.0.0", debug=True)



Jenkins Pipeline Code
pipeline {
    agent any

    stages {

        stage('Clone the code') {
            steps {
                git url: 'https://github.com/Mahi2k/FlaskTest-Herovired', branch: 'main'
            }
        }
        stage('Install requirements') {
            steps {
                script {
                    dir('FlaskTest-Herovired') {
                        sh 'pip3 install -r requirements.txt'
                    }
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    dir('FlaskTest-Herovired') {
                        sh 'python3 test_app.py'
                    }
                }
            }
        }
        stage('Build Docker Image') {
            when {
                allOf {
                    expression {
                        currentBuild.result == 'SUCCESS' /
                    }
                    branch 'main' 
                }
            }
            steps {
                script {
                    sh 'sudo docker build -t FlaskTest-Herovired .'
                }
            }
        }
    }
}
