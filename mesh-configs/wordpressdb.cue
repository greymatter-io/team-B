// package wordpressDB

// Domains for the wordpressDB Site
domains: "team-b-wordpressDB-ingress": {
    port: 10808
}

listeners: "team-b-wordpressDB-ingress-listener": {
    port: 10808
    domain_keys: ["team-b-wordpressDB-ingress"]
    active_network_filters: ["envoy.tcp_proxy"]
	network_filters: {
		"envoy_tcp_proxy": {
			"stat_prefix": "team-b-wordpressdb-tcp",
			"cluster": "wordpressDB-local"
		}
    }
}

routes: "wordpressDB-local": {
	domain_key: "team-b-wordpressDB-ingress"
	path: "/"
}

proxies: wordpressDB: {
    domain_keys: ["team-b-wordpressDB-ingress"]
    listener_keys: ["team-b-wordpressDB-ingress-listener"]
}