from diagrams import Cluster, Diagram, Node, Edge

from diagrams.onprem.container import Docker
from diagrams.onprem.ci import GithubActions
from diagrams.onprem.iac import Terraform
from diagrams.aws.storage import S3

from diagrams.aws.database import Dynamodb
from diagrams.aws.compute import Lambda
from diagrams.aws.security import IAM
from diagrams.aws.security import ACM
from diagrams.aws.network import APIGateway
from diagrams.aws.network import APIGatewayEndpoint
from diagrams.aws.network import CF
from diagrams.programming.language import Javascript
from diagrams.saas.cdn import Cloudflare
from diagrams.generic.device import Mobile

graph_attr = {
    "fontsize": "24",
    "bgcolor": "transparent",
    "constraint":"False",
    "splines":"spline",
}

edge_attr = {
    "splines":"spline",
    "concentrate":"True"
}

with Diagram("Test", show=False, 
        direction="TB", graph_attr=graph_attr, edge_attr=edge_attr, ) as diag :
    with Cluster("Github Action", direction="LR"):
        gh = GithubActions("")
    with Cluster("Container Spawn", direction="LR"):
        dc = Docker("")
    with Cluster("Setup Terraform and State"):
        tf = Terraform("Terraform")
        stf = S3("Load State TF from S3")

    with Cluster("Create Table for totalViewer\nCreate Lambda Function\nSet Lambda Function url to AGW"):
        dynamo1 = Dynamodb("dynamodb")
        lambda1 = Lambda("lambda")
        agw = APIGateway("agw")
        iam1 = IAM("Setup Policy for Lambda, Dynamodb, AGW")
        [agw, lambda1, dynamo1] >> Edge(color="blue", style="dashed", penwidth="1.0") << iam1

    with Cluster("Deploy API"):
        agw_endpoint = APIGatewayEndpoint("totalViewer\nFunction")

    with Cluster("Create .js and\nSet AGW url"):
        js = Javascript(".js")

    with Cluster("Create bucket\nUpload html,css,js"):
        S3_bucket = S3("Website Bucket")

    with Cluster("Create ACM for Cloudfront\nSet up CNAME from ACM and Cloudfront\nSet up Policy S3"):
        aws_cfront = CF("Cloudfront")
        aws_ACM = ACM("Certificate")
        cf = Cloudflare("Cloudflare")
        aws_cfront << Edge(color="blue", style="dashed", penwidth="1.0", minlen="1") << aws_ACM
        aws_ACM >> Edge(color="blue", style="dashed", penwidth="1.0" , minlen="0") >> cf
        aws_cfront >> Edge(color="blue", style="dashed", penwidth="1.0" , minlen="1") >> cf

    with Cluster(""):
        dc2 = Docker("Container Destroyed\nJobs done")
        prod = Mobile("User can \naccess Website")
    
    gh >> Edge(color="blue", style="dashed", penwidth="2.0", minlen="0") >> dc
    dc >> Edge(color="blue", style="dashed", penwidth="2.0", minlen="0") >> tf
    tf >> Edge(color="blue", style="dashed", penwidth="2.0", minlen="1") << stf
    tf >> Edge(color="blue", style="dashed", penwidth="2.0", minlen="0") >> dynamo1
    dynamo1 >> Edge(color="blue", style="dashed", penwidth="2.0", minlen="0") >> lambda1
    lambda1 >> Edge(color="blue", style="dashed", penwidth="2.0", minlen="0") >> agw
    agw_endpoint << Edge(color="blue", style="dashed", penwidth="1.0", minlen="0") << agw
    agw_endpoint >> Edge(color="blue", style="dashed", penwidth="2.0", minlen="0") >> js
    js >> Edge(color="blue", style="dashed", penwidth="2.0", minlen="0") >> S3_bucket
    S3_bucket >> Edge(color="blue", style="dashed", penwidth="2.0", minlen="1") << aws_cfront
    aws_cfront >> Edge(color="blue", style="dashed", penwidth="2.0", minlen="1") >> dc2
    aws_cfront >> Edge(color="blue", style="dashed", penwidth="2.0", minlen="1") >> prod
diag
