@Library('jenkins-pipeline-library') _
import com.demo.pipeline

def projectProperties = [
    [
        $class: 'BuildDiscarderProperty',
        strategy: [$class: 'LogRotator', numToKeepStr: '10']
    ],
]
def imageName='mule-docker'
def commitTag
def err = null

currentBuild.result = "SUCCESS"
try {
  node {
    addListenerToBitbucketPush()

    stage('Clean Up') {  
        cleanUp()  
    }  

    stage('Checkout Code') {  
        checkoutSource()  
    }  

    stage('Build Image') {  
      buildImage(imageName, sshPrivateKeyFileName: "") {imageTag ->
        sh("echo imageTag :  ${imageTag}")  
        commitTag=imageTag
      }  
    } 

    stage('Push Image') {  
      pushImage(imageName)  
    } 
  
    stage('Tag Image') {  
      tags = sh(script: "git show-ref --tags -d | grep ^${commitTag} | sed -e 's,.* refs/tags/,,' -e 's/\\^{}//'", returnStdout: true)?.split()
      echo "tags: ${tags}"
      if(tags == null || tags.length == 0) {
          moveImage(imageName, 'latest')  
      }
      else{
          for (int i = 0; i < tags.size(); i++) { 
              def tag=tags[i]
              echo "tag image with: ${tag}"
              moveImage(imageName, "${tag}")  
          }  
      }
    }
  }
}
catch (error) {
    echo "Caught: ${error}"
    err = error
    currentBuild.result = "FAILURE"
} 
finally {    
    stage('Notify'){
        // Slack to users
    }
    if (err) {
        throw err
    }
}  