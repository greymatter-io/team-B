package wordpress

catalogservices: "wordpress": {
	name:        "Wordpress Site"
	description: "A Wordpress site."
	capability: ""
}

listeners: "wordpress": {
	port: 10808
	domain_keys: ["wordpress"]
	active_http_filters: [
		"gm.metrics",
		"gm.observables",
	]
	http_filters: {
		#gm_metrics_filter
		gm_observables: {
		 topic: "wordpress"
		}
	}
	secret: {
		secret_name:            "spiffe://greymatter.io/mesh-sample.wordpress"
		secret_validation_name: "spiffe://greymatter.io"
		subject_names: [
			"spiffe://greymatter.io/mesh-sample.edge",
			"spiffe://greymatter.io/mesh-sample.wordpress-edge",
		]
		ecdh_curves: [
			"X25519:P-256:P-521:P-384",
		]
		forward_client_cert_details: "APPEND_FORWARD"
		set_current_client_cert_details: {
			"uri": true
		}
	}
}
