vpc = {
 main = {
  cidr      = "10.0.0.0/16"
  subnets = {
     public = {
       public1 = { cidr = "10.0.0.0/24" , az = "us-east-1a"}
       public2 = { cidr = "10.0.1.0/24" , az = "us-east-1a"}
     }
     app = {
        app1 = { cidr = "10.0.2.0/24" , az = "us-east-1a"}
        app2 = { cidr = "10.0.3.0/24" , az = "us-east-1a"}
   }
    db = {
    db1 = { cidr = "10.0.4.0/24" , az = "us-east-1a"}
    db2 = { cidr = "10.0.5.0/24" , az = "us-east-1a"}
   }
  }

}
}

default_vpc_id = "vpc-0ea00bb90d84e71e1"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_route_table_id ="rtb-0dc27a26c8b542a80"
