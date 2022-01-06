package wiki

import (
	"github.com/greymatter-io/greymatter"
	"teamb.io/common"
)

// Domain 
domains: [Name=_]: greymatter.#Domain & {
	name:       string | *"*"
	domain_key: Name
	zone_key:   common.#zone
}

// Listener
listeners: [Name=_]: greymatter.#Listener & {
	name:         Name
	listener_key: Name
	zone_key:     common.#zone
	ip:           common.#allInterfaces
	protocol:     "http_auto"
}

// Cluster
clusters: [Name=_]: greymatter.#Cluster & {
	name:        Name
	cluster_key: Name
	zone_key:    common.#zone
}

// Proxy
proxies: [Name=_]: greymatter.#Proxy & {
	proxy_key: Name
	name:      Name
	zone_key:  common.#zone
}

// Route
routes: [Name=_]: greymatter.#Route & {
	zone_key:    common.#zone
	route_key:   Name
	route_match: greymatter.#RouteMatch | *{path: "/", match_type: "prefix"}
}
