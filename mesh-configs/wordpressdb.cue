package wordpress

// Domains for the wordpressdb Site
domains: "wordpressdb": {
    port: 10808
}

listeners: "wordpressdb": {
    port: 10808
    domain_keys: ["team-b-wordpressdb-ingress"]
    active_network_filters: ["envoy.tcp_proxy"]
	network_filters: {
		"envoy_tcp_proxy": {
			"stat_prefix": "team-b-wordpressdb-tcp",
			"cluster": "wordpressdb:3306"
		}
    }
}

proxies: wordpressdb: {
    domain_keys: ["wordpressdb"]
    listener_keys: ["wordpressdb"]
}