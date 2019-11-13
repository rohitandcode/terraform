from python_terraform import *

class TerraformWrapper(object):
    ''' Terraform basic wrapper '''

    def __init__(self, working_dir):
        ''' Directory path of tf files '''

        self.working_dir = working_dir

    def execute(self, action):
        ''' Execute action to run. Example init, validate, apply '''

        print('Running terraform')
        print action
        tef = Terraform(self.working_dir)
        if action == "init":
            tef.init(reconfigure=True)
            return_code, stdout, stderr = tef.init()
            return [return_code, stdout, stderr]
        elif action == "validate":
            tef.validate()
            return_code, stdout, stderr = tef.validate()
            return [return_code, stdout, stderr]
        elif action == "plan":
            tef.plan(refresh=False, capture_output=True)
            return_code, stdout, stderr = tef.plan()
            return [return_code, stdout, stderr]
        elif action == "apply":
            return_code, stdout, stderr = tef.apply("-auto-approve", capture_output=True)
            return [return_code, stdout, stderr]
        elif action == "destroy":
            return_code, stdout, stderr = tef.destroy("-auto-approve", capture_output=True)
            return [return_code, stdout, stderr]
        print ('Unsupported option was passed')
        print action
        return False
        
        
        #Sample usage:
        #import python_terraform_functions as tfg
        #tf = tfg.TerraformWrapper('/home/path/terraform/tfs')
        #res = tf.execute('validate')
