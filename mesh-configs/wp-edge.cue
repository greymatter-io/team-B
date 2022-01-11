package wordpress


catalogservices: "wordpress-application-edge-color": {
	name:        "Wordpress Edge"
	description: "The database for the Wordpress site."
}

routes: "wp-application-edge":{
    route_match:{
        path: "/"
        matchType: "prefix"
    }
    rules: [{
        constraints:{
            light:[{
                cluster_key: "wordpress:80"
                weight: 1
            }]
        }
    }]
    domain_key: "wp-application-edge"
}

domains: "wp-application-edge": port: 10912

listeners: "wp-application-edge":{
    port: 443
    domain_keys: ["wp-application-edge"]
    active_http_filters:[
        "gm.metrics"
    ]
    http_filters: {
        #gm_metrics_filter
    }
}