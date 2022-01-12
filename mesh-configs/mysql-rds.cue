// package wordpress

listeners: "mysql-rds": {
	"active_network_filters": [
		"envoy.tcp_proxy",
	]
	"network_filters": {
		"envoy_tcp_proxy": {
			"cluster":     "mysql-rds-to-mysql-rds:3306"
			"stat_prefix": "mysql-rds-to-mysql-rds:3306"
		}
	}
	"ip":       "0.0.0.0"
	"port":     10808
	"protocol": "http_auto"
	"domain_keys": ["mysql-rds"]
	"secret": {
	 "secret_name":            "spiffe://greymatter.io/mesh-sample.mysql-rds"
	 "secret_validation_name": "spiffe://greymatter.io"
	 "subject_names": [
	  "spiffe://greymatter.io/mesh-sample.wordpressnew",
	  "spiffe://greymatter.io/mesh-sample.wordpress",
	 ]
	 "ecdh_curves": [
	  "X25519:P-256:P-521:P-384",
	 ]
	 "forward_client_cert_details": "APPEND_FORWARD"
	 "set_current_client_cert_details": {
	  "uri": false
	 }
	}
}

// routes: "mysql-rds:3306": {
// 	domain_key: "mysql-rds"
// 	route_match: {
// 		path:       "/"
// 		match_type: "prefix"
// 	}
// 	rules: [
// 		{
// 			constraints: {
// 				light: [
// 					{
// 						cluster_key: "mysql-rds-to-mysql-rds:3306"
// 						weight:      1
// 					},
// 				]
// 			}
// 		},
// 	]
// }

clusters: "mysql-rds-to-mysql-rds:3306": {
	instances: [{
		host: "capital-one-demo.cnkwv7bcyhsc.us-east-1.rds.amazonaws.com"
		port: 443
	}]
	ssl_config: {
		protocols: ["TLSv1.2"]
		require_client_certs: false
		sni:                  "capital-one-demo.cnkwv7bcyhsc.us-east-1.rds.amazonaws.com"
	}
	require_tls: true
}
