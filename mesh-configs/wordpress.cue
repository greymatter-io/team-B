package wordpress

// Domains for the Wordpress Site
domains: "team-b-wordpress-ingress": {
    port: 10808
}
domains: "team-b-wordpress-egress": {
	port: 10909
}
domains: "team-b-wordpress-team-b-wordpressDB-egress": {
	port: 3306
}

listeners: "team-b-wordpress-ingress-listener": {
    port: 10808
    domain_keys: ["team-b-wordpress-ingress"]
    active_http_filters: [
        "gm.metrics",
        "gm.oidc-authentication",
		"gm_observables"
    ]
    http_filters: {
        #gm_metrics
		"gm_observables": {}
        "gm_oidc-authentication": {
			"accessToken": {
				"location": 1
				"key": "access_token"
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
listeners: "team-b-wordpress-egress-listener": {
	port: 10909
    domain_keys: ["team-b-wordpress-egress"]
    active_http_filters: [
		"gm_inheaders"
    ]
    http_filters: {
		"gm_inheaders": {}
	}
}
listeners: "team-b-wordpress-wordpressDB-egress-listener": {
	domain_keys: ["team-b-wordpress-team-b-wordpressDB-egress"]
	port: 3306
	ip: "127.0.0.1"
	active_network_filters: ["envoy.tcp_proxy"]
	network_filters: {
		"envoy_tcp_proxy": {
			"stat_prefix": "team-b-wordpress-tcp",
			"cluster": "wordpressDB"
		}
    }
}

routes: "wordpress-local": {
	domain_key: "team-b-wordpress-ingress"
	path: "/"
}

routes: "route-team-b-wordpress-wordpressDB": {
	domain_key: "team-b-wordpress-team-b-wordpressDB-egress"
	rules: [{
		constraints: {
			light: [{
				cluster_key: "wordpressDB"
				weight:      1
			}]
		}
	}]
}

proxies: wordpress: {
    domain_keys: ["team-b-wordpress-ingress", "team-b-wordpress-egress", "team-b-wordpress-team-b-wordpressDB-egress"]
    listener_keys: ["team-b-wordpress-ingress-listener", "team-b-wordpress-egress-listener", "team-b-wordpress-wordpressDB-egress-listener"]
}
