// package wordpress


// catalogservices: "wordpressdb": {
// 	name:         "Grey Matter Wordpress Database"
// 	description:  "The database for the wordpress site for information about the mesh."
// 	mesh_id: "default-zone"
// 	service_id: "wordpressdb"
// }


// Domains for the wordpressdb Site
domains: "wordpressdb": {
    port: 3306
}

listeners: "wordpressdb": {
    port: 3306
    domain_keys: ["wordpressdb"]
    active_network_filters: ["envoy.tcp_proxy"]
	network_filters: {
		"envoy_tcp_proxy": {
			"stat_prefix": "wordpressdb-tcp",
			"cluster": "wordpressdb:3306"
		}
    }
}

proxies: wordpressdb: {
    domain_keys: ["wordpressdb"]
    listener_keys: ["wordpressdb"]
}