// package wordpress


catalogservices: "wordpress-application-edge": {
	name:        "Wordpress Edge"
	description: "The database for the Wordpress site."
    documentation: "https://wordpress.next-gen-demo.greymatter.services"
    api_endpoint: "https://wordpress.next-gen-demo.greymatter.services"
    capability: ""
}

routes: "wp-application-edge":{
    route_match:{
        path: "/"
        match_type: "prefix"
    }
    rules: [{
        constraints:{
            light:[{
                cluster_key: "wordpress"
                weight: 1
            }]
        }
    }]
    domain_key: "wordpress-application-edge"
}

domains: "wp-application-edge":{
    port: 10809
    custom_headers: [
		{
			key:   "x-forwarded-proto"
			value: "https"
		},
	]
}

listeners: "wp-application-edge":{
    port: 10809
    domain_keys: ["wp-application-edge"]
    active_http_filters:[
        "gm.metrics"
    ]
    http_filters: {
        #gm_metrics_filter
    }
}

proxies:"wordpress-application-edge": {
    domain_keys: ["wordpress-application-edge","wordpress-application-edge-egress-http","wordpress-application-edge-egress-tcp-to-gm-redis","wp-application-edge"]
    listener_keys: ["wordpress-application-edge","wordpress-application-edge-egress-http","wordpress-application-edge-egress-tcp-to-gm-redis","wp-application-edge"]
}