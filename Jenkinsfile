pipeline {
  agent any
  parameters {
    choice(name: 'env', choices: ['dev', 'prod'], description: 'Pick which environment the deployment needs to be done to')
  }
  environment {
    TF_IN_AUTOMATION = 'true'
    TF_VAR_tf_state_store_bucket = "us-east-1-connectedsavings-terraform-state"
    TF_VAR_tf_state_lock_table = "terraform-state-lock"
    TF_VAR_aws_region = "us-east-1"
    TF_VAR_aws_profile = "default"
    TF_VAR_env = "${params.env}"
    TF_VAR_appliction = 'test-ec2'
    TF_VAR_state_store_enc_key = credentials("${params.env}-tf-state-store-enc-key")
    TF_VAR_vars_file = "${params.env}.terraform.tfvars"
    AWS_ACCESS_KEY_ID = credentials("${params.env}-aws-access-key-id")
    AWS_SECRET_ACCESS_KEY = credentials("${params.env}-aws-secret-access-key")
  }
  stages {
    stage('Terraform Init') {
      steps {
        echo "Terraform Init"
        sh "terraform init -input=false \
                           -backend-config=\"region=$TF_VAR_aws_region\" \
                           -backend-config=\"profile=$TF_VAR_aws_profile\" \
                           -backend-config=\"bucket=$TF_VAR_tf_state_store_bucket\" \
                           -backend-config=\"lock_table=$TF_VAR_tf_state_lock_table\" \
                           -backend-config=\"key=$TF_VAR_env/$TF_VAR_appliction\" \
                           -backend-config=\"kms_key_id=$TF_VAR_state_store_enc_key\""
      }
    }

    stage('Terraform Plan') {
      steps {
        echo "Terraform Plan"
        sh "terraform plan -out=tfplan -input=false -var-file=$TF_VAR_vars_file"
      }
    }

    stage('Terraform Apply') {
      steps {
           echo "SSH into the Build server to provision the resources via 'terraform apply'"
      }
    }
  }
}
