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
        "gm.oidc-authentication"
    ]
    http_filters: {
        #gm_metrics
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

routes: wordpress: {
	domain_key: "wordpress-ingress"
	path: "/"
}


proxies: wordpress: {
    domain_keys: ["wordpress-ingress"]
    listener_keys: ["wordpress-ingress"]
}
