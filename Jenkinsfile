// pipeline {
//   agent any

//   stages {
//       stage('Build Artifact') {
//             steps {
//               sh "mvn clean package -DskipTests=true"
//               archive 'target/*.jar' //so that they can be downloaded later
//             }
//         }   
//     }
// }
pipeline {
  agent any

  stages {
      stage('Hello World') {
            steps {
              echo "hello world"
            }
        }   
    }
}