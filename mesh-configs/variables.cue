package wordpress

#zone:          "default-zone"
#allInterfaces: "0.0.0.0"
#localhost:     "127.0.0.1"
#gm_metrics: gm_metrics: {
            metrics_host:                               "0.0.0.0"
            metrics_port:                               "8081"
            metrics_dashboard_uri_path:                 "/metrics"
			metrics_prometheus_uri_path:                "prometheus"
			metrics_ring_buffer_size:                   4096
			prometheus_system_metrics_interval_seconds: 15
			metrics_key_function:                       "depth"
			metrics_key_depth:                          "1"
        	}