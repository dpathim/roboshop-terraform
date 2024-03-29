default_vpc_id = "vpc-0ea00bb90d84e71e1"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_route_table_id = "rtb-0dc27a26c8b542a80"
env = "dev"
zone_id = "Z05403493ASGK93BQVTBE"
ssh_ingress_cidr = ["172.31.3.176/32"]
monitoring_ingress_cidr = ["172.31.3.1/32"]


vpc = {
 main = {
  cidr      = "10.0.0.0/16"
  subnets = {
     public = {
       public1 = { cidr = "10.0.0.0/24" , az = "us-east-1a"}
       public2 = { cidr = "10.0.1.0/24" , az = "us-east-1b"}
     }
     app = {
        app1 = { cidr = "10.0.2.0/24" , az = "us-east-1a"}
        app2 = { cidr = "10.0.3.0/24" , az = "us-east-1b"}
   }
    db = {
    db1 = { cidr = "10.0.4.0/24" , az = "us-east-1a"}
    db2 = { cidr = "10.0.5.0/24" , az = "us-east-1b"}
   }
  }

}
}


tags = {
  company_name = "ABC Tech"
  business_unit = "Ecommerce"
  project_name = "roboshop"
  cost_center = "ecom_rs"
  created_by  = "terraform"

}
#
#
alb = {

  public = {
    internal = false
    lb_type =  "application"
    sg_ingress_cidr = ["0.0.0.0/0"]
    sg_port = 80
  }

  private = {
    internal = true
    lb_type = "application"
    sg_ingress_cidr = ["172.31.0.0/16", "10.0.0.0/16"]
    sg_port = 80
  }
}

docdb = {
  main = {
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    engine_version          = "4.0.0"
    engine_family           = "docdb4.0"
   instance_count           = 1
   instance_class           = "db.t3.medium"


  }
}

rds = {
  main = {
    rds_type                   ="mysql"
    engine_version             = "5.7.mysql_aurora.2.11.3"
    engine_family              = "aurora-mysql5.7"
    db_port                    = 3306
    engine                     = "aurora-mysql"
    backup_retention_period    = 5
    preferred_backup_window    = "07:00-09:00"
    skip_final_snapshot     = true
    instance_count           = 1
    instance_class           = "db.t3.medium"

  }
}


elasticache = {
  main = {
    elasticache_type                   = "redis"
    engine_version                     = "6.2"
    family                             = "redis6.x"
    port                               = 6379
    engine                             = "redis"
    node_type                          = "cache.t3.micro"
    num_cache_nodes                    = 1
  }
}

rabbitmq = {
  main = {
    instance_type       = "t3.small"

  }
}

apps = {
  frontend = {
    instance_type    = "t3.micro"
    port             = 80
    desired_capacity = 1
    max_size         = 3
    min_siz          = 1
    lb_priority      = 1
    parameters       = []
    tags             = { Monitor_Nginx = "yes"}

  }

  catalogue = {
    instance_type    = "t3.micro"
    port             = 8080
    desired_capacity = 1
    max_size         = 3
    min_siz          = 1
    lb_priority      = 2
    parameters       = ["docdb"]
    tags             = {}

  }
  cart = {
    instance_type    = "t3.micro"
    port             = 8080
    desired_capacity = 1
    max_size         = 3
    min_siz          = 1
    lb_priority      = 3
    parameters       = []
    tags             = {}

  }
  user = {
    instance_type    = "t3.micro"
    port             = 8080
    desired_capacity = 1
    max_size         = 3
    min_siz          = 1
    lb_priority      = 4
    parameters       = ["docdb"]
    tags             = {}

  }
  shipping = {
    instance_type    = "t3.micro"
    port             = 8080
    desired_capacity = 1
    max_size         = 3
    min_siz          = 1
    lb_priority      = 5
    parameters       = ["rds"]
    tags             = {}

  }
  payment = {
    instance_type    = "t3.micro"
    port             = 8080
    desired_capacity = 1
    max_size         = 3
    min_siz          = 1
    lb_priority      = 6
    parameters       = ["rabbitmq"]
    tags             = {}

  }
  dispatch = {
    instance_type    = "t3.micro"
    port             = 8080
    desired_capacity = 1
    max_size         = 3
    min_siz          = 1
    lb_priority      = 7
    parameters       = []
    tags             = {}


  }
}