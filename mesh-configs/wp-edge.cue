package wordpress


catalogservices: "wordpress-application-edge": {
	name:        "Wordpress Edge"
	description: "The database for the Wordpress site."
    documentation: "https://wordpress.next-gen-demo.greymatter.services"
    api_endpoint: "https://wordpress.next-gen-demo.greymatter.services"
    capability: ""
}

routes: "wordpress-edge-to-wordpress": {
    route_match:{
        path: "/"
        match_type: "prefix"
    }
    rules: [{
        constraints:{
            light:[{
                cluster_key: "wordpress-edge-to-wordpress"
                weight: 1
            }]
        }
    }]
    domain_key: "wordpress-edge"
}


listeners: "wordpress-edge": {
    port: 10808
    domain_keys: ["wordpress-edge"]
    active_http_filters:[
        "gm.metrics"
    ]
    http_filters: {
        #gm_metrics_filter
    }
}