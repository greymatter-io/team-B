package wordpress

domains: "wordpress-ingress": {
	port: 10808
	name: "workpress"
}

listeners: "wordpress-ingress": {
	port: 10808
	domain_keys: ["wordpress"]
	active_http_filters: [
		"gm.metrics",
		"gm.oidc-authentication",
	]
	http_filters: {
		#commonMetrics
		"gm_oidc-authentication": {
			"accessToken": {
				"location": 1
				"key":      "access_token"
				"cookieOptions": {
					"httpOnly": true
					"maxAge":   "6h"
					"domain":   "a6e293bb0b6ea4f0ab5082f30ae242b0-553823424.us-east-1.elb.amazonaws.com"
					// "domain":   "subdomain.greymatter.services"
					"path": "/"
				}
			}
			"idToken": {
				"location": 1
				"key":      "authz_token"
				"cookieOptions": {
					"httpOnly": true
					"maxAge":   "6h"
					"domain":   "a6e293bb0b6ea4f0ab5082f30ae242b0-553823424.us-east-1.elb.amazonaws.com"
					// "domain":   "subdomain.greymatter.services"
					"path": "/"
				}
			}
			"tokenRefresh": {
				"enabled":   true
				"endpoint":  "http://keycloak.greymatter.services:8080"
				"realm":     "greymatter"
				"timeoutMs": 5000
				"useTLS":    false
			}
			"serviceUrl":   "http://a6e293bb0b6ea4f0ab5082f30ae242b0-553823424.us-east-1.elb.amazonaws.com:10808"
			"callbackPath": "/oauth"
			"provider":     "http://keycloak.greymatter.services:8080/auth/realms/greymatter"
			"clientId":     "edge"
			"clientSecret": "3a4522e4-6ed0-4ba6-9135-13f0027c4b47"
			"additionalScopes": ["openid"]
		}
	}
}

clusters: wordpress: {
	require_tls: true
	instances: [
		{
			host: "localhost"
			port: 1234
		},
	]
}

proxies: wordpress: {
	domain_keys: ["wordpress-ingress"]
	listener_keys: ["wordpress-ingress"]
}

#commonMetrics: gm_metrics: {
	metrics_host:                               "0.0.0.0"
	metrics_port:                               "8081"
	metrics_dashboard_uri_path:                 "/metrics"
	metrics_prometheus_uri_path:                "prometheus"
	metrics_ring_buffer_size:                   4096
	prometheus_system_metrics_interval_seconds: 15
	metrics_key_function:                       "depth"
	metrics_key_depth:                          "1"
}
