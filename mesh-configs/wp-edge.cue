package wordpress


catalogservices: "wordpress-application-edge-color": {
	name:        "Wordpress Edge"
	description: "The database for the Wordpress site."
    documentation: "https://wordpress.next-gen-demo.greymatter.services"
    api_endpoint: "https://wordpress.next-gen-demo.greymatter.services"
}

routes: "wp-application-edge":{
    route_match:{
        path: "/services/wordpress"
        matchType: "prefix"
    }
    redirects: [{
        from: "^/services/wordpress$"
        name: ""
        redirect_type: "permanent"
        to: "/services/wordpress/"
    }]
    rules: [{
        constraints:{
            light:[{
                cluster_key: "wordpress"
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

proxies:"wordpress-application-edge-color": {
    domain_keys: ["wordpress-application-edge-color","wordpress-application-edge-color-egress-http","wordpress-application-edge-color-egress-tcp-to-gm-redis","wp-application-edge"]
    listener_keys: ["wordpress-application-edge-color","wordpress-application-edge-color-egress-http","wordpress-application-edge-color-egress-tcp-to-gm-redis","wp-application-edge"]
}