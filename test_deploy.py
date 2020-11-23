import logging

terraform_path_ec2 = <location>

# Terraform init, validate and apply
tf = tfg.TerraformWrapper(terraform_path_ec2)
return_code, stdout, stderr = tf.execute('init')
if return_code != 0:
    raise Exception('Terraform init failed with {}:{}!'.format(return_code, stderr))
logging.info(stdout)

return_code, stdout, stderr = tf.execute('validate')
if return_code != 0:
    raise Exception('Terraform validate failed with {}:{}!'.format(return_code, stderr))
logging.info(stdout)

# Create resources
return_code, stdout, stderr = tf.execute('apply', var={"subscription_id" : subscription_id, "client_id" : client_id, "client_secret": client_secret, \
                                                       "tenant_id" : tenant_id, "resource_group_name" : resource_group_name, "rg_location" : rg_location, \
                                                       "subnet_location" : subnet_location, "subnet_name" : subnet_name, "subnet_vnet" : subnet_vnet, \
                                                       "subnet_rg" : subnet_rg, "search_image" : search_image, "search_rg" : search_rg, \
                                                       "search_image_id" : search_image_id, "deploy_image_name" : deploy_image_name, \
                                                       "deploy_image_location" : deploy_image_location, "deploy_image_rg" : deploy_image_rg, \
                                                       "deploy_image_size" : deploy_image_size, "deploy_vm_name" : deploy_vm_name, \
                                                       "deploy_username" : deploy_username, "deploy_password" : deploy_password})

if return_code != 0:
    raise Exception('Terraform apply failed with {}:{}!'.format(return_code, stderr))
logging.info(stdout)

instance_prop = tf.execute('output')
logging.info(stdout)

# Destroy resources
return_code, stdout, stderr = tf.execute('destroy', var={"subscription_id" : subscription_id, "client_id" : client_id, "client_secret": client_secret, \
                                                       "tenant_id" : tenant_id, "resource_group_name" : resource_group_name, "rg_location" : rg_location, \
                                                       "subnet_location" : subnet_location, "subnet_name" : subnet_name, "subnet_vnet" : subnet_vnet, \
                                                       "subnet_rg" : subnet_rg, "search_image" : search_image, "search_rg" : search_rg, \
                                                       "search_image_id" : search_image_id, "deploy_image_name" : deploy_image_name, \
                                                       "deploy_image_location" : deploy_image_location, "deploy_image_rg" : deploy_image_rg, \
                                                       "deploy_image_size" : deploy_image_size, "deploy_vm_name" : deploy_vm_name, \
                                                       "deploy_username" : deploy_username, "deploy_password" : deploy_password})
if return_code != 0:
    raise Exception('Terraform destroy failed with {}:{}!'.format(return_code, stderr))
logging.info(stdout)
