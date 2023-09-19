# creating security groups
locals {
  security_groups = {
    ext-alb-sg = {
      name        = "ext-alb-sg"
      description = "for external loadbalncer"

    }

 # security group for IALB
    int-alb-sg = {
      name        = "int-alb-sg"
      description = "IALB security group"
    }


# security group for webservers
    webserver-sg = {
      name        = "webserver-sg"
      description = "webservers security group"
    }    

 # security group for data-layer
    datalayer-sg = {
      name        = "datalayer-sg"
      description = "data layer security group"


    }

 # security group for vpc-endpoint
    datalayer-sg = {
      name        = "vpc-endpoint-sg"
      description = "data layer security group"
  }   
}
}
