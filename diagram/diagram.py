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

with Diagram("\n\nKubernetes", show=False, 
        direction="TB", graph_attr=graph_attr, edge_attr=edge_attr, ) as diag:
    
    with Cluster("K8 Control Node"):
        etcd = Custom("etcd", "etcd.png")
        api = API("Server")
        sched = Sched("")
        ctrl_man = CM("Control")

    with Cluster("Worker Node 1"):
        kub1 = Kubelet("")
        KProxy("")
        with Cluster(""):
            pod1_1 = Custom("pod 1", "pod_w_docker.png")
            pod1_2 = Custom("pod 2", "pod_w_docker.png")
            kub1 - Edge(color="blue", style="dashed", penwidth="2.0") >> [pod1_1, pod1_2]

    with Cluster("Worker Node 2"):
        kub2 = Kubelet("")
        KProxy("")
        with Cluster(""):
            pod2_1 = Custom("pod 1", "pod_w_docker.png")
            pod2_2 = Custom("pod 2", "pod_w_docker.png")
            kub2 - Edge(color="blue", style="dashed", penwidth="2.0") >> [pod2_1, pod2_2]

    with Cluster("Worker Node .. n"):
        KProxy("")
        kub3 = Kubelet("")
        with Cluster(""):
            pod3_1 = Custom("pod 1", "pod_w_docker.png")
            pod3_2 = Custom("pod 2", "pod_w_docker.png")
            kub3 - Edge(color="blue", style="dashed", penwidth="2.0") >> [pod3_1, pod3_2]

    api << Edge(color="blue", style="dashed", penwidth="2.0", minlen="1") << sched
    api << Edge(color="blue", style="dashed", penwidth="2.0", minlen="1", constraint="False",) << ctrl_man
    etcd << Edge(color="blue", style="dashed", penwidth="2.0", minlen="2", constraint="False",) << api

    sched - Edge(penwidth="3.0",  minlen="0") - ctrl_man

    api << Edge(minlen="2") << [kub1, kub2, kub3]

diag
