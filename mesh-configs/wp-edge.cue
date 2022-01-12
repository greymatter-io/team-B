package wordpress

catalogservices: "wordpress-edge": {
	name:          "Wordpress Edge"
	description:   "The edge node for the Wordpress site."
	owner:         "Team B"
	owner_url:     "https://github.com/greymatter-io/team-b"
	documentation: "https://wordpress.next-gen-demo.greymatter.services"
	api_endpoint:  "https://wordpress.next-gen-demo.greymatter.services"
	capability:    "web"
}

routes: "wordpress-edge-to-wordpress": {
	route_match: {
		path:       "/"
		match_type: "prefix"
	}
	rules: [{
		constraints: {
			light: [
				{
				cluster_key: "wordpress-edge-to-wordpress"
				weight:      1
				},
				{
				cluster_key: "wordpress-edge-to-wordpressnew"
				weight:      0
				}
			]
		}
	}]
	domain_key: "wordpress-edge"
}

listeners: "wordpress-edge": {
	port: 10808
	domain_keys: ["wordpress-edge"]
	active_http_filters: [
		"gm.metrics",
	]
	http_filters: {
		#gm_metrics_filter
	}
}
